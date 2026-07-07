const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const path = require("path");

const app = express();
const server = http.createServer(app);
const io = new Server(server, { cors: { origin: "*" } });

app.use(express.static(path.join(__dirname)));
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "player.html"));
});
app.get("/state", (req, res) => {
  res.json(getPublicState());
});
let lastEmote = null;

app.get("/emotes", (req, res) => {
  res.json(lastEmote || {});
});
function createDeck() {
  const cards = [];
  const colors = ["R", "G", "B", "Y"];
  for (const color of colors) {
    for (let i = 0; i <= 9; i++) cards.push({ name: color + i, color, number: i });
    cards.push({ name: color + "X", color, number: -1 });
    cards.push({ name: color + "R", color, number: -2 });
    cards.push({ name: color + "+", color, number: -3 });
    cards.push({ name: "WW", color: "W", number: -4 });
  }
  for (let i = cards.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [cards[i], cards[j]] = [cards[j], cards[i]];
  }
  return cards;
}

let deck = createDeck();
let players = {};
let playerOrder = [];
let currentTurn = 0;
let topCard = deck.pop();
let waitingForColor = false;

function drawOne() {
  return deck.length > 0 ? deck.pop() : null;
}

function getPublicState() {
  return {
    topCard,
    currentPlayerId: playerOrder[currentTurn],
    currentPlayerName: players[playerOrder[currentTurn]]?.name || "",
    playerIds: playerOrder,
    playerNames: playerOrder.map(id => players[id]?.name),
    cardCounts: playerOrder.map(id => players[id]?.cards.length),
  };
}

function broadcastState() {
  playerOrder.forEach(id => {
    if (players[id]) io.to(id).emit("your_hand", players[id].cards);
  });
  io.emit("game_state", getPublicState());
}

function nextTurn(skip = false) {
  currentTurn = (currentTurn + 1) % playerOrder.length;
  if (skip) currentTurn = (currentTurn + 1) % playerOrder.length;
}

io.on("connection", (socket) => {
  console.log("Connected:", socket.id);

  socket.on("tv_join", () => {
    console.log("TV connected");
    socket.emit("game_state", getPublicState());
  });

socket.on("join", (name) => {
    // Reset game if no players or deck is empty
    if (playerOrder.length === 0 || deck.length < 7) {
      deck = createDeck();
      topCard = deck.pop();
      currentTurn = 0;
    }
    
    const hand = [drawOne(), drawOne(), drawOne(), drawOne(), drawOne(), drawOne(), drawOne()].filter(Boolean);
    players[socket.id] = { name, cards: hand };
    playerOrder.push(socket.id);
    console.log(name + " joined. Hand: " + hand.length + " cards");
    socket.emit("your_hand", hand);
    broadcastState();
  });

  socket.on("send_emote", (emoteName) => {
      const player = players[socket.id];
      if (!player) return;
      lastEmote = { name: player.name, emote: emoteName, time: Date.now() };
      io.emit("show_emote", { name: player.name, emote: emoteName });
    });

  socket.on("play_card", (card) => {
    if (playerOrder[currentTurn] !== socket.id) {
      socket.emit("error_msg", "It's not your turn!");
      return;
    }
    if (waitingForColor) {
      socket.emit("error_msg", "Waiting for color choice!");
      return;
    }

    const player = players[socket.id];
    if (!player) return;

    const valid = card.color === topCard.color ||
                  card.number === topCard.number ||
                  card.number === -4;
    if (!valid) {
      socket.emit("error_msg", "Can't play " + card.name + " on " + topCard.name + "!");
      return;
    }

    const idx = player.cards.findIndex(c => c.name === card.name);
    if (idx === -1) { socket.emit("error_msg", "You don't have that card!"); return; }
    player.cards.splice(idx, 1);
    topCard = card;

    if (player.cards.length === 0) {
      io.emit("game_over", player.name + " wins!");
      broadcastState();
      return;
    }

    if (card.number === -4) {
      waitingForColor = true;
      socket.emit("pick_color");
      broadcastState();
      return;
    }

    if (card.number === -3) {
      const nextIdx = (currentTurn + 1) % playerOrder.length;
      const nextPlayer = players[playerOrder[nextIdx]];
      if (nextPlayer) {
        const c1 = drawOne(), c2 = drawOne();
        if (c1) nextPlayer.cards.push(c1);
        if (c2) nextPlayer.cards.push(c2);
      }
      nextTurn(true);
      broadcastState();
      return;
    }

    const skip = card.number === -1 || card.number === -2;
    nextTurn(skip);
    broadcastState();
  });

  socket.on("wild_color", (color) => {
    if (playerOrder[currentTurn] !== socket.id) return;
    topCard = { name: color + "W", color: color, number: -4 };
    waitingForColor = false;
    nextTurn(false);
    broadcastState();
  });

  socket.on("draw_card", () => {
    if (playerOrder[currentTurn] !== socket.id) {
      socket.emit("error_msg", "It's not your turn!");
      return;
    }
    if (waitingForColor) return;
    const player = players[socket.id];
    if (!player) return;
    const newCard = drawOne();
    if (newCard) player.cards.push(newCard);
    nextTurn(false);
    broadcastState();
  });

  socket.on("disconnect", () => {
    const idx = playerOrder.indexOf(socket.id);
    if (idx !== -1) {
      playerOrder.splice(idx, 1);
      delete players[socket.id];
      if (currentTurn >= playerOrder.length) currentTurn = 0;
      if (playerOrder.length > 0) broadcastState();
    }
  });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, "0.0.0.0", () => {
  console.log("Server running on port " + PORT);
});
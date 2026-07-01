sub __Deck_method_new(cards as object)
    m.cards = invalid
    m.cards = cards
end sub
function __Deck_method_drawCard() as object
    if m.cards.count() = 0 then
        return invalid
    end if
    return m.cards.pop()
end function
function __Deck_method_drawRandomCard() as object
    if m.cards.count() = 0 then
        return invalid
    end if
    randomIndex = int(Rnd(m.cards.count()) - 1)
    cardDrawn = m.cards[randomIndex]
    ' m.cards.delete(randomIndex)
    return cardDrawn
end function
function __Deck_method_addCard(cardAdded as object) as void
    m.cards.push(cardAdded)
end function
function __Deck_builder()
    instance = {}
    instance.new = __Deck_method_new
    instance.drawCard = __Deck_method_drawCard
    instance.drawRandomCard = __Deck_method_drawRandomCard
    instance.addCard = __Deck_method_addCard
    ' public function shuffleDeck() as void
    '     m.cards.shuffle()
    ' end function
    return instance
end function
function Deck(cards as object)
    instance = __Deck_builder()
    instance.new(cards)
    return instance
end function

sub createUnoDeck() as object
    deckCards = []
    colors = [
        "R"
        "G"
        "B"
        "Y"
    ]
    for each color in colors
        for i = 0 to 9
            deckCards.push(Card(color + i.toStr(), "", color, i))
        end for
        deckCards.push(Card(color + "X", "", color, -1))
        deckCards.push(Card(color + "R", "", color, -2))
        deckCards.push(Card(color + "+", "", color, -3))
        deckCards.push(Card("WW", "", "W", -4))
        deckCards.push(Card(color + "X", "", color, -1))
        deckCards.push(Card(color + "R", "", color, -2))
        deckCards.push(Card(color + "+", "", color, -3))
        deckCards.push(Card("WW", "", "W", -4))
    end for
    return Deck(deckCards)
end sub
sub __Card_method_new(name as string, iconUri as string, color as string, number as integer)
    m.name = invalid
    m.iconUri = invalid
    m.name = name
    m.iconUri = iconUri
    m.color = color
    m.number = number
end sub
function __Card_method_getName() as string
    return m.name
end function
function __Card_method_getIconUri() as string
    return m.iconUri
end function
function __Card_builder()
    instance = {}
    instance.new = __Card_method_new
    instance.getName = __Card_method_getName
    instance.getIconUri = __Card_method_getIconUri
    return instance
end function
function Card(name as string, iconUri as string, color as string, number as integer)
    instance = __Card_builder()
    instance.new(name, iconUri, color, number)
    return instance
end function
sub __Player_method_new(name as string, totalActions as integer, remainingActions as integer, cards as object, selectedCard as object)
    m.selectedCard = invalid
    m.name = invalid
    m.totalActions = invalid
    m.remainingActions = invalid
    m.cards = []
    m.name = name
    m.totalActions = totalActions
    m.remainingActions = remainingActions
    m.cards = cards
    m.selectedCard = selectedCard
end sub
function __Player_method_getName() as string
    return m.name
end function
function __Player_method_getTotalActions() as integer
    return m.totalActions
end function
function __Player_method_setTotalActions(totalActions as integer) as void
    m.totalActions = totalActions
end function
function __Player_method_getRemainingActions() as integer
    return m.remainingActions
end function
function __Player_method_setRemainingActions(remainingActions as integer) as void
    m.remainingActions = remainingActions
end function
function __Player_method_addCard(cardAdded as object) as void
    m.cards.push(cardAdded)
end function
function __Player_method_containsCards(cardsChecking as object) as boolean
    copyArray = m.cards.clone()
    for each c in cardsChecking
        found = false
        for each cc in copyArray
            if c.getName() = cc.getName() then
                found = true
                copyArray.remove(cc)
                exit for
            end if
        end for
        if not found then
            return false
        end if
    end for
    return true
end function
function __Player_method_removeCards(cardsRemoving as object) as void
    for each c in cardsRemoving
        for i = 0 to m.cards.count() - 1
            pc = m.cards[i]
            if c.name = pc.name then
                m.cards.delete(i)
                exit for
            end if
        end for
    end for
end function
function __Player_method_getCards() as object
    return m.cards
end function
function __Player_method_getCard(index as integer) as object
    return m.cards[index]
end function
function __Player_method_removeCard(index as integer) as void
    m.cards.delete(index)
end function
function __Player_method_selectCard(cardSelect as object) as void
    m.selectedCard = cardSelect
end function
function __Player_method_getSelectedCard() as object
    return m.selectedCard
end function
function __Player_builder()
    instance = {}
    instance.new = __Player_method_new
    instance.getName = __Player_method_getName
    instance.getTotalActions = __Player_method_getTotalActions
    instance.setTotalActions = __Player_method_setTotalActions
    instance.getRemainingActions = __Player_method_getRemainingActions
    instance.setRemainingActions = __Player_method_setRemainingActions
    instance.addCard = __Player_method_addCard
    instance.containsCards = __Player_method_containsCards
    instance.removeCards = __Player_method_removeCards
    instance.getCards = __Player_method_getCards
    instance.getCard = __Player_method_getCard
    instance.removeCard = __Player_method_removeCard
    instance.selectCard = __Player_method_selectCard
    instance.getSelectedCard = __Player_method_getSelectedCard
    return instance
end function
function Player(name as string, totalActions as integer, remainingActions as integer, cards as object, selectedCard as object)
    instance = __Player_builder()
    instance.new(name, totalActions, remainingActions, cards, selectedCard)
    return instance
end function
sub __Action_method_new(name as string)
    m.avaliability = invalid
    m.name = invalid
    m.name = name
end sub
function __Action_method_getName() as string
    return m.name
end function
function __Action_method_checkAvailability(playera as object) as boolean
    return true
end function
function __Action_method_runAction(playera as object) as void
    'do something
end function
function __Action_builder()
    instance = {}
    instance.new = __Action_method_new
    instance.getName = __Action_method_getName
    instance.checkAvailability = __Action_method_checkAvailability
    instance.runAction = __Action_method_runAction
    return instance
end function
function Action(name as string)
    instance = __Action_builder()
    instance.new(name)
    return instance
end function
sub __drawCard_method_new(name as string)
    m.super0_new(name)
end sub
sub __drawCard_method_checkAvailability(playera as object) as boolean
    m.avaliability = true
    return true
end sub
sub __drawCard_method_runAction(playera as object) as void
    Players = loadPlayers()
    currentPlayer = loadCurrentPlayer()
    m.global = GetGlobalAA().global
    unoDeck = loadUnoDeck()
    playerSub = Players[currentPlayer]
    playerSub.addCard(unoDeck.drawRandomCard())
    print playerSub.getCards().count()
    displayCards(playerSub)
    Players.SetEntry(m.global.currentPlayer, playerSub)
    updatePlayerList(Players)
    updateUnoDeck(unoDeck)
    nextTurn()
end sub
function __drawCard_builder()
    instance = __Action_builder()
    instance.super0_new = instance.new
    instance.new = __drawCard_method_new
    instance.super0_checkAvailability = instance.checkAvailability
    instance.checkAvailability = __drawCard_method_checkAvailability
    instance.super0_runAction = instance.runAction
    instance.runAction = __drawCard_method_runAction
    return instance
end function
function drawCard(name as string)
    instance = __drawCard_builder()
    instance.new(name)
    return instance
end function
sub __playCard_method_new(name as string)
    m.super0_new(name)
end sub
sub __playCard_method_checkAvailability(playera as object) as boolean
    print playera.selectedCard
    m.global = GetGlobalAA().global
    if playera.selectedCard = invalid then
        m.avaliability = false
        return false
    end if
    if playera.selectedCard.color = m.global.topCard.color or playera.selectedCard.number = m.global.topCard.number or playera.selectedCard.number = -4 then
        m.avaliability = true
        return true
    else
        m.avaliability = false
        return false
    end if
end sub
sub __playCard_method_runAction(playera as object) as void
    m.global = GetGlobalAA().global
    topcard = Card(playera.selectedCard.name, playera.selectedCard.iconUri, playera.selectedCard.color, playera.selectedCard.number)
    print playera.selectedCard
    topcard = playera.selectedCard
    print "Playing Card: " + topcard.number.toStr() + " of color " + topcard.color
    playera.removeCards([
        topcard
    ])
    playera.selectCard(invalid)
    ' displayCards(playera)
    ' updateActions(playera)
    updateTopCardDisplay(topcard.name)
    unoDeck = loadUnoDeck()
    Players = loadPlayers()
    Players.SetEntry(m.global.currentPlayer, playera)
    '  if (m.global.currentPlayer + 1) >= loadPlayers().count() then
    '     nextPlayerIndex = 0
    '  else
    '     nextPlayerIndex = m.global.currentPlayer + 1
    '  end if
    if (playera.getCards().count() = 0)
        print playera.name + " wins!"
        displayPlayerName(playera.name + " wins!")
        displayCards(playera)
    end if
    if (playera.getCards().count() <> 0)
        if (topcard.number = -4)
            updatePlayerList(Players)
            displaySelectionColors()
            return
        end if
        if (topcard.number <> -4)
            updateSelecting(false)
            updatePlayerList(Players)
            '  updateCurrentPlayer(nextPlayerIndex)
            updateUnoDeck(unoDeck)
            updateTopCard(topcard)
            nextTurn()
            if (topcard.number = -1)
                nextTurn()
            end if
            if (topcard.number = -2)
                nextTurn()
            end if
            if (topcard.number = -3)
                Players = loadPlayers()
                unoDeck = loadUnoDeck()
                Players[m.global.currentPlayer].addCard(unoDeck.drawRandomCard())
                Players[m.global.currentPlayer].addCard(unoDeck.drawRandomCard())
                updatePlayerList(Players)
                displayCards(Players[m.global.currentPlayer])
            end if
            ' updateStoredValues(PlayersSub, nextPlayerIndex, m.global.unoDeck, topcard)
            testFocus()
        end if
    end if
    ' m.playerCards = m.top.findNode("playerCards")
    ' m.playerCards.focusButton = 0
end sub
function __playCard_builder()
    instance = __Action_builder()
    instance.super0_new = instance.new
    instance.new = __playCard_method_new
    instance.super0_checkAvailability = instance.checkAvailability
    instance.checkAvailability = __playCard_method_checkAvailability
    instance.super0_runAction = instance.runAction
    instance.runAction = __playCard_method_runAction
    return instance
end function
function playCard(name as string)
    instance = __playCard_builder()
    instance.new(name)
    return instance
end function

' end classes end  end classes classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes
' end classes end  end classes classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes end classes
sub loadActions() as object
    allActions = []
    allActions.push(drawCard("Draw Card"))
    allActions.push(playCard("Play Card"))
    return allActions
end sub

sub checkAvailableActions(playera as object, allActions as object) as object
    availableActions = []
    for each a in allActions
        if a.checkAvailability(playera) then
            availableActions.push(a)
        end if
    end for
    return availableActions
end sub

sub updateActions(playera as object) as void
    allActions = loadActions()
    availableActions = checkAvailableActions(playera, allActions)
    displayActions(availableActions)
end sub

sub doAction(name as string, playera as object) as void
    actionList = loadActions()
    currentPlayer = loadCurrentPlayer()
    playerb = loadPlayers()[currentPlayer]
    for each actionNeeded in actionList
        if actionNeeded.getName() = name then
            actionNeeded.runAction(playerb)
            exit for
        end if
    end for
end sub

sub displayCards(playera as object) as void
    tempCardDisplay = []
    m.playerCards.buttons = []
    
    print "Displaying Cards:"
    for each c in playera.getCards()
        print "- " + c.name
        tempCardDisplay.push(c.name)
    end for
    
    ' Generate the buttons
    m.playerCards.buttons = tempCardDisplay
    m.cardBackgrounds.removeChildrenIndex(m.cardBackgrounds.getChildCount(), 0)
    ' --- NEW CODE: Apply colors to the generated cards ---
for i = 0 to playera.getCards().count() - 1
    childButton = m.playerCards.getChild(i)
    cardData = playera.getCard(i)
    
    if childButton <> invalid
        ' 1. CRITICAL FIX: Clear the button's internal icon so it stops pushing the text!
        
        ' 2. Create the background poster
        cardBackground = CreateObject("roSGNode", "Poster")
        
        ' 3. Assign the correct colored image
        if cardData.color = "R" then
            cardBackground.uri = "pkg:/images/red1.png"
        else if cardData.color = "G" then
            cardBackground.uri = "pkg:/images/green1.png"
        else if cardData.color = "B" then
            cardBackground.uri = "pkg:/images/blue1.png"
        else if cardData.color = "Y" then
            cardBackground.uri = "pkg:/images/yellow1.png"
        else if cardData.color = "W" then
            cardBackground.uri = "pkg:/images/purple2.png"
        end if
         if cardData.color = "R" then
                childButton.focusFootprintBitmapUri = "pkg:/images/god.png"
                childButton.focusBitmapUri = "pkg:/images/god.png"
            else if cardData.color = "G" then
                childButton.focusFootprintBitmapUri = "pkg:/images/god.png"
                childButton.focusBitmapUri = "pkg:/images/god.png"
            else if cardData.color = "B" then
                childButton.focusFootprintBitmapUri = "pkg:/images/god.png"
                childButton.focusBitmapUri = "pkg:/images/god.png"
            else if cardData.color = "Y" then
                childButton.focusFootprintBitmapUri = "pkg:/images/god.png"
                childButton.focusBitmapUri = "pkg:/images/god.png"
            else if cardData.color="W" then 
                childButton.focusFootprintBitmapUri="pkg:/images/god.png"
             childButton.focusBitmapUri = "pkg:/images/god.png"
            end if
        
        ' 4. Lock the background to the exact size of the button
        cardBackground.width = 120 
        cardBackground.height = 150
        
        ' 5. REMOVED the translation line! 
        ' Because cardBackgrounds is now a LayoutGroup, it will automatically 
        ' place this poster perfectly behind the corresponding button.
        m.cardBackgrounds.appendChild(cardBackground)
    end if
end for
    ' -----------------------------------------------------
end sub

sub displayActions(avalibleActions as object) as void
    tempActionDisplay = []
    m.playerActions.buttons = [
        "empty"
    ]
    print avalibleActions
    for each a in avalibleActions
        print "- " + a.name
        tempActionDisplay.push(a.name)
    end for
    m.playerActions.buttons = tempActionDisplay
    
    ' --- NEW CODE: Reset buttons back to standard ---
    for i = 0 to m.playerActions.getChildCount() - 1
        childButton = m.playerActions.getChild(i)
        if childButton <> invalid
            ' Clearing the URI strings returns them to default Roku behavior
            childButton.focusFootprintBitmapUri = "" 
            childButton.focusBitmapUri = "" 
            
            ' Reset the text colors back to default
            childButton.textColor = "0xFFFFFFFF" 
            childButton.focusedTextColor = "0x000000FF" 
        end if
    end for
    ' ------------------------------------------------
end sub

sub displaySelectionColors() as void
    updateSelecting(true)
    m.playerActions = m.top.findNode("playerActions")
    
    m.playerActions.buttons = [
        "R",
        "G",
        "B",
        "Y"
    ]
    bgImages = [
        "pkg:/images/red.png",
        "pkg:/images/green.png",
        "pkg:/images/blue.png",
        "pkg:/images/yellow.png",
        "pkg:/images/purple.png"
    ]
    for i = 0 to 3
        childButton = m.playerActions.getChild(i)
        if childButton <> invalid
            childButton.showFocusFootprint = true 
  
            childButton.focusFootprintBitmapUri = bgImages[i]
            childButton.focusBitmapUri = bgImages[i]
            
            childButton.textColor = "0xFFFFFFFF" 
            childButton.focusedTextColor = "0x000000FF" 
        end if
    end for
    ' --------------------------------------------

    m.top.setFocus(true)
    m.playerActions.setFocus(true)
    m.playerActions.focusButton = 0
    m.playerCards = m.top.findNode("playerCards")
    m.playerCards.setFocus(false)
    m.playerActions.setFocus(true)
end sub

' update update update update update update update update update update update update update update update update
' load load load load load load load load load load load load load load load load load load load load load load
sub updateStoredValues(playerList as object, currentPlayer as integer, unodeck as object, topCard as object, selecting as boolean) as void
    m.global = GetGlobalAA().global
    m.global.Update({
        playerList: playerList
        currentPlayer: currentPlayer
        unoDeck: unodeck
        topCard: topCard
        selecting: selecting
    }, true)
end sub

sub updateSelecting(selecting as boolean) as void
    m.global = GetGlobalAA().global
    m.global.Update({
        selecting: selecting
    }, true)
end sub

sub updatePlayerList(playerList) as void
    m.global = GetGlobalAA().global
    m.global.Update({
        playerList: playerList
    }, true)
end sub

sub updateCurrentPlayer(currentPlayer as integer) as void
    m.global = GetGlobalAA().global
    m.global.Update({
        currentPlayer: currentPlayer
    }, true)
end sub

sub updateUnoDeck(unoDeck as object) as void
    m.global = GetGlobalAA().global
    m.global.Update({
        unoDeck: unoDeck
    }, true)
end sub

sub updateTopCard(topCard as object) as void
    m.global = GetGlobalAA().global
    m.global.Update({
        topCard: topCard
    }, true)
    updateTopCardDisplay(topCard.name)
end sub

sub loadPlayers() as object
    playerList = []
    m.global = GetGlobalAA().global
    for each p in m.global.playerList
        playerList.push(Player(p.name, p.totalActions, p.remainingActions, p.cards, p.selectedCard))
    end for
    return playerList
end sub

sub loadUnoDeck() as object
    m.global = GetGlobalAA().global
    unoDeck = Deck([])
    for each c in m.global.unoDeck.cards
        unoDeck.addCard(Card(c.name, c.iconUri, c.color, c.number))
    end for
    return unoDeck
end sub

sub loadTopCard() as object
    m.global = GetGlobalAA().global
    topCardData = m.global.topCard
    return Card(topCardData.name, topCardData.iconUri, topCardData.color, topCardData.number)
end sub

sub loadCurrentPlayer() as integer
    m.global = GetGlobalAA().global
    return m.global.currentPlayer
end sub

sub testFocus() as void
    m.top.setFocus(true)
    m.top.findNode("playerCards").setFocus(true)
    m.playerCards = m.top.findNode("playerCards")
    m.playerActions = m.top.findNode("playerActions")
    m.playerCards.focusButton = 0
    m.playerActions.focusButton = 0
end sub

sub updateTopCardDisplay(newText as string) as void
    m.topCard1 = m.top.findNode("topCard")
    m.topCard1.text = newText
    renderTopCard()
end sub
sub renderTopCard()
    ' 1. Call your function to get the current Top Card object
    currentTopCard = loadTopCard()
    
    ' 2. Check to make sure the card actually exists before doing anything
    if currentTopCard <> invalid and currentTopCard.color <> invalid
        
        ' 3. Update the Text layer so it says "G3", "B5", etc.
        if m.topCardText <> invalid then
            m.topCardText.text = currentTopCard.name
        end if
        
        ' 4. Safely get the color string to prevent crashes
        safeColor = currentTopCard.color + ""
        
        ' 5. Update the background Poster!
        if safeColor = "R" then
            m.topCardBackground.uri = "pkg:/images/red1.png"
        else if safeColor = "G" then
            m.topCardBackground.uri = "pkg:/images/green1.png"
        else if safeColor = "B" then
            m.topCardBackground.uri = "pkg:/images/blue1.png"
        else if safeColor = "Y" then
            m.topCardBackground.uri = "pkg:/images/yellow1.png"
        else if safeColor = "W" then
            m.topCardBackground.uri = "pkg:/images/purple2.png"
        end if
        
    else
        print "WARNING: loadTopCard() returned an invalid card or a card with no color!"
    end if
end sub
sub displayPlayerName(playerName as string) as void
    m.global = GetGlobalAA().global
    currentPlayer = loadCurrentPlayer()
    players = loadPlayers()
    m.playerNameLabel = m.top.findNode("playerName")
    if playerName <> "!" then
        m.playerNameLabel.text = playerName
        return
    end if
    m.playerNameLabel.text = players[currentPlayer].name
end sub

sub nextTurn() as void
    m.global = GetGlobalAA().global
    currentPlayer = loadCurrentPlayer()
    Players = loadPlayers()
    if (currentPlayer + 1) >= Players.count() then
        nextPlayerIndex = 0
    else
        nextPlayerIndex = currentPlayer + 1
    end if
    updateCurrentPlayer(nextPlayerIndex)
    updateStoredValues(Players, nextPlayerIndex, m.global.unoDeck, m.global.topCard, false)
    displayCards(Players[nextPlayerIndex])
    updateActions(Players[nextPlayerIndex])
    testFocus()
    displayPlayerName("!")
end sub

sub init()
    m.cardBackgrounds = m.top.findNode("cardBackgrounds")
    m.p1Label = m.top.findNode("playername")
    m.p2Name=""
    if m.global.hasField("savedPlayerNames")
        m.nameList = m.global.savedPlayerNames
        
        m.p1Name = m.nameList[0]
        m.p2Name = m.nameList[1]
                if m.p1Name <> ""
            m.p1Label.text = "Player 1: " + m.p1Name
        else
            m.p1Label.text = "Player 1"
        end if
            end if
            m.topCardBackground = m.top.findNode("topCardBackground")
        m.customFont = CreateObject("roSGNode", "Font")
m.customFont.uri = "pkg:/fonts/Anta-Regular.ttf"
m.customFont.size = 45
m.p1Label.font = m.customFont
            currentPlayer = 0
    playerList = []
    unoDeck = createUnoDeck()
    topCard = unoDeck.drawRandomCard()
    print "Top Card is: " + topCard.name
    m.top.findNode("playerCards").setFocus(true)
    m.playerCards = m.top.findNode("playerCards")
    m.playerActions = m.top.findNode("playerActions")
    player1 = Player(m.p1Label.text, 3, 3, [], invalid)
    player1.addCard(unoDeck.drawRandomCard())
    player1.addCard(unoDeck.drawRandomCard())
    player1.addCard(unoDeck.drawRandomCard())
    if m.p2Name =""
        player2 = Player("Player 2", 3, 3, [], invalid)
    else
    player2 = Player("Player 2: " + m.p2Name, 3, 3, [], invalid)
    end if
    player2.addCard(unoDeck.drawRandomCard())
    player2.addCard(unoDeck.drawRandomCard())
    player2.addCard(unoDeck.drawRandomCard())
    player2.addCard(unoDeck.drawRandomCard())
    playerList.push(player1)
    playerList.push(player2)
    displayCards(playerList[currentPlayer])
    updateStoredValues(playerList, currentPlayer, unoDeck, topCard, false)
    m.playerCards.focusButton = m.playerCards.focusButton
    print m.playerCards.isInFocusChain()
    m.topCard1 = m.top.findNode("topCard")
    m.topCard1.text = topCard.name
    updateTopCardDisplay(topCard.name)
    updateTopCardDisplay(topCard.name)
    displayPlayerName("!")
    ' m.top.setFocus(true)
    ' m.mainLabel = m.top.findNode("mainLabel")
    ' 'change the color
    ' m.mainLabel.color = "0xFFFFFF"
    ' 'make the text really big 
    ' m.mainLabel.font.size = 100
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press
        if key = "replay"
            okKey()
            handled = true
        end if
        if key = "right"
            rightKey()
            handled = true
        end if
        if key = "left"
            leftKey()
            handled = true
        end if
        if key = "down"
            downKey()
            handled = true
        end if
        if key = "up"
            upKey()
            handled = true
        end if
        if key = "options"
            m.top.findNode("playerCards").setFocus(true)
            m.playerCards = m.top.findNode("playerCards")
            m.playerActions = m.top.findNode("playerActions")
            m.playerCards.focusButton = 0
            print m.playerCards.isInFocusChain()
            handled = true
        end if
        if key ="back"
                showIndexScene()
                handled = true
    end if
    end if
    return handled
end function
sub showIndexScene()
    indexScene = CreateObject("roSGNode", "IndexScene")
    
    if indexScene <> invalid
        m.top.appendChild(indexScene)

        indexScene.setFocus(true)
    else
        print "error"
    end if
end sub
sub rightKey()
    m.playerCards = m.top.findNode("playerCards")
    m.playerActions = m.top.findNode("playerActions")
    if (m.playerCards.isInFocusChain())
        m.playerCards.focusButton = m.playerCards.focusButton + 1
        if m.playerCards.focusButton >= m.playerCards.buttons.count()
            m.playerCards.setFocus(false)
            m.playerActions.setFocus(true)
            '    m.playerCards.focusButton = 0
        end if
    end if
    ' globalNode = GetGlobalAA().global
    '  playerSub = new Player(m.global.playerList[m.global.currentPlayer].name, m.global.playerList[m.global.currentPlayer].totalActions, m.global.playerList[m.global.currentPlayer].remainingActions, m.global.playerList[m.global.currentPlayer].cards)
    ' playerSub.selectCard(playerSub.getCard(m.playerCards.focusButton))
    ' print playerSub.selectedCard.name
    ' updateStoredValues([playerSub], m.global.currentPlayer)
    ' updateActions(playerSub)
end sub

sub leftKey()
    ' print "left key pressed"
    m.global = GetGlobalAA().global
    if (m.playerActions.isInFocusChain() and m.global.selecting = false)
        m.playerActions.setFocus(false)
        m.playerCards.setFocus(true)
        m.playerCards.focusButton = m.playerCards.buttons.count() - 1
        ' m.playerCards.focusButton = m.playerCards.buttons.count() - 1
        return
    end if
    if (m.playerCards.isInFocusChain())
        m.playerCards.focusButton = m.playerCards.focusButton - 1
        if m.playerCards.focusButton < 0
            m.playerCards.focusButton = m.playerCards.buttons.count() - 1
        end if
    end if
    ' globalNode = GetGlobalAA().global
    '  playerSub = new Player(m.global.playerList[m.global.currentPlayer].name, m.global.playerList[m.global.currentPlayer].totalActions, m.global.playerList[m.global.currentPlayer].remainingActions, m.global.playerList[m.global.currentPlayer].cards)
    ' playerSub.selectCard(playerSub.getCard(m.playerCards.focusButton))
    ' print playerSub.selectedCard.name
    ' updateStoredValues([playerSub], m.global.currentPlayer)
    ' updateActions(playerSub)
end sub

sub okKey()
    m.global = GetGlobalAA().global
    print "OK key pressed"
    if (m.playerActions.isInFocusChain())
        if (m.global.selecting = false)
            print m.playerActions.buttons
            print m.playerActions.buttonFocused
            print "action selected: " + m.playerActions.buttons[m.playerActions.buttonFocused]
            doAction(m.playerActions.buttons[m.playerActions.buttonFocused], GetGlobalAA().global.playerList[GetGlobalAA().global.currentPlayer])
            return
        end if
        if (m.global.selecting = true)
            topcard = loadTopCard()
            topcard.color = m.playerActions.buttons[m.playerActions.buttonFocused]
            topcard.name = topcard.color + "W"
            updateTopCard(topcard)
            updateTopCardDisplay(topcard.name)
            nextTurn()
        end if
    end if
    if (m.playerCards.isInFocusChain())
        for i = 0 to m.playerCards.buttons.count() - 1
            m.playerCards.getChild(i).textColor = "0x000000FF"
            m.playerCards.getChild(i).focusedTextColor = "0x000000FF"
        end for
        m.playerCards.getChild(m.playerCards.focusButton).textColor = "0xFF0000FF"
        m.playerCards.getChild(m.playerCards.focusButton).focusedTextColor = "0xFF0000FF"
        globalNode = GetGlobalAA().global
        Players = loadPlayers()
        Players[m.global.currentPlayer].selectCard(Players[m.global.currentPlayer].getCard(m.playerCards.focusButton))
        print Players[m.global.currentPlayer].selectedCard.name
        updatePlayerList(Players)
        updateActions(Players[m.global.currentPlayer])
    end if
end sub

sub downKey()
    if (m.playerActions.isInFocusChain())
        m.playerActions.focusButton = m.playerActions.focusButton + 1
        if m.playerActions.focusButton >= m.playerActions.buttons.count()
            m.playerActions.focusButton = 0
        end if
    end if
end sub

sub upKey()
    if (m.playerActions.isInFocusChain())
        m.playerActions.focusButton = m.playerActions.focusButton - 1
        if m.playerActions.focusButton < 0
            m.playerActions.focusButton = m.playerActions.buttons.count() - 1
        end if
    end if
end sub

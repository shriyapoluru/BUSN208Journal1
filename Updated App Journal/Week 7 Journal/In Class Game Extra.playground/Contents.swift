import UIKit

//var greeting = "Hello, playground"

/*
 
 
 User’s Journey: When the app opens up the user will see a dropdown. From the dropdown they will select a game mode. The options are: two sharing a device (2 players playing on the same device against each other), challenge your device (1 player vs a bot), and challenge your friend (1 player on this device vs 1 player over the web). Once a game mode is selected the fields will change to reflect the necessary information such as player names. Once the game starts the players/bot will start placing Xs and Os. If a player wins, a pop up will appear saying that they won and there will be an option to restart the game. If no one wins, a pop up will appear saying that there is no winner, and there will be an option to restart the game. The user can also quit and pick a new game type.





 Main App (starting point/ App Entry)  → Game Setup (Selecting Game Type/Start View) →(Down) → Game Interface (Displaying gameboard to user / Game View) → Game Logic  (Actual TicTacToe Logic / GameService) → Game Board (creating and defining tiles & board / GameSquare) → Tiles (UI of game board for user to view / SquareView)




 Code Flow Based on User Journey
 1)User Starts the App
 AppEntry.swift launches StartView.swift
 GameService instance is created (@StateObject)
 2)User Selects Game Type
 StartView.swift is launched
 Shows game type picker (Single Player, Bot, Peer)
 Collects player names (if required)
 Calls game.setupGame()
 Opens GameView.swift using fullScreenCover
 3)User Plays the Game
 GameView.swift
 Shows player selection buttons (the actual tiles with X,O, or blank)
 Displays Tic-Tac-Toe grid using SquareView
 Disables the board if game is over
 4)User Clicks on a Tile
 SquareView.swift
 Calls game.makeMove(at: index)
 Updates gameBoard[index].player
 Switches currentPlayer
 Calls checkIfWinner()
 5)Game Ends
 GameView.swift
 Displays "Game Over" message
 Shows if Winner or if no one won
 Offers "New Game" button (game.reset())
 6)User Exits the Game
 Clicks "End Game"
 dismiss() is called so goes back to StartView.swift

 */

//
//  GameService.swift
//  TicTacToeVersion2App
//
//  Created by Poluru, Shriya on 2/17/25.
//

import SwiftUI

@MainActor //this is connecting back to AppEntry.
//piggybacing on the main thread of the app to update it

//class name capital //enum is nothing but a structure
class GameService: ObservableObject{ //observable object for the class
   
    //var names lowercase
    @Published var player1 = Player(gamePiece: .X, name: "Player 1")
    @Published var player2 = Player(gamePiece: .O, name: "Player 2")
    
    @Published var possibleMoves = Moves.all
    
    //need to build the game board
    @Published var gameBoard = GameSquare.reset
    
    @Published var gameOver = false
    
    
    //@Published var currentPlayer: Player = .init(gamePiece: .X, name: "Player 1")
    var gameType = GameType.single //not publishing this because
    
    var currentPlayer:Player{
        if player1.isCurrent {
            return player1
        }
        return player2
    }
    
    var gameStarted: Bool {
        player1.isCurrent || player2.isCurrent //basically an if statment and return
    }
    
    var boardDisabled: Bool{
        gameOver || !gameStarted
    }
    
    func setupGame(gameTypes: GameType, player1Name:String, Player2Name:String){
        switch gameType{ //saying what the game type is and what player names are
        case .single:
            self.gameType = .single
            //player1.name = player1Name
            player2.name = Player2Name
            
        case .bot:
            self.gameType = .bot
            //player1.name = player1Name
            //player2.name = "Computer"
            
        case .peer:
            self.gameType = .peer
           // player1.name = player1Name
            player2.name = Player2Name
            
        case .undertermined:
            self.gameType = .undertermined
           // player1.name = player1Name
            break
        
        }
        
        player1.name = player1Name //instead of saying this in every case can just say it once outside of the switch case so it always applies
    }
    
    //resetting the information so a new game can be made later
    func reset(){
        player1.isCurrent = false
        player2.isCurrent = false
        
        player1.moves.removeAll()
        player2.moves.removeAll()
        
        gameOver = false
        
        possibleMoves = Moves.all
        
        //reset the game board (includes stuff with the tiles)
        gameBoard = GameSquare.reset
        
        
    }
    
//function that is updating the moves as they are playing. If player1 is current then it will update theirs, if player2 is current will update theirs
    func updateMoves(index: Int){
        if player1.isCurrent {
            player1.moves.append(index+1)
            gameBoard[index].player = player1
        } else {
            player2.moves.append(index+1)
            gameBoard[index].player = player2
        }
    }
    
    
    func checkIfWinner(){
        if player1.isWinner || player2.isWinner{
            gameOver = true
        }
    }
    
    
    func toggleCurrent(){
        player1.isCurrent.toggle() //will only toggle if that player is current player. else it won't
        player2.isCurrent.toggle()
    }
    
    func makeMove(at index:Int) {
        //if the gameboard has no players, then it will go through the animation (like a sound)
        if gameBoard[index].player == nil { //checking if there are more pieces that are unused
            withAnimation {
                updateMoves(index: index) //the first one is a name of the label index, and the second one is the actual index
                
            }
            checkIfWinner() //game over will be set to true if there is a winner //checks if there is a winner
            
            if !gameOver{ //if the game is not over
                if let matchingIndex = possibleMoves.firstIndex(where: {$0 == (index+1)}) { //if there is no winner the let is making it a constant. the matchingindex is constant. removing a move since no one else can place a piece there and then switching a player. Also checking if all the moves have been played, then the game is over even if there is no winner
                    possibleMoves.remove(at: matchingIndex)
                }
                
                toggleCurrent()
            }
            
            if possibleMoves.isEmpty{
                gameOver = true
            }
            
        }
    }
    
} //class GameService ends here


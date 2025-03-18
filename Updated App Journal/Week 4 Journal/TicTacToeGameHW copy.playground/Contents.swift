import UIKit
import Foundation


class TicTacToe {
    private var board: [[String]] //original board being created and is made empty
    private var currentPlayer: String //variable that will be keeping track of if player 1 or 2 is playing

    //initializing the game board with an init. Player 1 or X goes first
    init() {
        self.board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        self.currentPlayer = "X"
    }
    
    //this will show what is on the board right now using X for player 1, O for player 2, and - for empty
    private func printBoard() {
        for row in board {
/**/            print(row.map { $0.isEmpty ? "-" : $0 }.joined(separator: " "))
        }
    }

    private func getPlayerMove() -> (Int, Int) {
        // these are hardcoded values
        // In a real game, shoudl gert user input
        return (Int.random(in: 0..<3), Int.random(in: 0..<3))
    }

    private func isValidMove(row: Int, col: Int) -> Bool { //checking if move is valid
        return row >= 0 && row < 3 && col >= 0 && col < 3 && board[row][col].isEmpty
    }

    private func switchPlayer() { //switches from player 1 to 2 and vice versa
        currentPlayer = (currentPlayer == "X") ? "O" : "X"
    }

    private func isWinner() -> Bool {
        let winningCombinations = [
            [(0, 0), (0, 1), (0, 2)], // rows
            [(1, 0), (1, 1), (1, 2)],
            [(2, 0), (2, 1), (2, 2)],
            [(0, 0), (1, 0), (2, 0)], // columns
            [(0, 1), (1, 1), (2, 1)],
            [(0, 2), (1, 2), (2, 2)],
            [(0, 0), (1, 1), (2, 2)], // diagonals
            [(0, 2), (1, 1), (2, 0)]
        ]

        for combination in winningCombinations {
            if combination.allSatisfy({ board[$0.0][$0.1] == currentPlayer }) {
                return true
            }
        }
        return false
    }

    private func isGameOver() -> Bool {
        return board.flatMap { $0 }.allSatisfy { !$0.isEmpty }
    }

    
    
    
    
    //this is where the game is being played
    func playGame() {
        var playerOneCount = 0
        var playerTwoCount = 0

        // while game is not over, the game continues and players can make moves
        while !isGameOver() {
            printBoard() //displays the board
            let (row, col) = getPlayerMove() //getting the current player's move
            
            //this will make sure that the move is valid
            if isValidMove(row: row, col: col) {
                board[row][col] = currentPlayer //if is valid then the players move is displayed
                
                if currentPlayer == "X" {
                    playerOneCount += 1 //if X is placed it is added to player 1
                } else {
                    playerTwoCount += 1 //if not X than it is added to player 2
                }
                
                //cheking if the player that just went wond the game.
                if isWinner() {
                    //print("Player" + \(currentPlayer) + "wins!")
                    //print("Player \(currentPlayer) wins!")
                    return
                }
                switchPlayer() //if there is not a winner it switches to the other player
                
            } else {
                print("Invalid move. Try again.") //prints if the move was invalid
            }
        }
        print("Game Over") //prints if the game is over
    }

}

// Initialize the game and start playing
let game = TicTacToe()
game.playGame()


//-----------------------------------------------------------------------------

//import UIKit

//var greeting = "Hello, playground"

//var twoStrings = Array (repeating: "9", count: 9)

//print(twoStrings)

/*
class TicTacToe {
    private var board: [[String]]
    private var currentPlayer: String
    
    init(board: [[String]], currentPlayer: String) {
        self.board = Array(repeating: Array(repeating: "", count: 3), count: 3)//.joined()
        self.currentPlayer = "0"
    }
        
    func play_game(){
        private var playerOneCount = 0
        private var PlayerTwoCount = 0
        
        //max_moves (max moves 5) (win on 5th move potentially)
        if (playerOneCount >= 5 || PlayerTwoCount >= 5)
        {
            print( "Game Over");
        }
        
        //num move
        
        //logic to continue game
        //num_move <= max_moves
        
        //enter where they want to play (row, col)
        
        //validation (2A vs A2) (throw error)
        
        //need rules for winning. Need to have a set of winning combinations in store. they can be in any sequence. if don't win next player's turn.
        //rules
        
        
    }
    
}
    
    
    
    
    /* this was intellisense
    var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    
    func printBoard() {
        for row in board {
            print(row)
        }
    }
    
    func placeMove(row: Int, col: Int, player: String) {
        
    }
     
}
*/

*/

import UIKit



// create a 4x4 board.

//orignal variable to place first piece stored

//check if space is empty or already has a queen

//check row

//check column

//check diagonal

//if pass all then place down

//if 4 queens placed game won

//if fails then change the location of first piece, and recheck from there





import Foundation

// Function to print the board
func printBoard(board: [[Int]]) {
    for row in board {
        for col in row {
            // If there is a queen (represented by 1), print 'Q', otherwise print '-'
            print(col == 1 ? "Q" : "-", terminator: " ")
        }
        print()
    }
    print()
}


// This is a function to check if a queen can be placed on the board[row][col]
func isSafe(board: [[Int]], row: Int, col: Int) -> Bool {
    let N = board.count
    
    // Checking row i on left side
    for i in 0..<col {
        if board[row][i] == 1 {
            return false
        }
    }

    // Checking the upper diagonal on left side
    //zip can combile many different sequences into 1 sequence
    for (i, j) in zip(stride(from: row, through: 0, by: -1), stride(from: col, through: 0, by: -1)) {
        if board[i][j] == 1 {
            return false
        }
    }

    // Checking the lower diagonal on left side
    //stride can return a sequence from startin g value to end value. end value is not inclusive.
    for (i, j) in zip(stride(from: row, to: N, by: 1), stride(from: col, through: 0, by: -1)) {
        if board[i][j] == 1 {
            return false
        }
    }

    // If no problems, then the position is safe
    return true
}


// This is a function to solve problem with backtracking
func solveNQueen(board: inout [[Int]], col: Int) -> Bool {
    let N = board.count
    
    // If all queens are placed then we will return true
    if col >= N {
        return true
    }

    // Trying the problem by placing the queen in all rows one by one
    for i in 0..<N {
        if isSafe(board: board, row: i, col: col) {
            // Placing the queen
            board[i][col] = 1
            
            // Recursively placing the rest of the queens
            if solveNQueen(board: &board, col: col + 1) {
                return true
            }

            // If placing queen in board[i][col] leads to no solution the we will remove the queen
            board[i][col] = 0
        }
    }

    // If the queen cannot be placed in any row then return false
    return false
}



// Function to solve the 4-Queen problem
func solve4QueenProblem() {
    let N = 4
    var board = Array(repeating: Array(repeating: 0, count: N), count: N)

    // Start solving the 4-Queen problem
    if solveNQueen(board: &board, col: 0) {
        print("Solution found:")
        printBoard(board: board)
    } else {
        print("No solution exists.")
    }
}

// Calling the solve4QueenProblem function
solve4QueenProblem()



//
//  GameService.swift
//


//Game Service:
import SwiftUI

// enum for Rock-Paper-Scissors Moves
enum MoveType: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

// Game Service to handle game logic
class GameService: ObservableObject {
    @Published var playerMove: MoveType? // Stores player's selected move
    @Published var botMove: MoveType? // Stores bot's move
    @Published var resultMessage: String = "" // Stores game result message
    
    // Function to Play a Round of the game
    func play(playerChoice: MoveType) {
        playerMove = playerChoice // Store player move
        botMove = MoveType.allCases.randomElement() // Randomly select bot move
        
        // Determines the winner
        if let botMove = botMove {
            if playerMove == botMove {
                resultMessage = "It's a Tie!"
            } else if (playerMove == .rock && botMove == .scissors) ||
                      (playerMove == .paper && botMove == .rock) ||
                      (playerMove == .scissors && botMove == .paper) {
                resultMessage = "You Win!"
            } else {
                resultMessage = "You Lose!"
            }
        }
    }
    
    // Function that Resets the Game
    func reset() {
        playerMove = nil
        botMove = nil
        resultMessage = ""
    }
}

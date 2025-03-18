//
//  StartView.swift
//Start Screen

import SwiftUI

// View for Selecting Rock, Paper, or Scissors
struct StartView: View {
    @EnvironmentObject var game: GameService // Access game logic
    
    @State private var selectedMove: MoveType? // Stores user selection of move type
    @State private var startGame = false // Controls navigation
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Choose Your Move").font(.title).bold()
                
                // move Selection Buttons (dropwdown)
                HStack {
                    ForEach(MoveType.allCases, id: \.self) { move in
                        Button(move.rawValue) {
                            selectedMove = move
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(selectedMove == move ? Color.green : Color.gray))
                        .foregroundColor(.white)
                    }
                }
                
                // Play Button
                Button("Play!") {
                    if let move = selectedMove {
                        game.play(playerChoice: move) // Play the game
                        startGame = true // Moves to GameView
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedMove == nil) // Disables button until move is selected
                
                Spacer()
            }
            .navigationTitle("Rock Paper Scissors")
            .padding()
            .fullScreenCover(isPresented: $startGame) {
                GameView()
            }
        }
    }
}

#Preview {
    StartView().environmentObject(GameService())
}


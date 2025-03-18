//
//  GameView.swift


//game result

import SwiftUI

// Displaying Game Results
struct GameView: View {
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss // Returning to StartView is possible
    
    var body: some View {
        VStack {
            Text("Game Result").font(.title).bold()
            
            // Displaying Moves
            Text("Your Move: \(game.playerMove?.rawValue ?? "None")")
            Text("Bot's Move: \(game.botMove?.rawValue ?? "None")")
            
            // Showing Results Message
            Text(game.resultMessage).font(.largeTitle).bold().padding()
            
            // Can play again with this button
            Button("Play Again") {
                game.reset() // Reset the game
                dismiss() // Go back to StartView
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    GameView().environmentObject(GameService())
}

import SwiftUI

enum Choice: String, CaseIterable {
    case snake = "🐍"
    case water = "💧"
    case gun = "🔫"
    
    func beats(_ other: Choice) -> Bool {
        switch (self, other) {
        case (.snake, .water): return true
        case (.water, .gun): return true
        case (.gun, .snake): return true
        default: return false
        }
    }
}

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var player1Score = 0
    @State private var player2Score = 0
    @State private var currentPlayer = 1
    @State private var player1Choice: Choice?
    @State private var player2Choice: Choice?
    @State private var showingResult = false
    @State private var resultMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Snake Water Gun")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Text("Player 1: \(player1Score)")
                Spacer()
                Text("Player 2: \(player2Score)")
            }
            .font(.title2)
            .padding(.horizontal)
            
            Text("Player \(currentPlayer)'s Turn")
                .font(.title3)
                .padding()
            
            HStack(spacing: 20) {
                ForEach(Choice.allCases, id: \.self) { choice in
                    Button(action: {
                        makeChoice(choice)
                    }) {
                        Text(choice.rawValue)
                            .font(.system(size: 50))
                    }
                    .disabled(showingResult)
                }
            }
            
            if showingResult {
                Text(resultMessage)
                    .font(.title3)
                    .padding()
                
                Button("Next Round") {
                    resetRound()
                }
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 150, height: 40)
                .background(Color.blue)
                .cornerRadius(10)
            }
            
            Button("End Game") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 150, height: 40)
            .background(Color.red)
            .cornerRadius(10)
            .padding(.top, 30)
        }
        .padding()
    }
    
    private func makeChoice(_ choice: Choice) {
        if currentPlayer == 1 {
            player1Choice = choice
            currentPlayer = 2
        } else {
            player2Choice = choice
            determineWinner()
        }
    }
    
    private func determineWinner() {
        guard let p1Choice = player1Choice, let p2Choice = player2Choice else { return }
        
        if p1Choice == p2Choice {
            resultMessage = "It's a tie!"
        } else if p1Choice.beats(p2Choice) {
            resultMessage = "Player 1 wins!"
            player1Score += 1
        } else {
            resultMessage = "Player 2 wins!"
            player2Score += 1
        }
        
        showingResult = true
    }
    
    private func resetRound() {
        player1Choice = nil
        player2Choice = nil
        currentPlayer = 1
        showingResult = false
        resultMessage = ""
    }
}

#Preview {
    GameView()
} 
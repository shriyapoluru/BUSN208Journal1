

import SwiftUI

struct ContentView: View {
    @State private var isGameActive = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Snake Water Gun")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image(systemName: "gamecontroller.fill")
                    .imageScale(.large)
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                NavigationLink(destination: GameView()) {
                    Text("Play Game")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

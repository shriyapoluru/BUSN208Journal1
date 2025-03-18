import SwiftUI

struct ContentView: View {
    @State private var leftScore = 0
    @State private var rightScore = 0
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            
            // Score displays
            HStack(spacing: 60) {
                VStack {
                    Text("\(leftScore)")
                        .font(.system(size: 48, weight: .bold))
                    Button(action: {
                        leftScore += 1
                    }) {
                        Text("+1 Left")
                            .font(.system(size: 24))
                    }
                }
                
                VStack {
                    Text("\(rightScore)")
                        .font(.system(size: 48, weight: .bold))
                    Button(action: {
                        rightScore += 1
                    }) {
                        Text("+1 Right")
                            .font(.system(size: 24))
                    }
                }
            }
            
            Spacer()
            
            // Bottom buttons
            HStack {
                Button(action: {
                    leftScore = 0
                    rightScore = 0
                }) {
                    Text("Reset")
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                Button(action: {
                    showingAlert = true
                }) {
                    Text("Done")
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
        .alert("Session Complete", isPresented: $showingAlert) {
            Button("OK") {
                leftScore = 0
                rightScore = 0
            }
        } message: {
            Text("Final Score - Left: \(leftScore), Right: \(rightScore)")
        }
    }
}

#Preview {
    ContentView()
}

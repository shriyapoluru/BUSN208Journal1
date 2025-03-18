// File not relevant




//  GameView.swift
//  TicTacToeVersion2App
//
//  Created by Poluru, Shriya on 2/24/25.
//

/*import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var game:GameService
    @Environment(\.dismiss) var dismiss //all supposed to be in a database
    
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        NavigationStack{
            
            
            VStack{
                if [game.player1.isCurrent, game.player2.isCurrent] // this is where we are actually setting a current player. You can select the current player by clicking on the buttons
                    .allSatisfy({ $0 == false }){
                    Text("Select a player to start game.")
                }//end of if statement
                
                HStack{
                    Button(game.player1.name){
                        game.player1.isCurrent = true
                    }
                    
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(game.player1.isCurrent ? Color.green: Color.gray))
                                                                            //asking if they are the current player then backgorund is green else it is gray. ? needs space so it is if statement and not null
                    
                    .foregroundColor(.white)
                    
                    
                    
                    //player2
                    Button(game.player2.name){
                        game.player2.isCurrent = true
                    }
                    
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(game.player2.isCurrent ? Color.green: Color.gray))
                                                                            //asking if they are the current player then backgorund is green else it is gray. ? needs space so it is if statement and not null
                    
              
                    
                    
                    
                    
                }//end of background bracket / hstack. once the game starts this is disabled/frozen. you can't change it after game starts
                
              
                .foregroundColor(.white)
                
                
            } //end of vstack
            .disabled(game.gameStarted)
            
            
            //create the game board
            VStack{
                
                HStack{
                    ForEach(0...2, id: \.self){
                        index in SquareView(index: index)
                        
                    }//end of foreach
                }
                
                HStack{
                    ForEach(3...5, id: \.self){
                        index in SquareView(index: index)
                        
                    }//end of foreach
                }
                
                HStack{
                    ForEach(6...8, id: \.self){
                        index in SquareView(index: index)
                        
                    }//end of foreach
                }
                
            }//end of game board v stack
            
            
        }// end of outer vstack/ navigation
        .disabled(game.boardDisabled)
        
        //display the winner when the game is over
        
        VStack{
            if game.gameOver{
                Text("Game Over")
                
                if game.possibleMoves.isEmpty{
                    Text("It's a draw!")
                }else{
                    Text("\(game.currentPlayer.name) wins!")
                }
                
                Button("New Game"){
                    game.reset()
                }
                .buttonStyle(.borderedProminent)
                
            }
            
        } //end of game result VStack
        .font(.largeTitle)
        
        Spacer()
        
    }
        .toolbar{
        ToolbarItem(placement: .topBarTrailing) {
            Button("End Game") {
                dismiss() //removes the model h?
            }
            .buttonStyle(.bordered)
        }
    }//end of toolbar
    .navigationTitle("Tic-Tac-Toe")
    .onAppear{
        game.reset() //this is where the reset is happening
    }
}

#Preview {
    GameView()
    //StartView()
        .environmentObject(GameService()) //saying you have access to that game service instance
}
*/

/*
import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss // Fixed whitespace issue
    
    var body: some View {
        NavigationStack {
            VStack {
                if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy({ $0 == false }) {
                    Text("Select a player to start game.")
                }
                
                HStack {
                    Button(game.player1.name) {
                        game.player1.isCurrent = true
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(game.player1.isCurrent ? Color.green : Color.gray))
                    .foregroundColor(.white)
                    
                    Button(game.player2.name) {
                        game.player2.isCurrent = true
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(game.player2.isCurrent ? Color.green : Color.gray))
                    .foregroundColor(.white)
                }
                .disabled(game.gameStarted)
                
                VStack {
                    HStack {
                        ForEach(0...2, id: \..self) { index in SquareView(index: index) }
                    }
                    
                    HStack {
                        ForEach(3...5, id: \..self) { index in SquareView(index: index) }
                    }
                    
                    HStack {
                        ForEach(6...8, id: \..self) { index in SquareView(index: index) }
                    }
                }
                .disabled(game.boardDisabled)
                
                VStack {
                    if game.gameOver {
                        Text("Game Over")
                        
                        if game.possibleMoves.isEmpty {
                            Text("It's a draw!")
                        } else {
                            Text("\(game.currentPlayer.name) wins!")
                        }
                        
                        Button("New Game") {
                            game.reset()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .font(.largeTitle)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("End Game") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Tic-Tac-Toe")
            .onAppear {
                game.reset()
            }
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameService())
}

*/

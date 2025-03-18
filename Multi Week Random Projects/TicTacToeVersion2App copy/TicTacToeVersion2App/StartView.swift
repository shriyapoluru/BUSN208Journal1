//
//  ContentView.swift
//  TicTacToeVersion2App
//
//  Created by Poluru, Shriya on 2/10/25.
//

/* Week 5
 1)had to add the icons and resize the icons (assets folder)
 2)rename the files with refactoring (in AppEntry)
 3)Craeted models folder and within it created the GameModel's swift file, and created the switch case
 4)created the state variables. the focus state is to see whether or not the keyboard is typed in
 5)then made the vstack within a vstack. also had picker and another switch case
 6)the button was made with the disable feature
 7)welcome image
 game type is also changed
 
 */

/*
 Week 6: Monday Feb 17
 
 1)Created Navigation Stack and navigaion title
 2)Added enums in GameModels file
    created gamepiece, moves (all winning moves in a 2D array),
    changed the name of image Cross to X
 3)Created GameScreen folder and GameService file and a new Game Service class
    made players, possible moves, if the game started and ended, board disabled, and a function to set up the game
 
 struct Player - defines
 
 */


/*
 Week 7: Monday Feb 24
 
 1)Reset board functipn in GameService
 2)Made GameSquare File
 3)initialized gameboard and called Published gameBoard reset
 4)Created updateMoves, reset, checkIfWinner, toggleCurrent, makeMove function in GameService File
 5)creating an instance of GameService IN APPENTRY
 6)Created GameAquare and GameView SwiftUI files
 
 
 */

/*
 Week 8: Monday Mar 3
 
 
 
 */

import SwiftUI

                    //lowercase g since about structure?



struct StartView: View {
    
    @EnvironmentObject var game:GameService
    
    @State private var gameType: GameType = .undertermined
    @State private var yourName = ""
    @State private var opponentName = ""
    
    @FocusState private var focus:Bool // focus of the keyboard is either true or false. So after something is types , it makes the keyboard goes away
    
    @State private var startGame = false
    
    var body: some View {
        /*
         VStack { //different entities are stacked vertically on the actual UI. HStack works the same way. Lazy Vstack and Hstack is only rendered when necessary
         Image(systemName: "globe")
         .imageScale(.large)
         .foregroundStyle(.tint)
         Text("Hello, World!")
         }
         
         .padding()
         */
        
            NavigationStack{
                
                VStack {
                    Picker("Select the game", selection:
                            $gameType)
                    {
                        Text("Select Game Type").tag(GameType.undertermined)
                        Text ("Two sharing a device").tag(GameType.single)
                        Text("Challenge your device").tag(GameType.bot)
                        Text("Challenge your friend").tag(GameType.peer)
                    }// Picker ends here & need dollar sign and small
                    
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(style: StrokeStyle(lineWidth: 2)))
                    
                    Text(gameType.decription)
                        .padding()
                    
                    //whatever option picked in picker, changes the text fields avaiable beneath it
                    VStack{
                        switch gameType {
                        case .single:
                            TextField("Your Name", text: $yourName) //$ is value that is currently held??
                            TextField("Opponent Name", text: $opponentName)
                        case .bot:
                            TextField("Your Name", text: $yourName)
                        case .peer:
                            TextField("Your Name", text: $yourName)
                            EmptyView() //feature will be available later
                            //TextField("Opponent Name", text: $opponentName)
                        case .undertermined:
                            //Text("Please select a game type")
                            EmptyView() //feature will be available later
                        }
                    }.padding() //this is a modifier //VStack on switch gametypes ends here
                    .textFieldStyle(.roundedBorder)
                    .focused($focus)
                    .frame(width:350)
                    
                    if gameType != .peer {
                        
                        //this button is actually a function.
                        Button ("Start Game"){
                            //setup the game SRP
                            
                            game.setupGame(gameTypes: gameType, player1Name: yourName, Player2Name: opponentName)
                            
                            focus = false
                            
                            startGame.toggle();
                        } //end of button (start game)
                        
                        .buttonStyle(.borderedProminent)
                        .disabled(gameType == .undertermined || yourName.isEmpty || (gameType == .single && opponentName.isEmpty))
                        
                        Image("welcomeScreen")
                        
                        
                    }
                    Spacer()

                    
                } //Vstack ends here
                .padding()
                .navigationTitle("Tic-Tac-Toe")
                //creqating a fullscreencover to strat the game. so another user interface is going to come on top of that. Thats the game view
                .fullScreenCover(isPresented: $startGame){
                    GameView()                      //place GameView here SP
                }
            }
            
                        
        } //VStack ends here
        //.padding()
        //.navigationTitle(Text("Tic-Tac-Toe"))
        //fullscreen cover based on missing the model cover
        
    }



#Preview {
    StartView()
        .environmentObject(GameService())
    //SP Revisit
}




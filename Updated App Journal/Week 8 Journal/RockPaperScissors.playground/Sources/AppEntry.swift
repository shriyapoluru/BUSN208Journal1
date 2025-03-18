//
//  AppEntry.swift


//app entry

import SwiftUI

@main //at main is for this instance or thread
struct RockPaperScissorsApp: App {
    @StateObject var game = GameService() // Shared game state
    
    var body: some Scene {
        WindowGroup {
            StartView().environmentObject(game) // game logic being called
        }
    }
}




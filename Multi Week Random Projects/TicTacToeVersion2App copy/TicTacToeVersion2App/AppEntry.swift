//
//  TicTacToeVersion2AppApp.swift
//  TicTacToeVersion2App
//
//  Created by Poluru, Shriya on 2/10/25.
//

import SwiftUI

@main //the main thread where the app is starting. Everytime an app is launched another thread is created.
struct AppEntry: App {
    
    @StateObject var game = GameService() //creating an instance of GameService
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game) //game passed as an object
        }
    }
}

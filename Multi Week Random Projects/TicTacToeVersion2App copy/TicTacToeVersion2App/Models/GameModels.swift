//
//  GameModels.swift
//  TicTacToeVersion2App
//
//  Created by Poluru, Shriya on 2/10/25.
//

//import Foundation
import SwiftUI

enum GameType { // enum is a custom data type
    case single, bot, peer, undertermined
   
    var decription: String {
        switch self { //switch means you are going to get into each of these cases based on the instances. So if playing bot you will enter the bot case. This is a switch case statement
        case .single:
            return "Share your device with a friend to play."
        case .bot:
            return "Play with a bot."
        case .peer:
            return "Invite somebody on the network to play with you."
        case .undertermined:
            return ""
        }
    }
}


enum GamePiece: String{
    case X, O
    
    var image: Image {
        Image(self.rawValue)
    }
}

enum Moves{
    
    static var all = [1,2,3,4,5,6,7,8,9] //static is when it can never be changed. could also be a constant.

    static var winningMoves = [
        [1,2,3], //h
        [4,5,6], //h
        [7,8,9], //h
        [1,4,7], //v
        [2,5,8], //v
        [3,6,9], //v
        [1,5,9], //d
        [3,5,7]  //d
        ]
}

struct Player{
    let gamePiece:GamePiece //even if accidently changed later on, it would throw an error
    var name: String
    var moves:[Int] = [] //initializing to a blank array
    var isCurrent = false
    
    var isWinner: Bool{
        for moves in Moves.winningMoves{
            if moves.allSatisfy(self.moves.contains)
            {return true}
        }
        return false
    }
}

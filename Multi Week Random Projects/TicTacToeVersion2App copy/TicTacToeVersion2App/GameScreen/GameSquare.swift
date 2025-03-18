//
//  GameSquare.swift
//  TicTacToeVersion2App
//
//  Created by Poluru, Shriya on 2/24/25.
//

import SwiftUI

//assignment on game square
struct GameSquare{
    var id:Int //values from 1 to 9
    var player:Player? //? means can take a nill value. Can take player name while playing game, but before game no player assigned so it will need nill value
    
    //images being set (X,O,Nill)
    var image:Image{
        
        if let player = player{ // this is not checking or assignment =? This "if let = " is checking if not nill.
            return player.gamePiece.image //if player is assigned then assinging their image
        }
        else{
            return Image("None")//if player not assigned then assigning the blank image called None from Assets file
        }
    }
    
    //reset function of the game board using the game squares. Static because can't change this function from anywhere else. Even if create an instance of this structure GameSquare you can only call it, you can't change it
    static var reset:[GameSquare]{
        var squares = [GameSquare]() //array of gamesquares. Empty?
        
        for index in 1...9{ //this is a forloop running from 1 to 9
            squares.append(GameSquare(id: index)) // making a tiktaktoe board by making an array with the squares. Resetting every tile in the process. Names, etc everything is gone from before
        }
        
        return squares //returning the array to be displayed as the board
    }
    
}

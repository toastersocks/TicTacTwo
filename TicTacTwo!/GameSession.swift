//
//  GameSession.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/3/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation


/**
Represents the type of session being played

- Local:        A local game between two players on the same device
- Remote:       A game between two players on different devices
- SinglePlayer: A local single player game (most likely between a player and an AI)
*/
enum SessionType {
    case Local
    case Remote
    case SinglePlayer
}

/**
Represents a play session of a game
*/
struct GameSession {
    
    let sessionType: SessionType
    let player: Player
    let opponent: Player
    let game: Game
    let id: String
    
    func makePlayerMove(atIndex index: Int) {
        if player.playerPiece == game.currentPlayer {
            game.makeMoveAtIndex(index)
        }
    }
    
    func makeOpponentMove(atIndex index: Int) {
        if opponent.playerPiece == game.currentPlayer {
            game.makeMoveAtIndex(index)
        }
    }
}

/**
*  This extension provides custom initializers
*/
extension GameSession {
    
    /*init(sessionType: SessionType) {
        let localID = NSDate().toString(formatString: "YYMMddssmm")
        self.init(sessionType: .Local, player: Player(), opponent: nil, game: Game(), id: localID)
    }*/

}

extension GameSession: Equatable {
    
}

func ==(lhs: GameSession, rhs: GameSession) -> Bool {
    return lhs.id == rhs.id
}
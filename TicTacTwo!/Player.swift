//
//  Player.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/4/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation

struct Player {
    
    enum PlayerType {
        case Local
        case Remote
        case AI
    }
    
    let displayName: String
    let playerID: String
    let playerPiece: Game.TicTacToePiece
    let playerType: PlayerType
}

extension Player {
    init(displayName: String, playerPiece: Game.TicTacToePiece) {
        self.init(displayName: displayName, playerID: displayName, playerPiece: playerPiece, playerType: .Local)
    }
}
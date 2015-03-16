//
//  AI.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/16/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation

class AI {
    let player: Player
    var gameSession: GameSession
    var isMyTurn: Bool {
        return gameSession.currentPlayer == player {
        }
    }
    init(player: Player, gameSession: GameSession) {
        self.player = player
        self.gameSession = gameSession
        SwiftEventBus.onBackgroundThread(self, name: GameSession.movePlayedEvent, sender: self.gameSession) { notificatioin in
            
        }
    }
    
    private func makeMove(
}
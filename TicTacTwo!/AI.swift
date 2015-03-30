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
        return gameSession.currentPlayer == player
        }
    var isOpponent: Bool {
        return player == gameSession.opponent
    }
    
    init(player: Player, gameSession: GameSession) {
        self.player = player
        self.gameSession = gameSession
        if player != gameSession.opponent && player != gameSession.player {
            assert(false, "The player needs to be either the player or the opponent of the gameSession")
        }
        
        SwiftEventBus.onBackgroundThread(self, name: GameSession.movePlayedEvent, sender: self.gameSession) { notificatioin in
            if gameSession.currentPlayer == player {
                delay(2.0) {
                    self.makeMove()
                }
            }
        }
    }
    
    private func isSpaceFree(space: Int) -> Bool {
        return gameSession.game.board[space] == nil
        
    }
    
    private func makeMove() {
        var randomPosition: Int
        var success: Bool = false
        do {
            randomPosition = Int(arc4random_uniform(9))
        } while !isSpaceFree(randomPosition)
        
        if self.isOpponent {
            self.gameSession.makeOpponentMove(atIndex: randomPosition)
        } else if !self.isOpponent {
            self.gameSession.makePlayerMove(atIndex: randomPosition)
        }
        
    }
    deinit {
        log("I'm a gonner")
    }
}
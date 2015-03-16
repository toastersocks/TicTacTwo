//
//  GameSession+RemoteGameInfo.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/11/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation
/**
*  This extension enables GameSessions to be created from GameSessionInfo instances and allows for easily getting a GameSessionInfo from a GameSession
*/
extension GameSession {
    func getInfo() -> GameSessionInfo {
        if sessionType == .Remote {
            let opponentInfo = player
            player.playerType = .Remote(playerDisplayName: player.displayName)
            return GameSessionInfo(id: id, game: game, opponent: player)
        } else {
            return GameSessionInfo(id: id, game: game, opponent: opponent)
        }
    }
    
    convenience init(gameSessionInfo: GameSessionInfo) {
        let localPlayerPiece: Game.TicTacToePiece = gameSessionInfo.opponent.playerPiece == .X ? .O : .X
        let localPlayer = Player(displayName: nil, playerID: nil, playerPiece: localPlayerPiece, playerType: .Local)
        self.init(sessionType: .Remote, player: localPlayer, opponent: gameSessionInfo.opponent, game: gameSessionInfo.game, id: gameSessionInfo.id)
        
    }
}
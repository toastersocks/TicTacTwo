//
//  SessionManager.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/3/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation


class SessionManager {
    private var sessionsDict = [String : GameSession]()

    subscript(id: String) -> GameSession? {
        get {
            return sessionsDict[id]
        }
    }
    
    func addGameSession(newSession: GameSession) {
    
        sessionsDict[newSession.id] = newSession
    }
    
    func removeGameSession(id: String) {
        sessionsDict.removeValueForKey(id)
    }
    
    func newSessionWithOpponent(opponent: Player) {
        var sessionType: SessionType
        switch opponent.playerType {
        case .Local:
            sessionType = .Local
        case .Remote:
            sessionType = .Remote
        case .AI:
            sessionType = .SinglePlayer
        }
        let idString = opponent.playerID + NSDate().toString(formatString: "YYMMddhhmmss")
        let localPlayer = Player(displayName: "You", playerPiece: opponent.playerPiece == .X ? .O : .X)
        let newSession = GameSession(sessionType: sessionType, player: localPlayer, opponent: opponent, game: Game(), id: idString)
        addGameSession(newSession)
    }


    
}
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
    
    var count: Int {
        get {
            return sessionsDict.count
        }
    }

    subscript(id: String) -> GameSession? {
        get {
            return sessionsDict[id]
        }
    }
    
    func sorted(sortingFunc: (gameSession1: GameSession, gameSession2: GameSession) -> Bool) -> [GameSession] {
        return sessionsDict.values.array.sorted(sortingFunc)
    }
    
    func addGameSession(newSession: GameSession) {

        sessionsDict[newSession.id] = newSession
    }
    
    func removeGameSession(id: String) {
        sessionsDict.removeValueForKey(id)
    }
    
    func newSessionWithLocalOpponent() {
        let opponent = Player(displayName: nil, playerID: nil, playerPiece: .O, playerType: .Local)
        let player = Player(displayName: nil, playerID: nil, playerPiece: .X, playerType: .Local)
        let newGameSession = GameSession(sessionType: .Local, player: player, opponent: opponent)
        addGameSession(newGameSession)
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
        let localPlayer = Player(
            displayName: "You",
            playerID: Constants.localPlayer,
            playerPiece: opponent.playerPiece == .X ? .O : .X,
            playerType: Player.PlayerType.Local)
        
        let newSession = GameSession(sessionType: sessionType, player: localPlayer, opponent: opponent, game: Game(), id: idString)
        addGameSession(newSession)
    }


    
}





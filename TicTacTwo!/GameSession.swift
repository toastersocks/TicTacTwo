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
enum SessionType: String {
    case Local = "Local"
    case Remote = "Remote"
    case SinglePlayer = "Single Player"
}

/**
Represents a play session of a game
*/
class GameSession {
    
    let sessionType: SessionType
    let player: Player
    let opponent: Player
    var game: Game
    let id: String
    var currentPlayer: Player {
        get {
           return game.currentPlayer == player.playerPiece ? player : opponent
        }
    }
    var lastUpdated: NSDate = NSDate()
    
    init(sessionType: SessionType, player: Player, opponent: Player, game: Game, id: String) {
        self.sessionType = sessionType
        self.player = player
        self.opponent = opponent
        self.game = game
        self.id = id
    }
    
    convenience init(sessionType: SessionType, player: Player, opponent: Player) {
       let newID = player.playerID + opponent.playerID + NSDate().toString(formatString: "YYMMddhhmmss")
        self.init(sessionType: sessionType, player: player, opponent: opponent, game: Game(), id: newID)
       
    }
    
    func makePlayerMove(atIndex index: Int) {
        if player.playerPiece == game.currentPlayer {
            makeMove(atIndex: index)
        }
    }
    
    func makeOpponentMove(atIndex index: Int) {
        if opponent.playerPiece == game.currentPlayer {
            makeMove(atIndex: index)
        }
    }
    
    func makeMove(atIndex index: Int) {
        game.makeMoveAtIndex(index)
//        currentPlayer = game.currentPlayer == player.playerPiece ? player : opponent
    }
    
    /*func makeMove(#player: Player atIndex index: Int) {
        
    }*/
}

/**
*  This extension provides the game status in a human-readable form
*/
extension GameSession {
    /**
    This function returns the status of the game in a human-readable, friendly format.
    
    :returns: The status of the game as a String
    */
    func getHumanReadableStatus() -> String {
        
        var friendlyStatusString = ""
        var friendlyState = ""
        var friendlyName = ""
        
        // Assign the name
        switch (game.winningState, sessionType) {
            
        case (.Tie, _):
            friendlyName = "" // If it's a tie, we don't need a name
            break
        case (_, .Local):
            friendlyName = "\(currentPlayer.playerPiece.description)" //TODO: Don't duplicate this...
        default:
            if currentPlayer.playerType == .Local {
                friendlyName = "You"
            } else {
                friendlyName = currentPlayer.displayName
            }
        }
        
        // Assign the state of the game
        switch (game.winningState, sessionType) {
            
        case (.Tie, _):
            friendlyState = "It's a tie"
        case (.Unwon, _):
            if sessionType == .Local ||
                (sessionType != .Local && currentPlayer.playerType != .Local) {
                    
                    friendlyState = "'s turn"
            } else {
                "r turn"
            }
        default:
            friendlyState = " won!"
        }
        
        friendlyStatusString = friendlyName + friendlyState
        return friendlyStatusString
    }
   

}

extension GameSession: Equatable {
    
}

func ==(lhs: GameSession, rhs: GameSession) -> Bool {
    return lhs.id == rhs.id
}
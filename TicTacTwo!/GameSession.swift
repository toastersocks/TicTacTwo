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
class GameSession: NSObject {

    //Mark: - Notification events
    /// Notification Events
    static let movePlayedEvent = "movePlayedEvent"
    
    /// The type of GameSession: Local, Remote, or SinglePlayer (ie against an AI)
    let sessionType: SessionType
    
    /// The local player
    let player: Player
    
    /// The opponent player
    let opponent: Player
    
    /// The game being played
    var game: Game
    
    /// A unique string identifying the current GameSession
    let id: String
    
    ///  The Player who's turn it is
    var currentPlayer: Player {
        get {
           return game.currentPlayer == player.playerPiece ? player : opponent
        }
    }
    
    ///  The date and time of the last play
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
    
    
    /**
    Make a move as the local Player
    
    :param: index The position on the board to attempt a move
    
    :returns: Returns true if the move was successfully made
    */
    func makePlayerMove(atIndex index: Int) -> Bool {
        if player.playerPiece == game.currentPlayer {
           return makeMove(atIndex: index)
        } else {
            return false
        }
    }
    
    /**
    Make a move as the opponent Player
    
    :param: index The position on the board to attempt a move
    
    :returns: Returns true if the move was successfully made
    */
    func makeOpponentMove(atIndex index: Int) -> Bool {
        if opponent.playerPiece == game.currentPlayer {
           return makeMove(atIndex: index)
        } else {
            return false
        }
    }
    
    /**
    Make a move as the current Player
    
    :param: index The position on the board to attempt a move
    
    :returns: Returns true if the move was successfully made
    */
    func makeMove(atIndex index: Int) -> Bool {
        let moveWasSuccessfull: Bool = game.makeMoveAtIndex(index)
        if moveWasSuccessfull {
            SwiftEventBus.post(GameSession.movePlayedEvent, sender: self)
        }
        return moveWasSuccessfull
    }
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
                (sessionType != .Local && currentPlayer == opponent) {
                    
                    friendlyState = "'s turn"
            } else {
                friendlyState = "r turn"
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
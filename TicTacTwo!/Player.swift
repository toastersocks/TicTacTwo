//
//  Player.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/4/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation

/**
*  The Player class acts as a proxy for players of a game. Players can represent participants playing locally on the current device, remotely on another device, and those controlled by a non-human AI
*/
public class Player: NSObject, NSCoding {
    
    /**
    The type of Player
    
    - Local:  Denotes a Local Player
    - Remote: Denotes that a Player represents a remote player. The associated value is the display name of the remote Player
    - AI:     Denotes that a Player represents an AI player
    */
    public enum PlayerType {

        case Local
        case Remote(playerDisplayName: String)
        case AI
    }
    
    /// The name of the Player suitable for display to the user
    let displayName: String
    /// A unique id String used to identify a player
    let playerID: String
    /// The TicTacToePiece the player uses for play
    let playerPiece: Game.TicTacToePiece
    /// The type of Player that is represented
    var playerType: PlayerType

    init(displayName: String?, playerID: String?, playerPiece: Game.TicTacToePiece, playerType: PlayerType) {
        
        if let name = displayName {
            self.displayName = name
        } else {
            self.displayName = playerPiece.description
        }
        
        if let id = playerID {
            self.playerID = id
        } else {
            self.playerID = self.displayName
        }
        
        self.playerPiece = playerPiece
        self.playerType = playerType
    }
    
    // MARK: - NSCoding
    
    /**
    *  This private struct encapsulates methods and variables used for the purpose of complying with the NSCoding protocol
    */
    private struct NSCodingAspect {
        
        static let key_playerType = "playerType"
        static let key_opponentDisplayName = "opponentDisplayName"
        static let key_displayName = "displayName"
        static let key_playerID = "playerID"
        static let key_playerPiece = "playerPiece"
        static let value_local = "Local"
        static let value_remote = "Remote"
        static let value_ai = "AI"
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(displayName,
            forKey: NSCodingAspect.key_displayName)
        
        aCoder.encodeObject(playerID,
            forKey: NSCodingAspect.key_playerID)
        
        aCoder.encodeObject(playerPiece.rawValue,
            forKey: NSCodingAspect.key_playerPiece)
        
        switch playerType {
        case .Local:
            aCoder.encodeObject(NSCodingAspect.value_local,
                forKey: NSCodingAspect.key_playerType)
            
        case .Remote(let opponentDisplayName):
            aCoder.encodeObject(NSCodingAspect.value_remote,
                forKey: NSCodingAspect.key_playerType)
            
            aCoder.encodeObject(opponentDisplayName,
                forKey: NSCodingAspect.key_opponentDisplayName)
            
        case .AI:
            aCoder.encodeObject(NSCodingAspect.value_ai,
                forKey: NSCodingAspect.key_playerType)
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        displayName = aDecoder.decodeObjectForKey(NSCodingAspect.key_displayName) as! String
        playerID = aDecoder.decodeObjectForKey(NSCodingAspect.key_playerID) as! String
        
        playerPiece = Game.TicTacToePiece(
            rawValue: (aDecoder.decodeObjectForKey(
                NSCodingAspect.key_playerPiece) as! String))!
        
        let playerTypeString = aDecoder.decodeObjectForKey(NSCodingAspect.key_playerType) as! String
        switch playerTypeString {
            
            case NSCodingAspect.value_local:
                playerType = .Local
            
            case NSCodingAspect.value_remote:
                
                let opponentDisplayName = aDecoder.decodeObjectForKey(NSCodingAspect.key_opponentDisplayName) as! String
                playerType = .Remote(playerDisplayName: opponentDisplayName)
                
            case NSCodingAspect.value_ai:
                playerType = .AI
            
        default:
            fatalError("ERROR decoding playerType")
        }
        
    }

}

extension Player: Equatable {
    
}

public func ==(lhs: Player, rhs: Player) -> Bool {
    
    return  lhs.displayName == rhs.displayName &&
            lhs.playerID == rhs.playerID       &&
            lhs.playerPiece == rhs.playerPiece &&
            lhs.playerType == rhs.playerType
}

extension Player {
    convenience init(displayName: String, playerPiece: Game.TicTacToePiece) {
        self.init(displayName: displayName, playerID: displayName, playerPiece: playerPiece, playerType: .Local)
    }
    
}

extension Player.PlayerType: Equatable {
}

public func ==(lhs: Player.PlayerType, rhs: Player.PlayerType) -> Bool {
    switch (lhs, rhs) {
    case (.Local, .Local):
        return true
    case (.AI, .AI):
        return true
    case (.Remote(_), .Remote(_)):
        return true
    default:
        return false
    }
}
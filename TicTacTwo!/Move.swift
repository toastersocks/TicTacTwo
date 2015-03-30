//
//  Move.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/10/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation

/**
*  A move in a GameSession. Suitable for sending over a network.
*/
class Move: NSObject, NSCoding {
    /// The index on the board of the tic tac toe move
    let boardIndex: Int
    /// The id of the GameSession in which the move was made
    let gameID: String

    init(boardIndex: Int, gameID: String) {
        self.boardIndex = boardIndex
        self.gameID = gameID
    }
    
    /**
    *  This private struct encapsulates methods and variables used for the purpose of complying with the NSCoding protocol
    */
    private struct NSCodingAspect {
        static let key_boardIndex = "boardIndex"
        static let key_gameID = "gameID"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(boardIndex, forKey: NSCodingAspect.key_boardIndex)
        aCoder.encodeObject(gameID, forKey: NSCodingAspect.key_gameID)
    }
    
    required init(coder aDecoder: NSCoder) {
        boardIndex = aDecoder.decodeIntegerForKey(NSCodingAspect.key_boardIndex) as Int
        gameID = aDecoder.decodeObjectForKey(NSCodingAspect.key_gameID) as! String
    }
}
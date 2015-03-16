//
//  GameSessionInfo.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/11/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation


/**
*  This class encapsulates the information associated with a GameSession.
*/
class GameSessionInfo: NSObject, NSCoding {
    let id: String
    let game: Game
    let opponent: Player
    
    init(id: String, game: Game, opponent: Player) {
        self.id = id
        self.game = game
        self.opponent = opponent
    }

    /**
    *  This private struct encapsulates methods and variables used for the purpose of complying with the NSCoding protocol
    */
    private struct NSCodingAspect {
        static let key_id = "id"
        static let key_game = "game"
        static let key_opponent = "opponenet"
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: NSCodingAspect.key_id)
        aCoder.encodeObject(game, forKey: NSCodingAspect.key_game)
        aCoder.encodeObject(opponent, forKey: NSCodingAspect.key_opponent)
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObjectForKey(NSCodingAspect.key_id) as String
        game = aDecoder.decodeObjectForKey(NSCodingAspect.key_game) as Game
        opponent = aDecoder.decodeObjectForKey(NSCodingAspect.key_opponent) as Player
    }
}
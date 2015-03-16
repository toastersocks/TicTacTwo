//
//  GameSession_Tests.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/14/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit
import XCTest

class GameSession_Tests: XCTestCase {
   
    var gameSession: GameSession = {
        let player = Player(displayName: "Player1", playerID: "Player1234", playerPiece: .X, playerType: .Local)
        let opponent = Player(displayName: "Player2", playerID: "Player9876", playerPiece: .O, playerType: .Remote(playerDisplayName:"Player1"))
        return GameSession(sessionType: .Remote, player: player, opponent: opponent, game: Game(), id: "1234")
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetHumanReadableStatus() {
        var gameStatusShouldBeThis = "Your turn"
        XCTAssertEqual(gameSession.getHumanReadableStatus(), gameStatusShouldBeThis,
            "Game status should be \"\(gameStatusShouldBeThis)\" but instead is \"\(gameSession.getHumanReadableStatus()).\"")
    
        gameSession.makePlayerMove(atIndex: 0)
        gameStatusShouldBeThis = "\(gameSession.opponent.displayName)\'s turn"
//        gameStatusShouldBeThis = "Waiting for \(gameSession.opponent.displayName)"
        
        XCTAssertEqual(gameSession.getHumanReadableStatus(), gameStatusShouldBeThis,
            "Game status should be \"\(gameStatusShouldBeThis)\" but instead is \"\(gameSession.getHumanReadableStatus()).\"")

        gameSession.makeOpponentMove(atIndex: 1)
        gameSession.makePlayerMove(atIndex: 3)
        gameSession.makeOpponentMove(atIndex: 4)
        gameSession.makePlayerMove(atIndex: 6)
        gameStatusShouldBeThis = "You won!"
        
        XCTAssertEqual(gameSession.getHumanReadableStatus(), gameStatusShouldBeThis,
            "Game status should be \"\(gameStatusShouldBeThis)\" but instead is \"\(gameSession.getHumanReadableStatus()).\"")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}

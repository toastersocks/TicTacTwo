//
//  TicTacTwo_Tests.swift
//  TicTacTwo!Tests
//
//  Created by James Pamplona on 2/20/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit
import XCTest


class TicTacTwo_Tests: XCTestCase {
    
    let game = Game()
    
    override func setUp() {
        super.setUp()
        game.currentPlayer = .X
        game.board = [Optional<Game.TicTacToePiece>](count: 9, repeatedValue: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMakeMoveAtIndex() {
        var boardShouldBeThis = [Optional<Game.TicTacToePiece>](count: 9, repeatedValue: nil)
        boardShouldBeThis[3] = .X
        
        game.makeMoveAtIndex(3)
        
        // Was the move successfully made in the correct position?
        if game.board != boardShouldBeThis {
            XCTAssert(false, "Space at board index 3 should be equal to \(Game.TicTacToePiece.X.description)")
        }
        // Does the game rightly prevent us from making a move in a space that's already played?
        XCTAssert(!game.makeMoveAtIndex(3), "The game shouldn't let players make a move in a space that's already played")
    }
    
    
    func testIsPossibleWinPlayed() {
        game.board[0...2] = [Game.TicTacToePiece.X, Game.TicTacToePiece.X, Game.TicTacToePiece.X]
        
        XCTAssert(game.isPossibleWinPlayed([0,1,2]),
            "Function should return true when the board positions passed match the currentPlayer")
        
        XCTAssertFalse((game.isPossibleWinPlayed([1, 3, 6]) && game.isPossibleWinPlayed([6, 7, 8])),
            "Function should return false when the board positions passed do not match the currentPlayer")
    }
    
    func testwinningState() {
        game.board[0...2] = [Game.TicTacToePiece.X, Game.TicTacToePiece.X, Game.TicTacToePiece.X]
        
        /* Test win with one position 
        X,X,X
        _,_,_
        _,_,_
        */
        
        XCTAssert(game.winningState == Game.WinningState.Win([[0,1,2]]), "Function should return a .Win with the associated win positions when there is a winning position played (one in this case)")
        
        
        /**
        Test win with two positions:
        X,X,X
        X,_,_
        X,_,_
        */
        
        game.board[3] = .X
        game.board[6] = .X
        
        XCTAssertTrue(game.winningState == Game.WinningState.Win([[0,1,2],[0,3,6]]), "Function should return a .Win containing all winning positions (either one or two) (two in this case)")
        
        /**
        Test board in unwon state:
        O,X,X
        X,_,_
        X,_,_
        */

        XCTAssertFalse(game.winningState == Game.WinningState.Unwon, "Function should return a WinningState of .Unwon when the board is in an unwon state")
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

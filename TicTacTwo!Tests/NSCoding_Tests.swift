//
//  NSCoding_Tests.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/13/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit
import XCTest

class NSCoding_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testPlayerCoDec() {
        let key_player = "player"
        let beforePlayer = Player(displayName: "testPlayer", playerID: "testPlyer1234", playerPiece: .X, playerType: .Local)
        let data = NSMutableData()
        let aCoder = NSKeyedArchiver(forWritingWithMutableData: data)
        aCoder.encodeObject(beforePlayer, forKey: key_player)
        aCoder.finishEncoding()
        
        let aDecoder = NSKeyedUnarchiver(forReadingWithData: data)
        let afterPlayer = aDecoder.decodeObjectForKey(key_player) as Player
        
        XCTAssertEqual(beforePlayer, afterPlayer, "Player objects should be equal before and after coding and decoding")
//        XCTAssert(true, "Pass")
        
    }
    
    func DISABLEtestExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func DISABLEtestPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}

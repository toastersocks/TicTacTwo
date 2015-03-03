//
//  Extensions.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 2/21/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation


extension Game.TicTacToePiece : Printable {
    
    public var description: String {
        switch self {
        case .X:
            return "X"
        case .O:
            return "O"
        }
    }
    
}


/*extension Game.TicTacToePiece : Equatable {
    
}*/


public func ==<T: Equatable>(lhs: [T?], rhs: [T?]) -> Bool {
    if lhs.count != rhs.count {
        return false
    }
    for (index, value) in enumerate(lhs) {
        if value != rhs[index] {
            return false
        }
    }
    return true
}
public func !=<T: Equatable>(lhs: [T?], rhs: [T?]) -> Bool {

return !(lhs == rhs)
}

extension Game.WinningState : Equatable {
}

public func ==(lhs: Game.WinningState, rhs: Game.WinningState) -> Bool {
  
    switch (lhs, rhs) {
    case (.Unwon, .Unwon):
        return true
    case (.Win(let leftWinArray), .Win(let rightWinArray)) where leftWinArray == rightWinArray:
        return true
    case (.Tie, .Tie):
        return true
    default:
        return false
        
    }
    
}

extension Int {
    /*func isEven() -> Bool {
        return self % 2 == 0
    }*/
    
    /*func isOdd() -> Bool {
        return !(self.isEven())
    }*/
    
    var isEven: Bool {
        get {
            return self % 2 == 0
        }
    }
    
    var isOdd: Bool {
        get {
            return !(self.isEven)
        }
    }
}


extension Array {
    /**
    Creates a multidimensional array out of a flat array (opposit of flatten). Returns an array with one more dimension of size width with the elements of the original array. If the size specified by width does not divide evenly into the number of elements, the last subarray will consist of the remainder of elements. 
    
    :param: width The elements will be subdivided into subarrays of width length
    
    :returns: Returns an array with all the elements of the original array split into subarrays of length width
    */
    func subdivide(#width: Int) -> [[Element]]  {
        var returnArray: [[Element]] = []
        var index = 0
        
        while index < self.count {
            var subArray: [Element] = []
            
            do {
                subArray.append(self[index])
                index++
            } while (index % width != 0) && (index < self.count)
            
            returnArray.append(subArray)
        }
        
        return returnArray
    }
    
    
    // TODO: Create a version of the above function that fills the last element with the filler param when the width does not divide evenly into the array
    /*
    func subdivide(#width: Int, filler: AnyObject) -> [[Element?]]  {
        var returnArray: [[Element]] = []
        var index = 0
        
        while index < self.count {
            var subArray: [Element] = []
            
            do {
                subArray.append(self[index])
                index++
            } while index % width != 0
            
            returnArray.append(subArray)
        }
        
        return returnArray
    }
    */
    
    
}


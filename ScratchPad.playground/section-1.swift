// Playground - noun: a place where people can play

import UIKit


func compareArrays<E: Equatable>(Array1: Array<E>, Array2: Array<E>) -> Bool {
    var isMatch = true
    for (index, value) in enumerate(Array1) {
        if Array2[index] != value {
            isMatch = false
            return isMatch
        }
    }
    return isMatch
}


var currentPlayer = 0
var str = "Hello, playground"
var board: [Int?] = [0,0,1,1,0,1,1,0, 0]

let possibleWinIndexes = [0, 1, 2]

enum FuckShit {
    case Shit(String)
    case Fuck
}

func subdivide<E>(array: [E], width: Int) -> [[E]]  {
        var returnArray: [[E]] = []
        var index = 0
        
        while index < array.count {
            var subArray: [E] = []
            
            do {
                subArray.append(array[index])
                index++
            } while (index % width != 0) && (index < array.count)
            
            returnArray.append(subArray)
        }
        
        return returnArray
    }



let multDimenArr = [
    [1,0,0],
    [0,1,0],
    [0,0,1]
]

let singleDimenArr = [
    1,0,0,
    0,1,0,
    0,0
]



let flattendArr = multDimenArr.reduce([], +)


let subDividedArr = subdivide(singleDimenArr, 3)

let a1:[Int?] = [1,2,3]
let a2:[Int?] = [1,2,3]
let o1: Int = 1
let o2: Int? = 1
o1 == o2
//a1 == a2


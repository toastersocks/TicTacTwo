// Playground - noun: a place where people can play

import UIKit
var currentPlayer = 0
var str = "Hello, playground"
var board: [Int?] = [0,0,1,1,0,1,1,0, 0]

let possibleWinIndexes = [0, 1, 2]


 let closure = { (ticTacToeMark: Int) -> Bool in
    if board[ticTacToeMark] == currentPlayer {
        
        return true
    } else {
        return false
    }
}

func isWinner(localBoard: [Int?], localPossibleWinIndexes: [Int]) -> Bool {
    let numberOfWinningMarks = localPossibleWinIndexes.filter(closure).count
    if numberOfWinningMarks >= 3 {
        return true
    } else {
        
        return false
    }
}


if isWinner(board, possibleWinIndexes) {
    println("Winner!")
} else {
    println("Not Winner")
}

let wins = board.filter { $0 == nil }
println(wins.isEmpty)
let nonOptionalWins = wins.map { $0! }
println(nonOptionalWins)

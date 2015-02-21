//
//  Game.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 2/20/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation

public class Game {
    
    // MARK: - Enums
    
    public enum TicTacToePiece: Printable {
        case X
        case O
    
        public var description: String {
            switch self {
            case .X:
                return "X"
            case .O:
                return "O"
            }
        }
    }
    
    enum WinningState {
        case Win([[Int]]) // Wins hold an array of winning plays (either 1 or 2 at most are possible for tic tac toe)
        case Unwon // Game is not in a winning state
    }
    
    // MARK: - Properties
    
    // TODO: Make this into a Set of Sets in Swift 1.2 -- and make this into a static class constant
    let possibleWins = [[0, 1, 2],
                        [0, 3, 6],
                        [0, 4, 8],
                        [3, 4, 5],
                        [6, 7, 8],
                        [6, 4, 2],
                        [1, 4, 7],
                        [2, 5, 8]]
    
    var board = [TicTacToePiece?](count: 9, repeatedValue: nil)
    
    var currentPlayer: TicTacToePiece = .X
    
    // MARK: - Methods
    
        
    func makeMoveAtIndex(index: Int) -> Bool {
        assert( 0..<board.count ~= index , "Index is out of range. Must be between 0-\(board.count - 1).")

        if board[index] == nil { // If the space is currently unplayed, then play it
            board[index] = currentPlayer
            return true // Move was successful
        } else {
            return false // Move failed
        }
    }
    
    func isPossibleWinPlayed(positions: [Int]) -> Bool {
        
        let currentPlayerPiecesInPosition: Int = positions.filter { position in
                self.board[position] == self.currentPlayer
            }.count
        
        return currentPlayerPiecesInPosition >= positions.count // if all pieces match the current player's, then it's a win! Otherwise it's not
        }
    
    
    func isBoardInWinningState() -> WinningState {
       let winningPlays = possibleWins.filter { possibleWin in self.isPossibleWinPlayed(possibleWin) }
        if winningPlays.isEmpty { // The current player has not won yet
            return WinningState.Unwon
        } else { // The current player won!
            return WinningState.Win(winningPlays)
        }
    }
    
    }
    

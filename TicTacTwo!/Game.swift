//
//  Game.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 2/20/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation

/**
This class represents a game of Tic Tac Toe
*/
public class Game {
    
    // MARK: - Enums
    
    /**
    The possible game pieces in a game of Tic Tac Toe
    
    - X: The 'X' piece
    - O: The 'O' piece
    */
    public enum TicTacToePiece: String {
        case X = "x"
        case O = "o"
     }
    
    /**
    The possible win states of a Tic Tac Toe game.
    
    - Win: A win state denotes that the game is won by the current player. The value associated with a Win is an array containing the winning positions (either one or two) that resulted in the win.
    - Unwon: Indicates the game is not yet won and play is still possible.
    - Tie: Indicates that the game is not won and there are no free spaces to play (i.e. The game is tied)
    */
    public enum WinningState {
        case Win([[Int]])
        case Unwon
        case Tie
    }
    
    // MARK: - Properties
    
    // TODO: Make this into a Set of Sets in Swift 1.2 -- and make this into a static class constant

    /// An array of all the possible winning series in a game of Tic Tac Toe
    private let possibleWins = [[0, 1, 2],
                                [0, 3, 6],
                                [0, 4, 8],
                                [3, 4, 5],
                                [6, 7, 8],
                                [6, 4, 2],
                                [1, 4, 7],
                                [2, 5, 8]]
    
    /** An array of optional TicTacToe pieces representing the board left to right and top to bottom (i.e. index 0 is the top-left corner, 2 the top right, etc....)
    [0,1,2,
     3,4,5,
     6,7,8]
    */
    private(set) var board = [Optional<TicTacToePiece>](count: 9, repeatedValue: nil)
    
    /// The piece of the player who's turn it is. This is the piece that will be put down when makeMoveAtIndex() is called. It is also the piece that won the game if winningState is a .Win
    var currentPlayer: TicTacToePiece = .X
    
    /// The WinningState of the game; either it's won (.Win with the winning series of moves) still ongoing (.Unwon) or unwon with no further play possible i.e. a tie (.Tie)
    var winningState: WinningState {
        get {
            let winningPlays = possibleWins.filter { possibleWin in self.isPossibleWinPlayed(possibleWin) }
            if winningPlays.isEmpty { // The current player has not won yet...
                if board.filter ({space in space == nil}).isEmpty { // ...and there are no winning plays, then it's a tie
                    return WinningState.Tie
                } else { // Otherwise, the game is Unwon and play continues
                    return WinningState.Unwon
                }
            } else { // The current player won!
                return WinningState.Win(winningPlays)
            }
        }
    }
    
    // MARK: - Init
    
    init(board: [TicTacToePiece?]) {
        self.board = board
//        super.init()
    }
    
    convenience init() {
        let emptyBoard = [TicTacToePiece?](count: 9, repeatedValue: nil) // Swift compiler complaining when putting this array constructor directly as a paramater of the line below. Why...?
        self.init(board: emptyBoard)
    }

    
    // MARK: - Methods
    
    /**
    Makes a move with the current player's piece at the specified board index, if the space is free and the game is not in a .Win state. Does nothing otherwise. After a successfull move is made, the currentPlayer property will switch to the opposite piece
    
    :param: index The index on the board to attempt a move
    
    :returns: This method returns true if the move was successfully made (the space on the board was free), or false if the move was not successful ( the space was already occupied).
    */
    func makeMoveAtIndex(index: Int) -> Bool {
        assert( 0..<board.count ~= index , "Index of \(index) is out of range. Must be between 0-\(board.count - 1).")

        if board[index] == nil && winningState == .Unwon { // If the game is Unwon and the space is currently unplayed, then play it
            board[index] = currentPlayer
            if winningState == .Unwon {
                currentPlayer = currentPlayer == .X ? .O : .X
            }
            return true // Move was successful
        } else {
            return false // Move failed
        }
    }
    /**
    This method checks an array of board indexes against the current player's piece and returns true if they all match. Used to check if a series of winning moves are successfully played by the current player
    
    :param: possibleWin An array of board indexes
    
    :returns: Returns true if the all the board indexes passed in are occupied by the currentPlayer's piece
    */
    func isPossibleWinPlayed(possibleWin: [Int]) -> Bool {
        
        let currentPlayerPiecesInPosition: Int = possibleWin.filter { position in
                self.board[position] == self.currentPlayer
            }.count
        
        return currentPlayerPiecesInPosition >= possibleWin.count // if all pieces match the current player's, then it's a win! Otherwise it's not
        }
    
    
    
}
    

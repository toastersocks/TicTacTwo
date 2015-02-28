//
//  TicTacToeCell.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 2/24/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit

class TicTacToeCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel! {
        willSet {
            debugPrintln(newValue)
        }
    }
    
   
}

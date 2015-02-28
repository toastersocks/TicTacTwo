//
//  SeparatorReusableView.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 2/27/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit

class SeparatorReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.blackColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.backgroundColor = UIColor.blackColor()
    }
}

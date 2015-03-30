//
//  TicTacToeFlowLayout.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 2/27/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit

class TicTacToeFlowLayout: UICollectionViewFlowLayout {
    
    var decorationElementKind: String = ""
    
    override func registerClass(viewClass: AnyClass?, forDecorationViewOfKind elementKind: String) {
        decorationElementKind = elementKind
        
        super.registerClass(viewClass, forDecorationViewOfKind: elementKind)
    }
    
    override func registerNib(nib: UINib?, forDecorationViewOfKind elementKind: String) {
        decorationElementKind = elementKind
        
        super.registerNib(nib, forDecorationViewOfKind: elementKind)
    }
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        
//        super.layoutAttributesForDecorationViewOfKind(elementKind, atIndexPath: indexPath)
        
        let layoutAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, withIndexPath: indexPath)
        
        if elementKind == decorationElementKind {
        
            var originPoint = CGPoint()
            var size = CGSize()
            if indexPath.item.isEven { // vertical lines
                size.width = sectionInset.left
                size.height = collectionViewContentSize().height
                originPoint.y = 0
                if indexPath.item == 0 {
                    originPoint.x = collectionViewContentSize().width / 3
                } else if indexPath.item == 2 {
                    originPoint.x = collectionViewContentSize().width / 3 * 2
                }
            } else { // If it's odd, then it's a horizontal line
                size.width = collectionViewContentSize().width
                size.height = sectionInset.top
                originPoint.x = 0
                
                if indexPath.item == 1 {
                    originPoint.y = collectionViewContentSize().height / 3
                    
                } else if indexPath.item == 3 {
                    originPoint.y = collectionViewContentSize().height / 3 * 2
                }
            }
            
            layoutAttributes.frame = CGRect(origin: originPoint, size: size)
        }

        return layoutAttributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributesInRect = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
        
        for decorationIndex in 0...3 {
            attributesInRect.append(layoutAttributesForDecorationViewOfKind(
                    decorationElementKind,
                    atIndexPath: NSIndexPath(forItem: decorationIndex, inSection: 0))
            )
        }
        return attributesInRect
    }
    
}

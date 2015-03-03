//
//  TicTacToeViewController.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 2/24/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TicTacToeSpace"
private let separatorReuseID = "CellSeparator"
private let ticTacToeSegue = "TicTacToeSegue"

class TicTacToeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var collectionView: UICollectionView!
    @IBOutlet weak var displayLabel: UILabel!
    var game = Game()

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ticTacToeSegue {
            collectionView = segue.destinationViewController.collectionView as UICollectionView
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let nib = UINib(nibName: "TicTacToeLine", bundle: nil)
        collectionView.collectionViewLayout.registerNib(nib, forDecorationViewOfKind: separatorReuseID)
//        collectionView.collectionViewLayout.registerClass(SeparatorReusableView.self, forDecorationViewOfKind: separatorReuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        displayLabel.text = "\(game.currentPlayer.description)\'s Turn"
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func reloadData() {
        collectionView?.reloadData()
        displayLabel.text = "\(game.currentPlayer.description)\'s Turn"
    }
    
    @IBAction func startNewGame() {
        game = Game()
        reloadData()
    }
    
    
    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return game.board.count
    }
    
   
    /*override func func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
    }*/
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as TicTacToeCell
            cell.textLabel.text = game.board[indexPath.item]?.description ?? ""
        return cell
    }

    // MARK: UICollectionViewDelegate

//    override func collectionView(collectionView: UICollectionView, layout: 
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = min(collectionView.bounds.size.width, collectionView.bounds.size.height) - collectionViewLayout.minimumInteritemSpacing * 4 - 1
        return CGSize(
            width: size / 3,
            height: size / 3)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if game.makeMoveAtIndex(indexPath.item) {
            reloadData()
            switch game.winningState {
            case .Win(let winningMoves):
                displayLabel.text = "\(game.currentPlayer) won!"
            case .Tie:
                displayLabel.text = "It's a tie"
            default:
                break
            }
            
        }
        
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    /*override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }*/
    

}

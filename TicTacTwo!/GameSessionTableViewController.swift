//
//  GameSessionTableViewController.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/4/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit

class GameSessionTableViewController: UITableViewController, UIActionSheetDelegate {

    let gameSessionCellReuseID = "GameCell"
    let ticTacToeSegueID = "TicTacToeSegue"
    
    let sessionManager = SessionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func createNewGame(sender: UIBarButtonItem) {
     let actionSheet = UIActionSheet(title: "New...", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Local Game", "Remote Game", "Single Player Game")
        actionSheet.showInView(self.view)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            tableView.beginUpdates()
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            sessionManager.newSessionWithLocalOpponent()
            tableView.endUpdates()
            
        default:
            return
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return sessionManager.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(gameSessionCellReuseID, forIndexPath: indexPath) as UITableViewCell
        
        let orderedSessions = sessionManager.sorted{ $0.lastUpdated.laterDate($1.lastUpdated) == $0.lastUpdated }
        let gameSession = orderedSessions[indexPath.row]
        
        cell.textLabel?.text = "VS \(gameSession.opponent.displayName)"
        cell.detailTextLabel?.text = gameSession.getHumanReadableStatus()
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? TicTacToeViewController {

            if let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPathForCell(cell) {
                    let selectedGameSession = sessionManager.sorted{ $0.lastUpdated.laterDate($1.lastUpdated) == $0.lastUpdated }[indexPath.row]
                    destinationViewController.gameSession = selectedGameSession
                }
            }
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

}

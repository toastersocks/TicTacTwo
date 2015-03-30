//
//  RemoteUserTableViewController.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/6/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit
import MultipeerConnectivity

public class RemoteUserTableViewController: UITableViewController, UITextFieldDelegate {
    
    public let didSelectOpponentEvent = "didSelectOpponentEvent"
    
    enum OnFindConnect {
        case Find
        case Connect
    }
    var onFindConnect: OnFindConnect = .Connect
    
    // TODO: Make these static class constants in Swift 1.2
//    let serviceDescriptor = "tictacservice"
    let remoteUserCellID = "RemoteUserCell"

    @IBOutlet weak var usernameTextField: UITextField!
    var partyManager: PartyManager = PartyManager.sharedInstance
    var localPeerNames = [MCPeerID: String]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        
        if partyManager.localUserName != "" {
            usernameTextField.text = partyManager.localUserName
        }
        

        switch onFindConnect {
        case .Connect:
            SwiftEventBus.onMainThread(self, name: PartyManager.didConnectToPeerIDEvent) { result in
                self.reloadData()
            }
            SwiftEventBus.onMainThread(self, name: PartyManager.didDisconnectFromPeerIDEvent) { result in
                self.reloadData()
            }
        case .Find:
            SwiftEventBus.onMainThread(self, name: PartyManager.didFindPeerIDEvent) { result in
                self.reloadData()
            }
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        let localUserName = textField.text
        partyManager.localUserName = localUserName
    }
    
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func reloadData() {
        tableView.reloadData()
    }
   
    
    // MARK: - TableViewDelegate Methods
    
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - Table view data source

    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return partyManager.connectedPeers.count
//        return partyManager.foundPeers.count
    }

    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(remoteUserCellID, forIndexPath: indexPath) as! UITableViewCell

        if let displayName = partyManager.nameForPeerID(partyManager.connectedPeers[indexPath.row]) {
//        if let displayName = partyManager.nameForPeerID(partyManager.foundPeers[indexPath.row]) {
        cell.textLabel?.text = displayName
        } else {
            cell.textLabel?.text = "WHAT HAPPENED?"
        }
        return cell
    }
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let peerID = partyManager.connectedPeers[indexPath.row]
        let opponent = Player(displayName: partyManager.nameForPeerID(peerID), playerID: peerID.displayName, playerPiece: Game.TicTacToePiece.O, playerType: Player.PlayerType.Remote(playerDisplayName: partyManager.nameForPeerID(peerID)!))
        SwiftEventBus.post(didSelectOpponentEvent, sender: opponent)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
//        partyManager.sendMessage("Someone wants to start a game with you!" as NSString, toPeerID: partyManager.connectedPeers[indexPath.row])
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}

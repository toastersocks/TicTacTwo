//
//  PartyManager.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/9/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//
import MultipeerConnectivity
//import SwiftEventBus

public class PartyManager : JSMultiPartyDelegate {
    // TODO: Make these stored static class variables in Swift 1.2
    public class var didConnectToPeerIDEvent: String {return "didConnectToPeerIDEvent"}
    public class var didDisconnectFromPeerIDEvent: String {return "didDisconnectFromPeerIDEvent"}
    public class var didFindPeerIDEvent: String {return "didFindPeerIDEvent"}
    public class var didLosePeerIDEvent: String {return "didLosePeerIDEvent"}
    public class var receivedStringMessageEvent: String {return "receivedStringMessageEvent"}
    public class var receivedGameMoveEvent: String {return "receivedGameMoveEvent"}
    public class var receivedNewGameEvent: String {return "receivedNewGameEvent"}
    public class var key_peerDisplayName: String {return "key_peerDisplayName"}
    public class var key_message: String {return "key_message"}
    public class var key_move: String {return "key_move"}
    public class var key_gameID: String {return "key_gameID"}
    public class var key_gameSession: String {return "key_gameSession"}
    
    public class var sharedInstance: PartyManager {
        struct Singleton {
            static let instance = PartyManager()
        }
        return Singleton.instance
    }
    
    let serviceDescriptor = "tictacservice"
    
    var localUserName: String = Defaults[Constants.key_userName].string ?? "" {
        didSet {
            Defaults[Constants.key_userName] = localUserName
            let isSuccess = Defaults.synchronize()
            if isSuccess == false {
                fatalError("Could not save user defaults")
            }
            
            peerBrowser.connectAs(localUserName)
            /*let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let documentsDir = paths.first
            let filePath = documentsDir + optionsFileName*/
        }
    }
    
    var localUserIDName: String {
        return peerBrowser.myPeerId.displayName
    }
    
    var localPeerID: MCPeerID {
        return peerBrowser.myPeerId
    }
    
    lazy var peerBrowser: JSMultiParty = {
        let serviceDescriptor = "tictacsrvc"
        //        let bundleName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as String
        let bundleName = "jcp"
        let serviceName = bundleName + "-" + serviceDescriptor
        
        return JSMultiParty(serviceType: serviceName)
        }()
    
    private var localPeerNames = [MCPeerID: String]()

    public var connectedPeers: [MCPeerID] {
        get {
            return peerBrowser.connectedPeers()
        }
    }
    
    public var foundPeers = [MCPeerID]()
    
    init() {
        peerBrowser.delegate = self
        if localUserName != "" {
            peerBrowser.connectAs(localUserName)
        }
    }
    
    public func sendMessage(message: AnyObject, toPeerID peerID: MCPeerID) {
        peerBrowser.sendMessageToPeerId(peerID, message: message)
    }
    
    public func sendMessage(message: AnyObject, toPeerWithDisplayName displayName: String) {
        if let peer = peerIDForDisplayName(displayName) {
            sendMessage(message, toPeerID: peer)
        }
    }
    
    public func nameForPeerID(peerID: MCPeerID) -> String? {
        return localPeerNames[peerID]
    }
    
    public func peerIDForDisplayName(displayName: String) -> MCPeerID? {
        return dictionaryElementsForValue(localPeerNames, displayName).first?.0
    }
    
    
	
    
    
    // MARK: - JSMultiPartyDelegate methods
    
    public func didReceiveMessageFromPeerId(peerId: MCPeerID, message: AnyObject) {
        
        var infoDict: Dictionary<String, AnyObject> = [String : AnyObject]()
        
        switch message {
        case let stringMessage as String:
            
            infoDict[PartyManager.key_peerDisplayName] = nameForPeerID(peerId)
            infoDict[PartyManager.key_message] = stringMessage
            
            SwiftEventBus.post(PartyManager.receivedStringMessageEvent, sender: peerId, userInfo: infoDict)
            
        case let move as Move:
            infoDict[PartyManager.key_move] = move
            infoDict[PartyManager.key_peerDisplayName] = nameForPeerID(peerId)
            SwiftEventBus.post(PartyManager.receivedGameMoveEvent, sender: peerId, userInfo: infoDict)
        
        case let newGameInfo as GameSessionInfo:
            infoDict[PartyManager.key_peerDisplayName] = nameForPeerID(peerId)
            infoDict[PartyManager.key_gameSession] = newGameInfo
            SwiftEventBus.post(PartyManager.receivedNewGameEvent, sender: peerId, userInfo: infoDict)
        default:
            break
        }
    }
    
    public func didConnectToPeerId(peerId: MCPeerID) {
        SwiftEventBus.post(PartyManager.didConnectToPeerIDEvent, sender: self)
        log("CONNECTED TO: " + peerId.displayName)
        debugPrintln("WITH NAME: " + (localPeerNames[peerId] ?? "peer not found"))
    }
    
    public func didDisconnectFromPeerId(peerId: MCPeerID) {
        log("DISCONNECTED FROM: " + peerId.displayName)
        debugPrintln("WITH NAME: " + (localPeerNames[peerId] ?? "peer not found"))
        
        SwiftEventBus.post(PartyManager.didDisconnectFromPeerIDEvent, sender: self)

        
    }
    
    public func didFindPeerId(peerId: MCPeerID, name: String?) {
        if let peerUserName = name {
            localPeerNames[peerId] = peerUserName
        }
        if find(foundPeers, peerId) != nil {
            foundPeers.append(peerId)
        }
        SwiftEventBus.post(PartyManager.didFindPeerIDEvent, sender: self)

        log("FOUND: " + peerId.displayName)
        debugPrintln("WITH NAME: " + (name ?? "name not provided"))
    }
    
    public func didLosePeerId(peerId: MCPeerID) {
        log("LOST PEER: " + peerId.displayName)
        debugPrintln("WITH NAME: " + (localPeerNames[peerId] ?? "peer not found"))
        localPeerNames[peerId] = nil
        if let peerIndex = find(foundPeers, peerId) {
            foundPeers.removeAtIndex(peerIndex)
        } else {
            log("Could not remove peer. Peer not found")
        }
        
        SwiftEventBus.post(PartyManager.didLosePeerIDEvent, sender: self)

    }
    
    public func didStartReceivingImage(peerId: MCPeerID, progress: NSProgress) {
        
    }
    
    public func didFinishReceivingImage(peerId: MCPeerID, image: UIImage) {
        
    }
    
    public func didReceiveStream(stream: NSInputStream, withName: String, fromPeer: MCPeerID) {
        
    }
    public func didFailToReceiveImage(peerId: MCPeerID, error: NSError) {
        
    }
    public func didNotStartAdvertisingPeer(error: NSError) {
        log(error.debugDescription)
    }
    public func didNotStartBrowsingForPeers(error: NSError) {
        log(error.debugDescription)
    }

    
}

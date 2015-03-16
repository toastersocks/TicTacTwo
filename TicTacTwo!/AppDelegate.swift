//
//  AppDelegate.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 2/20/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import UIKit
//import MultipeerConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let partyManager = PartyManager.sharedInstance


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
        SwiftEventBus.onMainThread(self, name: PartyManager.receivedStringMessageEvent) { notification in
            if let peerID = notification.object as? MCPeerID {
                if let infoDict = notification.userInfo as Dictionary! {
                    if let message = infoDict[PartyManager.key_message] as? String {
                        
                       let senderDisplayName = self.partyManager.nameForPeerID(peerID)
                        
                        let alertController = UIAlertController(title: "Message from \(senderDisplayName!)", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                        let alertAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                            self.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                            return Void() // !!!: This is needed to so the compiler doesn't complain. WHY??? Without it, the compiler thinks the closure returns something and complains about init not taking arguments of type ()->()->()-> etc....
                        }
                        
                        alertController.addAction(alertAction)
                        self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
                        
                    }
                }
            }
        }
        */
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


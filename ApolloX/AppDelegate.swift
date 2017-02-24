//
//  AppDelegate.swift
//  ApolloX
//
//  Created by Joseph Daniels on 18/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Cocoa
import Apollo

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationWillFinishLaunching(_ notification: Notification) {
        LocalNode.instance.start(self)
    }
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


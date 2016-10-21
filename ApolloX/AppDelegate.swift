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



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        Apollo.main()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


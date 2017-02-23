//
//  InterfaceController.swift
//  ApolloMicro Extension
//
//  Created by Joseph Daniels on 19/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    @IBAction func ayGurl() {
        print("fire")
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    @IBOutlet var action: WKInterfaceButton!
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

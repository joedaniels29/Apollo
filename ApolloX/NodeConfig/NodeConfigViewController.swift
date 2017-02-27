//
//  NodeConfigViewController.swift
//  Apollo
//
//  Created by Joseph Daniels on 2/24/17.
//  Copyright © 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit


class Datum:NSObject{
    dynamic var head:NSString = ""
    dynamic var content:NSString = ""

    init(header:String, content:String){
        self.head = header as NSString
        self.content = content as NSString
    }
}

class NodeConfigViewController : NSViewController, NSTableViewDelegate, NSTableViewDataSource{
    
    @IBOutlet var dataController: NSArrayController!
   
    @IBOutlet weak var tableView: NSTableView!
//    var data:NSArrayController = NSArrayController()
//    var data:[Datum] = []

    override func viewDidLoad() {
        tableView.delegate = self
//        tableView.dataSource = self
        self.dataController.content = [
            Datum(header: "bbc", content: "yas."),
                Datum(header: "duu", content: "yas."),
        ]
    }

//
//    public func numberOfRows(in tableView: NSTableView) -> Int {
//        return 1
//    }
//
    
}

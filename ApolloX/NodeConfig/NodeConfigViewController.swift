//
//  NodeConfigViewController.swift
//  Apollo
//
//  Created by Joseph Daniels on 2/24/17.
//  Copyright © 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import Apollo


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
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.setNeedsDisplay(self.view.frame)

    }

    override func viewDidLoad() {
        tableView.delegate = self
//        tableView.dataSource = self
        self.dataController.content = LocalNode.instance.
    }

//
//    public func numberOfRows(in tableView: NSTableView) -> Int {
//        return 1
//    }
//
    
}

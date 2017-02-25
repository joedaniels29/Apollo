//
//  NodeConfigViewController.swift
//  Apollo
//
//  Created by Joseph Daniels on 2/24/17.
//  Copyright © 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit


class NodeConfigViewController : NSViewController, NSTableViewDelegate, NSTableViewDataSource{
    
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }


    public func numberOfRows(in tableView: NSTableView) -> Int {
        return 1
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long

        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = "header"//item.name
            cellIdentifier = "header"
        } else if tableColumn == tableView.tableColumns[1] {
            text = "content"
            cellIdentifier = "value"
        }

        // 3
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }

}

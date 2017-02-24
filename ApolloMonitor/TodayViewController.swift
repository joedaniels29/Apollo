//
//  TodayViewController.swift
//  ApolloMonitor
//
//  Created by Joseph Daniels on 18/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

    override var nibName: String? {
        return "TodayViewController"
    }

    func widgetPerformUpdate(_ completionHandler: @escaping ((NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.noData)
    }

}

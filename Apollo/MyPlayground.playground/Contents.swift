//: Playground - noun: a place where people can play
import Foundation
import AppKit

import XCPlayground
var str = "Hello, playground"

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


NSWorkspace.shared().notificationCenter.addObserver(forName: .NSWorkspaceDidActivateApplication,
                                                    object: nil,
                                                    queue: .main,
                                                    using: { notification in
    print(notification.userInfo ?? "")
})



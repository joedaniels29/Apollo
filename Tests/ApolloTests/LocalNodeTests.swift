//
//  ItinerarySchedulerTests.swift
//  Apollo
//
//  Created by Joseph Daniels on 11/26/16.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import Dispatch
import RxSwift
import XCTest
@testable import Apollo


class LocalNodeTests: XCTestCase {
    let bag = DisposeBag()
    let bgQueue = DispatchQueue(label: "bgQueue")
    let localNode = LocalNode()
    //    func send(_ selector:Selector) -> Any?{
    //        let v = NSInvocation()
    //        v.target = self
    //        v.selector = selector
    //        return v.invoke()
    //    }


    override class func setUp() {
        super.setUp()
        //        startup!
        //        _ = self.send(#selector(NSApplicationDelegate.applicationDidFinishLaunching(_:)))
    }

    override func setUp() {
        localNode.start()
    }

    override class func tearDown() {
        //        objc_msgSend(self, #selector(NSApplicationDelegate.applicationWillTerminate(_:)))
        super.tearDown()
    }


    func testNodeNeighbors() {
    }


    func testDescriptionUpdate() {


    }

    func testSimply() {
    }

    //    override func doesNotRecognizeSelector(_ aSelector: Selector!) {

    //        super.doesNotRecognizeSelector(aSelector)
    //    }


    static var allTests: [(String, (LocalNodeTests) -> () throws -> Void)] {
        return [
                ("testSimply", testSimply),
                ("testDescriptionUpdate", testDescriptionUpdate),
                ("testNodeNeighbors", testNodeNeighbors),
        ]
    }
}

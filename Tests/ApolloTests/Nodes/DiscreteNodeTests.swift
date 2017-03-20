//
//  BlockServiceTests.swift
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
class TestState {
    var counter: Int = 0
    func increment() {
        counter += 1
    }

    func stateAssertion(_ i: Int) -> () {
        XCTAssert(counter == i, "\(String(counter)) instead of \(i)")
    }
}

extension XCTestCase {

    typealias PromisingServiceObservableBlockGenerator = (() -> ()) -> PromisingServiceObservableBlock
    typealias PromisingServiceObservableBlock = ServiceObservableBlock
    typealias DispatchGroupStateMarker = ((PromisingServiceObservableBlockGenerator) -> (PromisingServiceObservableBlock))

    func withLocalNode(lifecycle: Bool = true, prefix: Bool = false, test: (LocalNode, TestState, DispatchGroup) -> ()) {
        let node = TestNode()
        let state: TestState = TestState()
        let group: DispatchGroup = DispatchGroup()

        if (lifecycle && prefix) {
            node.start()
      }
        test(node, state, group)

        if (lifecycle) {
            if (!prefix) { node.start() }
            node.q.asyncAfter(wallDeadline: .now() + .seconds(2)) {
                node.setWillTerminate()
            }

            switch (group.wait(timeout: .now() + .seconds(5))) {
            case .timedOut: XCTFail()
            default:()
            }
        }
    }
}

class DiscreteNodeTests: XCTestCase {
    let bag = DisposeBag()
    let bgQueue = DispatchQueue(label: "bgQueue")

    func testOrdering() {
        let statespace = [true, false]
        for l in statespace {
            for p in statespace {
                withLocalNode(lifecycle: l, prefix: p) { node, state, group in
                    let eclosure: (Int, DispatchGroup) -> ServiceObservableBlock = { x, group in
                        group.enter()
                        return { o in
                            //defer {  }
                        	state.increment()
                            state.stateAssertion(x)
                            o.onCompleted()
                  		     group.leave()
                            return BooleanDisposable()
                        }
                    }
                    node.add(service: StructuredService(name: "TestService",
                                                        starting: eclosure(1, group),
                                                        loading: eclosure(2, group),
                                                        running: eclosure(3, group),
                                                        stopping: eclosure(4, group),
                                                        node: node))
                }
            }
        }
    }


    static var allTests: [(String, (DiscreteNodeTests) -> () throws -> Void)] {
        return [
                ("testOrdering", testOrdering),
        ]
    }
}

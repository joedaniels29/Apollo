import XCTest
import Foundation
import RxSwift
@testable import Apollo

//UserDefaults.standard.object(forKey: "") as? NSData

class BlockServiceTests: XCTestCase {
    func testSubscription() {
        let expectation1: XCTestExpectation = self.expectation(description: "ServiceWasRan")
        let s = "Tester"
        withLocalNode(wait: true) { node, _, _ in
            let service: BlockService = BlockService(name: s, node:node) {
                expectation1.fulfill()
            }
            node.add(service: service)
            XCTAssert(service.name == s)
        }
    }


    static var allTests: [(String, (BlockServiceTests) -> () throws -> Void)] {
        return [
                ("testSubscription", testSubscription),
        ]
    }
}

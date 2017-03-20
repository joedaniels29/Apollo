import XCTest
import Foundation
import RxSwift
@testable import Apollo

//UserDefaults.standard.object(forKey: "") as? NSData
class ExampleService: Service {
    var observable: Observable<ServiceStatusable> = .just(ServiceRecord.terminated)
    var name: String = "CompletedService"
    var node: Node = ApplicationNode.instance
    static var defaultNode: Node = ApplicationNode.instance
    var service: Service { return self }

}
class ServiceTests: XCTestCase {
    func testSubscription() {
        let expectation1: XCTestExpectation = self.expectation(description: "ServiceWasRan")
        let service: ExampleService = ExampleService()
        service.observable = .deferred {
            expectation1.fulfill()
            return .just(ServiceRecord.terminated)
        }
        withLocalNode(wait: true) { node, _, _ in
            node.add(service: service)
        }
    }


    static var allTests: [(String, (ServiceTests) -> () throws -> Void)] {
        return [
                ("testSubscription", testSubscription),
        ]
    }
}

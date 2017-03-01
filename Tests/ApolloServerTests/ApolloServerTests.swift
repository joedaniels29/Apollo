import XCTest
@testable import ApolloServer

class ApolloServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ApolloServe().text, "Hello, World!")
    }


    static var allTests: [(String, (ApolloServerTests) -> () throws -> Void)] {
        return [
                ("testExample", testExample),
        ]
    }
}

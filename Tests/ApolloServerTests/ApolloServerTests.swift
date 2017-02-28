import XCTest
@testable import ApolloServer

class ApolloServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ApolloServer().text, "Hello, World!")
    }


    static var allTests : [(String, (ApolloTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}

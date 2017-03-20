import XCTest
@testable import Apollo

extension XCTestCase{
      var yodog:String{ return "Dog!"}
}

class ApolloTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Apollo(text: "abc").text, "Hello, World!")
    }


    static var allTests : [(String, (ApolloTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}

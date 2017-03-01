import XCTest
@testable import ApolloSupport

class ApolloServerTests: XCTestCase {
    func testExceptionCatch() {
        var  e:Error?
        do {
            try ObjC.catchException {
                _ = NSArray()[14] //exception!
                XCTAssert(false)
            }
        } catch {
            e = error
        }
        
        XCTAssert(e != nil);
    }
    static var allTests : [(String, (ApolloServerTests) -> () throws -> Void)] {
        return [
            ("testExceptionCatch", testExceptionCatch),
        ]
    }
}

import XCTest
#if !os(Linux)
@testable import ApolloSupport
#endif


class ApolloSupportTests: XCTestCase {
#if os(Linux)
    func testNothing() {

    }
    static var allTests : [(String, (ApolloSupportTests) -> () throws -> Void)] {
        return []
    }
#else
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
    static var allTests : [(String, (ApolloSupportTests) -> () throws -> Void)] {
        return [
            ("testExceptionCatch", testExceptionCatch),
        ]
    }
 #endif
}

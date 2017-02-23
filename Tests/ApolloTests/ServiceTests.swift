//
//  ServiceTests.swift
//  Apollo
//
//  Created by Joseph Daniels on 11/26/16.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import XCTest
import Foundation
@testable import Apollo
//UserDefaults.standard.object(forKey: "") as? NSData
class ServiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Apollo(text: "abc").text, "Hello, World!")
    }
    
    
    static var allTests : [(String, (ServiceTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}

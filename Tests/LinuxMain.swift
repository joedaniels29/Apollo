import XCTest
@testable import ApolloTests
@testable import ApolloServerTests

XCTMain([
     testCase(ApolloServerTests.allTests),
     testCase(ApolloTests.allTests),
])

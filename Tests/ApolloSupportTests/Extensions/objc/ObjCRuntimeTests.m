//
//  ObjCRuntime.m
//  Apollo
//
//  Created by Joseph Daniels on 2/28/17.
//  Copyright © 2017 Joseph Daniels. All rights reserved.
//

#import <XCTest/XCTest.h>

@import ApolloSupport;

@interface ObjCRuntimeTests : XCTestCase

@end

@implementation ObjCRuntimeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSError * error;
    [ObjCRuntime catchException:^(){
        @throw [NSException new];
    } withError:&error];
    XCAssert(error);
    
}


@end

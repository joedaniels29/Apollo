//
// Created by Joseph Daniels on 2/19/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

#import "ObjCRuntime.h"

id dynamicCast_(id x, Class objClass) {

    return [x isKindOfClass:objClass] ? x : nil;
}



@implementation ObjC

+ (BOOL)catchException:(void(^)())tryBlock error:(__autoreleasing NSError **)error {
    @try {
        tryBlock();
        return YES;
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
    }
    return NO;
}

@end

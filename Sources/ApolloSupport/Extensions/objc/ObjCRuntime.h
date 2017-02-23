//
// Created by Joseph Daniels on 2/19/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

#import <Foundation/Foundation.h>


#define as(x, c) ((c *) dynamicCast_(x, [c class]))

id dynamicCast_(id x, Class objClass);

@interface ObjC : NSObject

+ (BOOL)catchException:(void(^)())tryBlock error:(__autoreleasing NSError **)error;

@end

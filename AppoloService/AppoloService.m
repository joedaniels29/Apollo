//
//  AppoloService.m
//  AppoloService
//
//  Created by Joseph Daniels on 18/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

#import "AppoloService.h"

@implementation AppoloService

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    reply(response);
}

@end

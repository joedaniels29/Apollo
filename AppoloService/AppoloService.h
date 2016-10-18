//
//  AppoloService.h
//  AppoloService
//
//  Created by Joseph Daniels on 18/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppoloServiceProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface AppoloService : NSObject <AppoloServiceProtocol>
@end

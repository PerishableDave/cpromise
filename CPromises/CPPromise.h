//
//  CPromises.h
//  CPromises
//
//  Created by David Peredo on 6/14/13.
//  Copyright (c) 2013 Wetnose Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kPending,
    kFulfilled,
    kRejected
} CPPromiseState;

@class CPDeferrable;

@interface CPPromise : NSObject {
    NSMutableArray *pendingFulfillmentBlocks;
    NSMutableArray *pendingRejectionBlocks;
    BOOL done;
    id resolutionValue;
    CPPromiseState state;
}

@property (readonly) CPPromiseState state;

- (CPPromise *)thenWithFulfillment:(CPPromise* (^)(id value))fufillmentBlock rejection:(CPPromise* (^)(NSError *error))rejectionBlock;

@end

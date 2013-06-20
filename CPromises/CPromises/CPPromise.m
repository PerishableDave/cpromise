//
//  CPromises.m
//  CPromises
//
//  Created by David Peredo on 6/14/13.
//  Copyright (c) 2013 Wetnose Labs. All rights reserved.
//

#import "CPPromise.h"
#import "CPDeferrable.h"

@implementation CPPromise

@synthesize state = state;

- (id)init {
    if (self = [super init]) {
        pendingFulfillmentBlocks = [[NSMutableArray alloc] init];
        pendingRejectionBlocks = [[NSMutableArray alloc] init];
    }
    
    return self;
}



- (CPPromise *)thenWithFulfillment:(CPPromise* (^)(id))aFulfillmentBlock
                  rejection:(CPPromise* (^)(NSError *))aRejectionBlock {
    
    CPDeferrable *deferrable = [[CPDeferrable alloc] init];
    
    // Set default values
    CPPromise* (^wrappedFulfillmentBlock)(id) = aFulfillmentBlock = ^(id value) {
        [deferrable resolve:value];
        return deferrable.promise;
    };
    
    // TODO: Wrap rejection block.
    
    if (state == kPending) {
        deferrable = [[CPDeferrable alloc] init];
        
        [pendingFulfillmentBlocks addObject:wrappedFulfillmentBlock];
//        [pendingRejectionBlocks addObject:rejectionBlock];
    } else {
        [resolutionValue thenWithFulfillment:wrappedFulfillmentBlock rejection:nil];
    }
    
    return deferrable.promise;
}

@end

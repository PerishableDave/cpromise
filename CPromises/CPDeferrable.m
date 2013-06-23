//
//  CPDeferrable.m
//  CPromises
//
//  Created by David Peredo on 6/14/13.
//  Copyright (c) 2013 Wetnose Labs. All rights reserved.
//

#import "CPDeferrable.h"
#import "CPPromise.h"

/**
 * Faux friend methods for deferrable to access.
 */
@interface CPPromise (CPDeferrable)

- (void)setResolutionValue:(id)aResolutionValue;
- (void)setState:(CPPromiseState)aState;

- (NSMutableArray *)pendingFulfillmentBlocks;
- (NSMutableArray *)pendingRejectionBlocks;

@end

@implementation CPPromise (CPDeferrable)

- (void)setResolutionValue:(id)aValue {
    resolutionValue = aValue;
}

- (void)setState:(CPPromiseState)aState {
    state = aState;
}

- (NSMutableArray *)pendingFulfillmentBlocks {
    return pendingFulfillmentBlocks;
}
- (NSMutableArray *)pendingRejectionBlocks {
    return pendingRejectionBlocks;
}


@end

@implementation CPDeferrable

@synthesize promise = promise;

+ (CPPromise *)wrapValueWithPromise:(id)aValue {
    if ([aValue class] == [CPPromise class]) {
        return aValue;
    } else {
        CPPromise *promise = [[CPPromise alloc] init];
        [promise setResolutionValue:aValue];
        return promise;
    }
}

- (void)resolve:(id)aResolutionValue {
    if (promise.state == kPending) {
        // Wrap value in promise
        CPPromise *resolvedValuePromise = [CPDeferrable wrapValueWithPromise:aResolutionValue];
        
        [promise.pendingRejectionBlocks removeAllObjects];
        for (CPPromise* (^fulfillmentBlock)(id _value) in promise.pendingFulfillmentBlocks) {
            [resolvedValuePromise thenWithFulfillment:fulfillmentBlock rejection:nil];
        }
        promise.state = kFulfilled;
    }
}

@end

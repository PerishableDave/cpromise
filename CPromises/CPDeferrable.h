//
//  CPDeferrable.h
//  CPromises
//
//  Created by David Peredo on 6/14/13.
//  Copyright (c) 2013 Wetnose Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPPromise;

@interface CPDeferrable : NSObject

@property (readonly) CPPromise *promise;

- (void)resolve:(id)aResolutionValue;

@end

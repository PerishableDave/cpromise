//
//  CPPostRepository.h
//  CPromisesExample
//
//  Created by David Peredo on 6/22/13.
//  Copyright (c) 2013 Wetnose Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPPromise.h"

@interface CPPostRepository : NSObject

- (CPPromise *)frontPagePosts;

@end

//
//  CPHackerNewsTableView.h
//  CPromisesExample
//
//  Created by David Peredo on 6/22/13.
//  Copyright (c) 2013 Wetnose Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPPostRepository.h"

@interface CPPostTableViewController : UITableViewController {
    CPPostRepository *postRepository;
    NSArray *posts;
}


@end

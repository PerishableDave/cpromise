//
//  CPHackerNewsTableView.m
//  CPromisesExample
//
//  Created by David Peredo on 6/22/13.
//  Copyright (c) 2013 Wetnose Labs. All rights reserved.
//

#import "CPPostTableViewController.h"
#import "CPPost.h"

NSString * const CPPostTableViewCellNibName = @"PostTableViewCell";
NSString * const CPPostTableViewCellIdentifier = @"PostTableViewCell";

int const CPPostTableViewCellTitleTag = 1;
int const CPPostTableViewCellURLTag = 2;

@implementation CPPostTableViewController

- (id)init {
    if (self = [super init]) {
        postRepository = [[CPPostRepository alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [self.tableView registerNib:[UINib nibWithNibName:CPPostTableViewCellNibName bundle:nil] forCellReuseIdentifier:CPPostTableViewCellIdentifier];
    
    CPPromise *postsPromise = [postRepository frontPagePosts];
    
    [postsPromise thenWithFulfillment:^CPPromise *(id value) {
        posts = (NSArray *)value;
        [self.tableView reloadData];
        
        return nil;
    } rejection:^CPPromise *(NSError *error) {
        return nil;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return posts ? [posts count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CPPostTableViewCellIdentifier];
    
    CPPost *post = [posts objectAtIndex:indexPath.row];
    
    ((UILabel *)[cell viewWithTag:CPPostTableViewCellTitleTag]).text = post.title;
    ((UILabel *)[cell viewWithTag:CPPostTableViewCellURLTag]).text = post.url;
    
    return cell;
}

@end

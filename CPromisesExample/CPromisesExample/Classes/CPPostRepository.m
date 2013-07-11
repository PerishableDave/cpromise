//
//  CPPostRepository.m
//  CPromisesExample
//
//  Created by David Peredo on 6/22/13.
//  Copyright (c) 2013 Wetnose Labs. All rights reserved.
//

#import "CPPostRepository.h"
#import <AFNetworking/AFNetworking.h>
#import "CPPost.h"
#import "CPDeferrable.h"

@implementation CPPostRepository

- (CPPromise *)frontPagePosts {
    
    CPDeferrable *defferable = [[CPDeferrable alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://api.ihackernews.com/page"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *postDicts =  [(NSDictionary *)JSON objectForKey:@"items"];
        
        NSMutableArray *posts = [NSMutableArray arrayWithCapacity:[postDicts count]];
        for (NSDictionary *postDict in postDicts) {
            CPPost *post = [[CPPost alloc] init];
            post.commentCount = [postDict objectForKey:@"commentCount"];
            post.postId = [postDict objectForKey:@"id"];
            post.points = [postDict objectForKey:@"points"];
            post.postAuthor = [postDict objectForKey:@"postedBy"];
            post.title = [postDict objectForKey:@"title"];
            post.url = [postDict objectForKey:@"url"];
            
            [posts addObject:post];
        }
        
        [defferable resolve:posts];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // TODO: Call defferable fail.
    }];
    
    [operation start];
    
    return defferable.promise;
}

@end

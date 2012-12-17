//
//  BNRFeedStore.m
//  Nerdfeed
//
//  Created by Jack Flintermann on 11/16/12.
//  Copyright (c) 2012 jflinter. All rights reserved.
//

#import "BNRFeedStore.h"
#import <AFNetworking/AFJSONRequestOperation.h>

static BNRFeedStore *sharedInstance;

@implementation BNRFeedStore

+ (BNRFeedStore *) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[BNRFeedStore alloc] init];
    }
    return sharedInstance;
}

- (void) fetchItemsWithCompletion:(void (^)(id result, NSError *error)) block {
    NSURL *url = [NSURL URLWithString:@"http://onradpad.com/listings/search.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             block(JSON, nil);
                                        }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             block(JSON, error);
                                        }];
    [operation start];
}

@end

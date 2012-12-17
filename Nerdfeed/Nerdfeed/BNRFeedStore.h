//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by Jack Flintermann on 11/16/12.
//  Copyright (c) 2012 jflinter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRFeedStore : NSObject

+ (BNRFeedStore *) sharedInstance;
- (void) fetchItemsWithCompletion:(void (^)(id result, NSError *error)) block;

@end

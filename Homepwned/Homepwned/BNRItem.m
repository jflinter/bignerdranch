//
//  BNRItem.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/12/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "BNRItem.h"


@implementation BNRItem

@dynamic date;
@dynamic imageKey;
@dynamic orderingValue;
@dynamic title;
@dynamic assetType;

- (void) awakeFromInsert {
    [super awakeFromInsert];
    self.title = @"New Item";
    self.date = [[NSDate date] timeIntervalSinceReferenceDate];
}

- (NSString *) description {
    return self.title;
}

@end

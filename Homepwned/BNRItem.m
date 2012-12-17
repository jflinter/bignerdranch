//
//  BNRItem.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

- (id) init {
    self = [super init];
    if (self) {
        _title = @"New Item";
        _date = [NSDate date];
    }
    return self;
}

+ (BNRItem *) item {
    return [[BNRItem alloc] init];
}


- (NSString *) description {
    return _title;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_imageKey forKey:@"imageKey"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _date = [aDecoder decodeObjectForKey:@"date"];
        _imageKey = [aDecoder decodeObjectForKey:@"imageKey"];
    }
    return self;
}

@end

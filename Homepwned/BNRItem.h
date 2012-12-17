//
//  BNRItem.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject<NSCoding>

@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSDate *date;
@property (nonatomic, readwrite) NSString *imageKey;

+ (BNRItem *) item;

@end

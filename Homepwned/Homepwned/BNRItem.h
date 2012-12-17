//
//  BNRItem.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/12/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BNRItem : NSManagedObject

@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSString * imageKey;
@property (nonatomic) double orderingValue;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSManagedObject *assetType;

@end

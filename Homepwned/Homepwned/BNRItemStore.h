//
//  BNRItemStore.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject {
    NSMutableArray *allItems;
    NSMutableArray *allAssetTypes;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+ (BNRItemStore *) sharedInstance;
- (NSArray *) allItems;
- (BNRItem *) createItem;
- (void) deleteItem:(BNRItem *) item;
- (void) moveItemAtIndex:(NSInteger) from toIndex:(NSInteger) to;
- (NSString *) itemArchivePath;
- (BOOL) saveChanges;
- (void) loadAllItems;


@end

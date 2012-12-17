//
//  BNRItemStore.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRImageStore.h"
#import "BNRItem.h"

static BNRItemStore *sharedInstance;

@implementation BNRItemStore

+ (id) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (id) init {
    self = [super init];
    if (self) {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        NSString *path = [self itemArchivePath];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:url
                                        options:nil
                                               error:&error]) {
            [NSException raise:@"open failed" format:@"Reason: %@", [error localizedDescription]];
        }
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = coordinator;
        context.undoManager = nil;
        [self loadAllItems];
        
    }
    return self;
}

+ (BNRItemStore *) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:nil] init];
    }
    return sharedInstance;
}

- (NSArray *) allItems {
    return allItems;
}

- (BNRItem *) createItem {
    double order = [allItems count] ? [[allItems lastObject] orderingValue] + 1.0 : 1.0;
    BNRItem *p = [NSEntityDescription insertNewObjectForEntityForName:@"BNRItem" inManagedObjectContext:context];
    p.orderingValue = order;
    [allItems addObject:p];
    return p;
}

- (void) deleteItem:(BNRItem *) item {
    [allItems removeObjectIdenticalTo:item];
    [[BNRImageStore sharedInstance] deleteImageForKey:item.imageKey];
    [context deleteObject:item];
}

- (void) moveItemAtIndex:(NSInteger) from toIndex:(NSInteger) to {
    BNRItem *item = [allItems objectAtIndex:from];
    if (item) {
        [allItems removeObjectAtIndex:from];
        [allItems insertObject:item atIndex:to];
        double lowerBound = 0.0;
        if (to > 0) {
            lowerBound = [[allItems objectAtIndex:to-1] orderingValue];
        }
        else {
            lowerBound = [[allItems objectAtIndex:1] orderingValue] - 2.0;
        }
        double upperBound = 0.0;
        if (to < [allItems count] - 1) {
            upperBound = [[allItems objectAtIndex:to] orderingValue];
        }
        else {
            upperBound = [[allItems objectAtIndex:to - 1] orderingValue] + 2.0;
        }
        double order = (lowerBound + upperBound) / 2.0;
        item.orderingValue = order;
    }
}

- (NSString *) itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [documentDirectories objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL) saveChanges {
    NSError *error = nil;
    BOOL success = [context save:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    return success;
    
}

- (void) loadAllItems {
    if (!allItems) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"BNRItem"];
        fetchRequest.entity = e;
        NSSortDescriptor *d = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        fetchRequest.sortDescriptors = @[d];
        NSError *error = nil;
        NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
        if (error || !items) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        allItems = [NSMutableArray arrayWithArray:items];
        
    }
}

@end

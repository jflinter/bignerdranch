//
//  AppDelegate.h
//  Todo
//
//  Created by Jack Flintermann on 11/22/12.
//  Copyright (c) 2012 jflinter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TodoIncrementalStore.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

@property (strong, nonatomic) UINavigationController *navigationController;

@end

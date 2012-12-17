//
//  ItemsViewController.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "ItemsViewController.h"
#import "DetailViewController.h"
#import "ImageViewController.h"
#import "BNRItemStore.h"
#import "BNRImageStore.h"
#import "BNRItem.h"
#import "HomepwnedItemCell.h"

@interface ItemsViewController () {
    NSDateFormatter *formatter;
}

@end

@implementation ItemsViewController

- (id) init {
    self = [super initWithNibName:@"ItemsViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.navigationItem.title = @"Homepwned";
        self.navigationItem.leftBarButtonItem = [self editButtonItem];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self
                                                                                               action:@selector(addNewItem:)];
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
    }
    return self;
}

- (id) initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void) viewDidLoad {
    UINib *nib = [UINib nibWithNibName:@"HomepwnedItemCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"HomepwnedItemCell"];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tableView reloadData];
}

- (IBAction) addNewItem:(id)sender {
    BNRItem *item = [[BNRItemStore sharedInstance] createItem];
    DetailViewController *dvc = [[DetailViewController alloc] initForNewItem:YES];
    dvc.modalPresentationStyle = UIModalPresentationFormSheet;
    dvc.item = item;
    dvc.dismissBlock = ^{
        [tableView reloadData];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dvc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    tableView.editing = editing;
}

- (void) showImage: (id) sender atIndexPath:(NSIndexPath *) indexPath {
    BNRItem *item = [[BNRItemStore sharedInstance].allItems objectAtIndex:indexPath.row];
    ImageViewController *ivc = [[ImageViewController alloc] init];
    ivc.image = [[BNRImageStore sharedInstance] imageForKey:item.imageKey size:BNRFullSize];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ivc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark - Table View Stuff

- (NSInteger) tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [[BNRItemStore sharedInstance] allItems].count;
}

- (UITableViewCell *) tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomepwnedItemCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"HomepwnedItemCell"];
    BNRItem *item = [[[BNRItemStore sharedInstance] allItems] objectAtIndex:indexPath.row];
    cell.titleLabel.text = item.title;
    cell.dateLabel.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate: item.date]];
    UIImage *thumbnail = [[BNRImageStore sharedInstance] imageForKey:item.imageKey size:BNRThumbnail];
    cell.imageView.image = thumbnail;
    cell.controller = self;
    cell.myTableView = tableView;
    
    return cell;
    
}

- (void) tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRItemStore *store = [BNRItemStore sharedInstance];
    BNRItem *itemToDelete = [[store allItems] objectAtIndex:indexPath.row];
    [store deleteItem:itemToDelete];
    [aTableView reloadData];
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedInstance] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *dvc = [[DetailViewController alloc] initForNewItem:NO];
    dvc.item = [[[BNRItemStore sharedInstance] allItems] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}

@end

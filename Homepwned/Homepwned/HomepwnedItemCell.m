//
//  HomepwnedItemCell.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/10/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "HomepwnedItemCell.h"

@implementation HomepwnedItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showImage:(id)sender {
    NSIndexPath *indexPath = [_myTableView indexPathForCell:self];
    NSString *selector = NSStringFromSelector(_cmd);
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    SEL newSelector = NSSelectorFromString(selector);
    if ([_controller respondsToSelector:newSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_controller performSelector:newSelector withObject:sender withObject:indexPath];
#pragma clang diagnostic pop
    }
}
@end

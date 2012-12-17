//
//  BNRImageStore.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/9/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum imageSizes
{
    BNRThumbnail,
    BNRFullSize
} BNRImageSize;

@interface BNRImageStore : NSObject {
    NSMutableDictionary *dictionary;
}

+ (BNRImageStore *) sharedInstance;
- (void) setImage:(UIImage *) image forKey:(NSString *) key;
- (UIImage *) imageForKey:(NSString *) key size:(BNRImageSize) size;
- (void) deleteImageForKey:(NSString *) key;

@end

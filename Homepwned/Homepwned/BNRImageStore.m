//
//  BNRImageStore.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/9/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "BNRImageStore.h"

static BNRImageStore *sharedInstance;

@implementation BNRImageStore

+ (BNRImageStore *) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super alloc] init];
    }
    return sharedInstance;
}

- (id) init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearCache:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) clearCache:(NSNotification *) notification {
    [dictionary removeAllObjects];
}

- (void) setImage:(UIImage *) image forKey:(NSString *) key {
    [self setImage:image forKey:key size:BNRFullSize];
    [self setImage:image forKey:key size:BNRThumbnail];
}

- (void) setImage:(UIImage *)image forKey:(NSString *)key size:(BNRImageSize) size {
    NSData *imageData;
    UIImage *imageToSave;
    if (size == BNRThumbnail) {
        CGRect thumbnailBounds = CGRectMake(0, 0, 40, 40);
        CGFloat ratio = MAX(thumbnailBounds.size.width / image.size.width,
                            thumbnailBounds.size.height / image.size.height);
        //generate thumbnail representation
        UIGraphicsBeginImageContextWithOptions(thumbnailBounds.size, NO, 0.0);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:thumbnailBounds cornerRadius:5.0];
        [path addClip];
        CGRect projectRect;
        projectRect.size.width = image.size.width * ratio;
        projectRect.size.height = image.size.height * ratio;
        projectRect.origin.x = (thumbnailBounds.size.width - projectRect.size.width) / 2;
        projectRect.origin.y = (thumbnailBounds.size.height - projectRect.size.height) / 2;
        projectRect = CGRectIntegral(projectRect);
        [image drawInRect:projectRect];
        imageToSave = UIGraphicsGetImageFromCurrentImageContext();
        imageData = UIImagePNGRepresentation(imageToSave);
        UIGraphicsEndImageContext();
    }
    else {
        imageData = UIImageJPEGRepresentation(image, 0.5);
        imageToSave = image;
    }
    NSString *dictKey = [self dictionaryKeyForKey:key size:size];
    [dictionary setObject:imageToSave forKey:dictKey];
    NSString *path = [self imagePathForKey:key size:size];
    [imageData writeToFile:path atomically:YES];
}

- (UIImage *) imageForKey:(NSString *) key size:(BNRImageSize)size {
    if (!key) {
        return nil;
    }
    NSString *dictKey = [self dictionaryKeyForKey:key size:size];
    UIImage *result = [dictionary objectForKey:dictKey];
    if (!result) {
        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:key size:size]];
        if (result) {
            [dictionary setObject:result forKey:dictKey];
        }
    }
    return result;
}
- (void) deleteImageForKey:(NSString *) key {
    [self deleteImageForKey:key size:BNRFullSize];
    [self deleteImageForKey:key size:BNRThumbnail];
}

- (void) deleteImageForKey:(NSString *) key size:(BNRImageSize) size {
    if (key) {
        [dictionary removeObjectForKey:key];
    }
    NSString *path = [self imagePathForKey:key size:size];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

- (NSString *) dictionaryKeyForKey:(NSString *) key size: (BNRImageSize) size {
    if (size == BNRThumbnail) {
        return [key stringByAppendingString:@"-THUMBNAIL"];
    }
    return key;
}

- (NSString *) imagePathForKey:(NSString *) key size:(BNRImageSize) size {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [documentDirectories objectAtIndex:0];
    NSString *pathKey = key;
    if (size == BNRThumbnail) {
        pathKey = [pathKey stringByAppendingString:@"-THUMBNAIL"];
    }
    return [directory stringByAppendingPathComponent:pathKey];
}

@end

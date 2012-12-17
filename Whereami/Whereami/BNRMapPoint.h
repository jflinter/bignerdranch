//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Jack Flintermann on 11/6/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject<MKAnnotation> {
    NSDate *createdDate;
    
}

-(id) initWithCoordinate:(CLLocationCoordinate2D) c title: (NSString *) t;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

@end

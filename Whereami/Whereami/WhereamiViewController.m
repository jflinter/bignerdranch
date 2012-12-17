//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Jack Flintermann on 11/6/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "WhereamiViewController.h"
#import "BNRMapPoint.h"

static NSString *WhereAmIMapTypePref = @"WhereAmIMapTypePref";

@interface WhereamiViewController ()

@end

@implementation WhereamiViewController

+ (void) initialize {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:WhereAmIMapTypePref];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dict];
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    return self;
}

-(void) viewDidLoad {
    mapView.showsUserLocation = YES;
    NSInteger type = [[NSUserDefaults standardUserDefaults] integerForKey:WhereAmIMapTypePref];
    mapTypeControl.selectedSegmentIndex = type;
    [self segmentChanged:mapTypeControl];
}

- (void) dealloc {
    locationManager.delegate = nil;
}

- (void) mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 250, 250);
    [aMapView setRegion:region animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *) textField {
    [textField resignFirstResponder];
    if (textField.text.length) {
        [self findLocation];
    }
    return YES;
}

- (void) findLocation {
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    locationInputField.hidden = YES;
}

- (void) foundLocation: (CLLocation *) loc {
    CLLocationCoordinate2D coordinate = loc.coordinate;
    BNRMapPoint *mapPoint = [[BNRMapPoint alloc] initWithCoordinate:coordinate title:locationInputField.text];
    [mapView addAnnotation:mapPoint];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
    [mapView setRegion:region animated:YES];
    locationInputField.text = @"";
    locationInputField.hidden = NO;
    [locationManager stopUpdatingLocation];
    [activityIndicator stopAnimating];
}


- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSTimeInterval t = [location.timestamp timeIntervalSinceNow];
    if (t > -180) {
        [self foundLocation:location];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"could not find location: %@", error);
}

- (void) segmentChanged:(id)sender {
    NSInteger index = [sender selectedSegmentIndex];
    [[NSUserDefaults standardUserDefaults] setInteger: index forKey:WhereAmIMapTypePref];
    MKMapType type;
    switch ([sender selectedSegmentIndex]) {
        case 0:
            type = MKMapTypeStandard;
            break;
        case 1:
            type = MKMapTypeSatellite;
            break;
        case 2:
        default:
            type = MKMapTypeHybrid;
            break;
    }
    mapView.mapType = type;
}

@end

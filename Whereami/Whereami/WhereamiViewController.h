//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Jack Flintermann on 11/6/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate> {
    
    CLLocationManager *locationManager;
    __weak IBOutlet MKMapView *mapView;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    __weak IBOutlet UITextField *locationInputField;
    __weak IBOutlet UISegmentedControl *mapTypeControl;
    
}

- (IBAction)segmentChanged:(id)sender;

@end

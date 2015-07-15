//
//  placesMapViewController.m
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import "placesMapViewController.h"
#import <CoreLocation/CoreLocation.h>

@implementation placesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(24.6850021,121.8235917);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000);
    [self.mapView setRegion:region animated:YES];
}

@end

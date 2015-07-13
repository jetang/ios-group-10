//
//  facebookPlaces.m
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import "facebookPlaces.h"

@implementation facebookPlaces

+ (facebookPlaces *)getInstance {
    static facebookPlaces *p = nil;
    static CLLocationManager *locationManager = nil;

    @synchronized(self) {
        if (p == nil) {
            p = [[facebookPlaces alloc] init];
            p.currentCenter = CLLocationCoordinate2DMake(0.0, 0.0);
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = p;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            locationManager.distanceFilter = 50;
            [locationManager requestWhenInUseAuthorization];
            [locationManager startUpdatingLocation];
        }
    }
    return p;
}

// https://graph.facebook.com/search?q=coffee&type=place&center=25.038448,121.548656&distance=5000&access_token=xxxx

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.currentCenter = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

@end

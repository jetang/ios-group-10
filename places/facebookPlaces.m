//
//  facebookPlaces.m
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import "facebookPlaces.h"
#import "AFHTTPRequestOperationManager.h"

// For DEMO
// NSString *apiURL = @"https://dl.dropboxusercontent.com/u/46004762/sample.json";
// Official API URL
NSString *apiURL = @"https://graph.facebook.com/search";

@implementation facebookPlaces

+ (facebookPlaces *)getInstance {
    static facebookPlaces *p = nil;
    static CLLocationManager *locationManager = nil;

    @synchronized(self) {
        if (p == nil) {
            p = [[facebookPlaces alloc] init];
            p.currentCenter = CLLocationCoordinate2DMake(0.0, 0.0);
            p.keyword = nil;
            locationManager = [[CLLocationManager alloc] init];
            p.locationManager = locationManager;
            locationManager.delegate = p;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            locationManager.distanceFilter = 50;
            [locationManager requestWhenInUseAuthorization];
            [locationManager startUpdatingLocation];
        }
    }
    return p;
}

- (void)queryPlaces {
    // https://graph.facebook.com/search?q=coffee&type=place&center=25.038448,121.548656&distance=5000&access_token=xxxx

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    // match with the application type returned from github.io, perhaps could be removed when move to standard API
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"place" forKey:@"type"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", self.currentCenter.latitude, self.currentCenter.longitude] forKey:@"center"];
    [parameters setObject:@50 forKey:@"limit"];
    if ([self.keyword length]) {
        [parameters setObject:self.keyword forKey:@"q"];
    }

    // go https://developers.facebook.com/tools/explorer to copy an access token then replace xxx
    // Do not git commit your access token here!
    [parameters setObject:@"CAACEdEose0cBAHyyE1IDuppQGlJCKvwsc51tYIp9yzL5HBdusQJO8Jpn19A3pH56R5CZCNTRrmX5OATnZCuJJSAkuIhKRJVFkYT0UBCDmYZClZBNx8CqZBxwB8sym9ryPLxfBSwgUfmfhpbAoBjGN9BuoaBr44sS5LGzQQFZArSztGA60ovcPZAbjDrnDIdoLT33iVtPeP6mEIRwqnplkIx" forKey:@"access_token"];

    [manager GET:apiURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"call place api success!");
        self.places = responseObject[@"data"];
        NSLog(@"----API result: %@", self.places);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"call facebook api error! %@", error);
    }];
}

- (void)updateLocation:(CLLocationCoordinate2D)newCoordinate
{
    NSLog(@"(%f, %f)", newCoordinate.latitude, newCoordinate.longitude);
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:newCoordinate.latitude longitude:newCoordinate.longitude];
    NSArray *locations = [[NSArray alloc] initWithObjects:newLocation, nil];
    [self.locationManager.delegate locationManager:nil didUpdateLocations:locations];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.currentCenter = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [self queryPlaces];
}

@end

//
//  placesMapViewController.m
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import "placesMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "facebookPlaces.h"

@implementation placesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(25.04,121.55);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 10000, 10000);
    [self.mapView setRegion:region animated:YES];
    
    [[facebookPlaces getInstance] addObserver:self
                  forKeyPath:@"places"
                     options:0
                     context:nil];
    [[facebookPlaces getInstance] queryPlaces];
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
    if ([keyPath isEqualToString:@"places"]) {
        NSMutableDictionary *data = [facebookPlaces getInstance].places[0];
        NSMutableDictionary *location = data[@"location"];
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = CLLocationCoordinate2DMake([location[@"latitude"] doubleValue], [location[@"longitude"] doubleValue]);
        myAnnotation.title = data[@"name"];
        //myAnnotation.subtitle = @"Best Pizza in Town";
        
        NSLog(@"name %@", data[@"name"]);
        [self.mapView addAnnotation:myAnnotation];
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

@end

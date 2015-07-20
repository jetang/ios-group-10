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
}

- (void)viewDidAppear:(BOOL)animated
{
    [[facebookPlaces getInstance] queryPlaces];
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
    if ([keyPath isEqualToString:@"places"]) {
        NSMutableArray *annotations = [[NSMutableArray alloc] init];

        for (id data in [facebookPlaces getInstance].places) {
            NSMutableDictionary *location = data[@"location"];
            MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
            myAnnotation.coordinate = CLLocationCoordinate2DMake([location[@"latitude"] doubleValue], [location[@"longitude"] doubleValue]);
            myAnnotation.title = data[@"name"];
            [annotations addObject:myAnnotation];

            NSLog(@"name %@", data[@"name"]);
        }
        
        [self.mapView addAnnotations:annotations];
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[facebookPlaces getInstance] removeObserver:self forKeyPath:@"places"];
}

@end

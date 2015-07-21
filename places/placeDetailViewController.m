//
//  placeDetailViewController.m
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import "placeDetailViewController.h"

@implementation placeDetailViewController
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = data[@"name"];
    self.locationStreetLabel.text = data[@"location"][@"street"];
    self.locationCityLabel.text = data[@"location"][@"city"];
    self.locationCountryLabel.text = data[@"location"][@"country"];
    self.locationZipLabel.text = data[@"location"][@"zip"];
    //NSLog(@"self.data: %@", self.data);
}

@end

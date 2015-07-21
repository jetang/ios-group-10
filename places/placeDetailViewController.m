//
//  placeDetailViewController.m
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import "placeDetailViewController.h"

@implementation placeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.data[@"name"];
    self.streetLabel.text = self.data[@"location"][@"street"];
    self.cityLabel.text = self.data[@"location"][@"city"];
    self.countryLabel.text = self.data[@"location"][@"country"];
    self.zipLabel.text = self.data[@"location"][@"zip"];
}

@end

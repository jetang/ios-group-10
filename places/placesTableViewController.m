//
//  placesTableViewController.m
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import "placesTableViewController.h"
#import "facebookPlaces.h"

@implementation placesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [facebookPlaces getInstance];
}

@end

//
//  placeDetailViewController.h
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface placeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationStreetLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationZipLabel;
@property (strong, nonatomic) NSMutableDictionary *data;

@end

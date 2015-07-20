//
//  facebookPlaces.h
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface facebookPlaces : NSObject <CLLocationManagerDelegate>

+ (facebookPlaces *)getInstance;
- (void)queryPlaces;

@property  CLLocationCoordinate2D currentCenter;
@property (strong, nonatomic) NSMutableArray *places;
@property (strong, nonatomic) NSString *keyword;


@end

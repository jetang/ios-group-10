//
//  facebookPlaces.h
//  places
//
//  Created by Zordius Chen on 7/13/15.
//  Copyright (c) 2015 Zordius Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface facebookPlaces : NSObject

+ (facebookPlaces *)getInstance;

@property  CLLocationCoordinate2D currentCenter;
@property (strong, nonatomic) NSMutableArray *places;

@end

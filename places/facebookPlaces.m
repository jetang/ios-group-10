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
    @synchronized(self) {
        if (p == nil) {
            p = [[facebookPlaces alloc] init];
        }
    }
    return p;
}

@end

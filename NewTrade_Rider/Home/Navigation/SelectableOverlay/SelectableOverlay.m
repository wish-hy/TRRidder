//
//  SelectableOverlay.m
//  officialDemo2D
//
//  Created by yi chen on 14-5-8.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "SelectableOverlay.h"

@implementation SelectableOverlay

#pragma mark - MAOverlay Protocol

- (CLLocationCoordinate2D)coordinate
{
    return [self.overlay coordinate];
}

- (MAMapRect)boundingMapRect
{
    return [self.overlay boundingMapRect];
}

#pragma mark - Life Cycle

- (id)initWithOverlay:(id<MAOverlay>)overlay
{
    self = [super init];
    if (self)
    {
        self.overlay       = overlay;
        self.selected      = NO;
        self.selectedColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:79/255.0 alpha:1.0];
        self.regularColor  = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:79/255.0 alpha:1.0];
    }
    
    return self;
}

@end

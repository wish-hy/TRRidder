//
//  SelectableOverlay.h
//  officialDemo2D
//
//  Created by yi chen on 14-5-8.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/MAMapKit.h>

@interface SelectableOverlay : MABaseOverlay

@property (nonatomic, copy) NSString *mapTitle;

@property (nonatomic, assign) NSInteger routeID;

@property (nonatomic, assign, getter = isSelected) BOOL selected;
@property (nonatomic, strong) UIColor * selectedColor;
@property (nonatomic, strong) UIColor * regularColor;

@property (nonatomic, strong) id<MAOverlay> overlay;

- (id)initWithOverlay:(id<MAOverlay>) overlay;

@end

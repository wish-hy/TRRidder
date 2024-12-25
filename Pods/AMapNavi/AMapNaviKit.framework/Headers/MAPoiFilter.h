//
//  MAPoiFilter.h
//  MAMapKit
//
//  Created by linshiqing on 2024/6/18.
//  Copyright © 2024 Amap. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MAMapView;

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, MAPoiFilterType) {
    MAPoiFilterTypePoi                   = 0x00000001,                       //!< 避让POI
    MAPoiFilterTypeRoadName              = 0x00000002,                       //!< 避让底图路名
    MAPoiFilterTypeRoadShield            = 0x00000004,                       //!< 避让路牌
    MAPoiFilterTypeLabel3rd              = 0x00000008,                       //!< 避让第三方label
    MAPoiFilterTypeAll                   = 0xFFFFFFFF                        //!< 避让所有
};

@interface MAPoiFilter : NSObject
@property (nonatomic, assign) MAPoiFilterType filterType;       //!< 避让类型
// 请将CLLocationCoordinate2D类型使用[NSValue valueWithMACoordinate:]包装下
@property (nonatomic, copy) NSArray<NSValue *> *position;       //!< 四边形避让框坐标
@property (nonatomic, copy) NSString *keyName;                  //!< 避让框名称
+ (instancetype)poiFilter:(MAMapView *)mapView filterType:(MAPoiFilterType)filterType keyName:(NSString *)keyName center:(CLLocationCoordinate2D)center width:(CGFloat)width height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END

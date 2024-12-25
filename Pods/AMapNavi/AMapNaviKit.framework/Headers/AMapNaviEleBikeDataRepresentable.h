//
//  AMapNaviEleBikeDataRepresentable.h
//  AMapNaviKit
//
//  Created by menglong on 2022/1/12.
//  Copyright © 2022 Amap. All rights reserved.
//

#import "AMapNaviCommonObj.h"

NS_ASSUME_NONNULL_BEGIN

@class AMapNaviInfo;
@class AMapNaviRoute;
@class AMapNaviLocation;
@class AMapNaviStatisticsInfo;
@class AMapNaviEleBikeManager;

/**
 * @brief AMapNaviEleBikeeDataRepresentable协议.实例对象可以通过实现该协议,并将其通过 AMapNaviEleBikeManager 的addDataRepresentative:方法进行注册,便可获取导航过程中的导航数据更新.
 * 可以根据不同需求,选取使用特定的数据进行导航界面自定义.
 * AMapNaviRideView 即通过该协议实现导航过程展示.也可以依据导航数据的更新进行其他的逻辑处理.
 */
@protocol AMapNaviEleBikeDataRepresentable <NSObject>

@optional

/**
 * @brief 导航模式更新回调
 * @param eleBikeManager 电动车骑行导航管理类
 * @param naviMode 导航模式,参考 AMapNaviMode 值
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager updateNaviMode:(AMapNaviMode)naviMode;

/**
 * @brief 路径ID更新回调. 注意：请不要在此回调中调用 -selectNaviRouteWithRouteID: 接口，否则会出现死循环调用.
 * @param eleBikeManager 电动车骑行导航管理类
 * @param naviRouteID 导航路径ID
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager updateNaviRouteID:(NSInteger)naviRouteID;

/**
 * @brief 路径信息更新回调. 注意：请不要在此回调中调用 -selectNaviRouteWithRouteID: 接口，否则会出现死循环调用.
 * @param eleBikeManager 电动车骑行导航管理类
 * @param naviRoute 路径信息,参考 AMapNaviRoute 类
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager updateNaviRoute:(nullable AMapNaviRoute *)naviRoute;

/**
 * @brief 导航信息更新回调
 * @param eleBikeManager 电动车骑行导航管理类
 * @param naviInfo 导航信息,参考 AMapNaviInfo 类
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager updateNaviInfo:(nullable AMapNaviInfo *)naviInfo;

/**
 * @brief 自车位置更新回调
 * @param eleBikeManager 电动车骑行导航管理类
 * @param naviLocation 自车位置信息,参考 AMapNaviLocation 类
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager updateNaviLocation:(nullable AMapNaviLocation *)naviLocation;

@end

NS_ASSUME_NONNULL_END

//
//  AMapNaviEleBikeManager.h
//  AMapNaviKit
//
//  Created by yuanmenglong on 2021/3/31.
//  Copyright © 2021 Amap. All rights reserved.
//


#import "AMapNaviTravelManager.h"
#import "AMapNaviEleBikeDataRepresentable.h"

@protocol AMapNaviEleBikeManagerDelegate;
NS_ASSUME_NONNULL_BEGIN

///电动车骑行导航管理类
@interface AMapNaviEleBikeManager : AMapNaviTravelManager

#pragma mark - Singleton

/**
 * @brief AMapNaviEleBikeManager单例. since 8.0.0
 * @return AMapNaviEleBikeManager实例
 */
+ (instancetype)sharedInstance;

/**
 * @brief 销毁AMapNaviEleBikeManager单例. since 8.0.0
 * @return 是否销毁成功. 如果返回NO，请检查单例是否被强引用
 */
+ (BOOL)destroyInstance;

/**
 * @brief 请使用单例替代. since 8.0.0 init已被禁止使用，请使用单例 [AMapNaviEleBikeManager sharedInstance] 替代
 */
- (instancetype)init __attribute__((unavailable("since 8.0.0 init 已被禁止使用，请使用单例 [AMapNaviEleBikeManager sharedInstance] 替代")));

#pragma mark - Delegate

///实现了 AMapNaviRideManagerDelegate 协议的类指针
@property (nonatomic, weak) id<AMapNaviEleBikeManagerDelegate> delegate;

#pragma mark - Data Representative

/**
 * @brief 增加用于展示导航数据的DataRepresentative.注意:该方法不会增加实例对象的引用计数(Weak Reference)
 * @param aRepresentative 实现了 AMapNaviRideDataRepresentable 协议的实例
 */
- (void)addDataRepresentative:(id<AMapNaviEleBikeDataRepresentable>)aRepresentative;

/**
 * @brief 移除用于展示导航数据的DataRepresentative
 * @param aRepresentative 实现了 AMapNaviRideDataRepresentable 协议的实例
 */
- (void)removeDataRepresentative:(id<AMapNaviEleBikeDataRepresentable>)aRepresentative;

/**
 * @brief 增加用于接收导航回调事件的Listener, 效果等同于delegate. 注意:该方法不会增加实例对象的引用计数(Weak Reference). since 9.0.1
 * @param aListener 实现了 AMapNaviRideManagerDelegate 协议的实例
 */
- (void)addEventListener:(id<AMapNaviEleBikeManagerDelegate>)aListener;

/**
 * @brief 移除用于接收导航回调事件的Listener. since 9.0.1
 * @param aListener 实现了 AMapNaviRideManagerDelegate 协议的实例
 */
- (void)removeEventListener:(id<AMapNaviEleBikeManagerDelegate>)aListener;


#pragma mark - Navi Route

///当前导航路径的ID
@property (nonatomic, readonly) NSInteger naviRouteID;

///当前导航路径的信息,参考 AMapNaviRoute 类.
@property (nonatomic, readonly, nullable) AMapNaviRoute *naviRoute;

/**
 * @brief 多路径规划时的所有路径信息 since 8.0.0
 * @return 返回多路径规划时的所有路径ID和路线信息
 */
- (NSDictionary<NSNumber *,AMapNaviRoute *> *)naviRoutes;


/**
 * @brief 多路径规划时的所有路径ID,路径ID为 NSInteger 类型 since 8.0.0
 * @return 返回多路径规划时的所有路径ID
 */
- (NSArray<NSNumber *> *)naviRouteIDs;

/**
 * @brief 多路径规划时选择路径.注意:该方法仅限于在开始导航前使用,开始导航后该方法无效 since 8.0.0
 * @param routeID 路径ID
 * @return 是否选择路径成功
 */
- (BOOL)selectNaviRouteWithRouteID:(NSInteger)routeID;

///卫星定位信号强度类型,参考 AMapNaviGPSSignalStrength. 注意：只有导航中获取卫星定位信号强弱的值有效
@property (nonatomic, assign, readonly) AMapNaviGPSSignalStrength gpsSignalStrength;

#pragma mark - Calculate Route

// 以下算路方法需要高德坐标(GCJ02)

/**
 * @brief 不带起点的电动车骑行路径规划
 * @param endPoint 终点坐标.
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)calculateEleBikeRouteWithEndPoint:(AMapNaviPoint *)endPoint;

/**
 * @brief 带起点的电动车骑行路径规划
 * @param startPoint   起点坐标.
 * @param endPoint     终点坐标.
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)calculateEleBikeRouteWithStartPoint:(AMapNaviPoint *)startPoint
                                   endPoint:(AMapNaviPoint *)endPoint;

/**
 * @brief 根据高德POIInfo进行电动车骑行路径规划. since 8.0.0
 * @param startPOIInfo  起点POIInfo, 参考 AMapNaviPOIInfo. 如果以“我的位置”作为起点,请传nil. 如果startPOIInfo不为nil,那么POIID合法,优先使用ID参与算路,否则使用坐标点
 * @param endPOIInfo  终点POIInfo, 参考 AMapNaviPOIInfo. 如果POIID合法,优先使用ID参与算路,否则使用坐标点. 注意:POIID和坐标点不能同时为空
 * @param strategy  路径的计算策略，参考 AMapNaviTravelStrategy.
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
*/
- (BOOL)calculateEleBikeRouteWithStartPOIInfo:(nullable AMapNaviPOIInfo *)startPOIInfo
                                   endPOIInfo:(nonnull AMapNaviPOIInfo *)endPOIInfo
                                     strategy:(AMapNaviTravelStrategy)strategy;

/**
 * @brief 独立算路能力接口，可用于不干扰本次导航的单独算路场景. since 8.0.0
 * @param startPOIInfo  起点POIInfo, 参考 AMapNaviPOIInfo. 如果以“我的位置”作为起点,请传nil. 如果startPOIInfo不为nil,那么POIID合法,优先使用ID参与算路,否则使用坐标点
 * @param endPOIInfo  终点POIInfo, 参考 AMapNaviPOIInfo. 如果POIID合法,优先使用ID参与算路,否则使用坐标点. 注意:POIID和坐标点不能同时为空
 * @param strategy  路径的计算策略，参考 AMapNaviTravelStrategy.
 * @param callback 算路完成的回调.  算路成功时，routeGroup 不为空；算路失败时，error 不为空，error.code参照 AMapNaviCalcRouteState.
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)independentCalculateEleBikeRouteWithStartPOIInfo:(nullable AMapNaviPOIInfo *)startPOIInfo
                                              endPOIInfo:(nonnull AMapNaviPOIInfo *)endPOIInfo
                                                strategy:(AMapNaviTravelStrategy)strategy
                                                callback:(nullable void (^)(AMapNaviRouteGroup *_Nullable routeGroup, NSError *_Nullable error))callback;

/**
 * @brief 导航过程中重新规划路径(起点为当前位置,终点位置不变)
 * @return 重新规划路径所需条件和参数校验是否成功， 不代表算路成功与否，如非导航状态下调用此方法会返回NO.
 */
- (BOOL)recalculateEleBikeRoute;

#pragma mark - Manual

/**
 * @brief 开发者请根据实际情况设置外界此时是否正在进行语音播报. since 8.0.0
 * @param playing  如果外界正在播报语音，传入YES，否则传入NO.
*/
- (void)setTTSPlaying:(BOOL)playing;

@end


#pragma mark - AMapNaviRideManagerDelegate

@protocol AMapNaviEleBikeManagerDelegate <NSObject>
@optional

/**
 * @brief 发生错误时,会调用代理的此方法
 * @param eleBikeManager 电动车骑行导航管理类
 * @param error 错误信息
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager error:(NSError *)error;

/**
 * @brief 骑行路径规划成功后的回调函数
 * @param eleBikeManager 电动车骑行导航管理类
 */
- (void)rideManagerOnCalculateRouteSuccess:(AMapNaviEleBikeManager *)eleBikeManager;

/**
 * @brief 骑行路径规划失败后的回调函数. 从6.1.0版本起,算路失败后导航SDK只对外通知算路失败,SDK内部不再执行停止导航的相关逻辑.因此,当算路失败后,不会收到 driveManager:updateNaviMode: 回调; AMapNaviRideManager.naviMode 不会切换到 AMapNaviModeNone 状态, 而是会保持在 AMapNaviModeGPS or AMapNaviModeEmulator 状态
 * @param eleBikeManager 电动车骑行导航管理类
 * @param error 错误信息,error.code参照AMapNaviCalcRouteState
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager onCalculateRouteFailure:(NSError *)error;

/**
 * @brief 启动导航后回调函数
 * @param eleBikeManager 电动车骑行导航管理类
 * @param naviMode 导航类型，参考AMapNaviMode
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager didStartNavi:(AMapNaviMode)naviMode;

/**
 * @brief 出现偏航需要重新计算路径时的回调函数.偏航后将自动重新路径规划,该方法将在自动重新路径规划前通知您进行额外的处理.
 * @param eleBikeManager 电动车骑行导航管理类
 */
- (void)rideManagerNeedRecalculateRouteForYaw:(AMapNaviEleBikeManager *)eleBikeManager;

/**
 * @brief 导航播报信息回调函数
 * @param eleBikeManager 电动车骑行导航管理类
 * @param soundString 播报文字
 * @param soundStringType 播报类型,参考 AMapNaviSoundType. 注意：since 6.0.0 AMapNaviSoundType 只返回 AMapNaviSoundTypeDefault
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType;

/**
 * @brief 模拟导航到达目的地停止导航后的回调函数
 * @param eleBikeManager 电动车骑行导航管理类
 */
- (void)rideManagerDidEndEmulatorNavi:(AMapNaviEleBikeManager *)eleBikeManager;

/**
 * @brief 导航到达目的地后的回调函数
 * @param eleBikeManager 电动车骑行导航管理类
 */
- (void)rideManagerOnArrivedDestination:(AMapNaviEleBikeManager *)eleBikeManager;

/**
 * @brief 卫星定位信号强弱回调函数. since 7.4.0
 * @param eleBikeManager 电动车骑行导航管理类
 * @param gpsSignalStrength 卫星定位信号强度类型,参考 AMapNaviGPSSignalStrength .
 */
- (void)rideManager:(AMapNaviEleBikeManager *)eleBikeManager updateGPSSignalStrength:(AMapNaviGPSSignalStrength)gpsSignalStrength;

@end

NS_ASSUME_NONNULL_END

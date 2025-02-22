//
//  AMapNaviDriveManager.h
//  AMapNaviKit
//
//  Created by 刘博 on 16/1/12.
//  Copyright © 2016年 Amap. All rights reserved.
//

#import "AMapNaviBaseManager.h"
#import "AMapNaviDriveDataRepresentable.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AMapNaviDriveManagerDelegate;

#pragma mark - AMapNaviDriveManager

///驾车导航管理类
@interface AMapNaviDriveManager : AMapNaviBaseManager

#pragma mark - Singleton

/**
 * @brief AMapNaviDriveManager单例. since 5.4.0
 * @return AMapNaviDriveManager实例
 */
+ (AMapNaviDriveManager *)sharedInstance;

/**
 * @brief 销毁AMapNaviDriveManager单例. AMapNaviDriveManager内存开销比较大，建议不使用时可销毁. since 5.4.0
 * @return 是否销毁成功. 如果返回NO，请检查单例是否被强引用
 */
+ (BOOL)destroyInstance;

/**
 * @brief 请使用单例替代. since 5.4.0 init已被禁止使用，请使用单例 [AMapNaviDriveManager sharedInstance] 替代，且在调用类的 dealloc 函数或其他适当时机(如导航ViewController被pop时)，调用 [AMapNaviDriveManager destroyInstance] 来销毁单例（需要注意如未销毁成功，请检查单例是否被强引用)
 */
- (instancetype)init __attribute__((unavailable("since 5.4.0 init 已被禁止使用，请使用单例 [AMapNaviDriveManager sharedInstance] 替代，且在调用类的 dealloc 函数里或其他适当时机(如导航ViewController被pop时)，调用 [AMapNaviDriveManager destroyInstance] 来销毁单例（需要注意如未销毁成功，请检查单例是否被强引用)")));

#pragma mark - Delegate

///实现了 AMapNaviDriveManagerDelegate 协议的类指针
@property (nonatomic, weak) id<AMapNaviDriveManagerDelegate> delegate;

#pragma mark - Event Listener

/**
 * @brief 增加用于接收导航回调事件的Listener, 效果等同于delegate. 注意:该方法不会增加实例对象的引用计数(Weak Reference). since 5.4.0
 * @param aListener 实现了 AMapNaviDriveManagerDelegate 协议的实例
 */
- (void)addEventListener:(id<AMapNaviDriveManagerDelegate>)aListener;

/**
 * @brief 移除用于接收导航回调事件的Listener. since 5.4.0
 * @param aListener 实现了 AMapNaviDriveManagerDelegate 协议的实例
 */
- (void)removeEventListener:(id<AMapNaviDriveManagerDelegate>)aListener;

#pragma mark - Data Representative

/**
 * @brief 增加用于展示导航数据的DataRepresentative.注意:该方法不会增加实例对象的引用计数(Weak Reference)
 * @param aRepresentative 实现了 AMapNaviDriveDataRepresentable 协议的实例
 */
- (void)addDataRepresentative:(id<AMapNaviDriveDataRepresentable>)aRepresentative;

/**
 * @brief 移除用于展示导航数据的DataRepresentative
 * @param aRepresentative 实现了 AMapNaviDriveDataRepresentable 协议的实例
 */
- (void)removeDataRepresentative:(id<AMapNaviDriveDataRepresentable>)aRepresentative;

#pragma mark - Navi Route

///当前导航路径的ID
@property (nonatomic, readonly) NSInteger naviRouteID;

///当前导航路径的信息,参考 AMapNaviRoute 类.
@property (nonatomic, readonly, nullable) AMapNaviRoute *naviRoute;

///多路径规划时的所有路径ID,路径ID为 NSInteger 类型.
@property (nonatomic, readonly, nullable) NSArray<NSNumber *> *naviRouteIDs;

///多路径规划时的所有路径信息,参考 AMapNaviRoute 类.
@property (nonatomic, readonly, nullable) NSDictionary<NSNumber *, AMapNaviRoute *> *naviRoutes;

/**
 * @brief 多路径规划时选择路径.注意:该方法仅限于在开始导航前使用,开始导航后该方法无效.
 * @param routeID 路径ID
 * @return 是否选择路径成功
 */
- (BOOL)selectNaviRouteWithRouteID:(NSInteger)routeID;

/**
 * @brief 切换平行道路, 包括主辅路切换、高架上下切换. 该方法需要配合 AMapNaviDriveDataRepresentable 的 driveManager:updateParallelRoadStatus: 回调使用. since 5.3.0
 * @param parallelRoadInfo 平行路切换信息，参考 AMapNaviParallelRoadInfo.
 */
- (void)switchParallelRoad:(AMapNaviParallelRoadInfo *)parallelRoadInfo;

/**
 * @brief 设置多路线导航模式(实时导航中拥有若干条备选路线供用户选择), 或单路线导航模式(默认模式). 注意: 1、设置的导航模式会在下一次主动路径规划时生效, 建议在 AMapNaviDriveManager 单例初始化时就进行设置. 2、多路线导航模式还需同时满足以下4个条件才能够生效：a.路径规划时 AMapNaviDrivingStrategy 需选用多路径策略; b.起终点的直线距离需<=80KM; c.不能有途径点; d.车辆不能是货车类型. since 6.3.0
 * @param multipleRouteNaviMode YES:多路线导航模式, NO:单路线导航模式(默认)
 */
- (void)setMultipleRouteNaviMode:(BOOL)multipleRouteNaviMode;

/**
 * @brief 设置货车多路线导航模式(导航中拥有若干条备选路线供用户选择), 或单路线导航模式(默认模式)。建议在 AMapNaviDriveManager 单例初始化时就进行设置。注意：此方法仅限于在开始导航前调用有效，以下情况不会出现多备选路线：模拟导航、路线存在途经点、路线长度超过80KM。特别注意：当前接口为收费接口，您如果申请试用或者正式应用都请通过工单系统提交商务合作类工单进行沟通 https://lbs.amap.com/。since 9.3.5
 * @param multipleRouteNaviMode YES:多路线导航模式, NO:单路线导航模式. 默认为NO.
 */
- (void)setTruckMultipleRouteNaviMode:(BOOL)multipleRouteNaviMode;

#pragma mark - Options

///导航中是否播报摄像头信息,默认YES.
@property (nonatomic, assign) BOOL updateCameraInfo;

///导航中是否播报交通信息,默认YES(需要联网).
@property (nonatomic, assign) BOOL updateTrafficInfo;

///巡航模式,默认为 AMapNaviDetectedModeNone. 注意：1. 如果已经处在导航模式，要开启巡航模式时，需要先调用 stopNavi 来停止导航，再设置 detectedMode 才能生效 2.如果已经处于巡航模式，要开启导航前，需要先调用setDetectedMode(AMapNaviDetectedModeNone) 来关闭巡航，再开启导航
@property (nonatomic, assign) AMapNaviDetectedMode detectedMode;

///卫星定位信号强度类型, 参考 AMapNaviGPSSignalStrength since 7.8.0 只在导航中获取卫星定位信号强弱的值才有效
@property (nonatomic, assign, readonly) AMapNaviGPSSignalStrength gpsSignalStrength;

///默认为10, 范围为[ 5, 15 ], 单位秒. 表示有连续的10s, 定位信号质量都比较差, 就会触发手机卫星定位信号弱的回调. 值越小, 就越容易触发. since 6.6.0
@property (nonatomic, assign) NSUInteger gpsWeakDetecedInterval __attribute__((deprecated("已废弃，since 7.8.0")));

///设置是否显示红绿灯倒计时。since 10.0.700
- (void)setIsOpenTrafficLight:(NSString *)key;

#pragma mark - Calculate Route

// 以下算路方法需要高德坐标(GCJ02)

/**
 * @brief 不带起点的驾车路径规划
 * @param endPoints    终点坐标.终点列表的尾点为实时导航终点.
 * @param wayPoints    途经点坐标,最多支持16个途经点. 超过16个会取前16个.
 * @param strategy     路径的计算策略，建议使用 AMapNaviDrivingStrategyMultipleDefault，与[高德地图]默认策略一致 (避让拥堵+速度优先+避免收费)
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)calculateDriveRouteWithEndPoints:(NSArray<AMapNaviPoint *> *)endPoints
                               wayPoints:(nullable NSArray<AMapNaviPoint *> *)wayPoints
                         drivingStrategy:(AMapNaviDrivingStrategy)strategy;

/**
 * @brief 带起点的驾车路径规划
 * @param startPoints  起点坐标.起点列表的尾点为实时导航起点,其他坐标点为辅助信息,带有方向性,可有效避免算路到马路的另一侧.
 * @param endPoints    终点坐标.终点列表的尾点为实时导航终点,其他坐标点为辅助信息,带有方向性,可有效避免算路到马路的另一侧.
 * @param wayPoints    途经点坐标,最多支持16个途经点. 超过16个会取前16个
 * @param strategy     路径的计算策略，建议使用 AMapNaviDrivingStrategyMultipleDefault，与[高德地图]默认策略一致 (避让拥堵+速度优先+避免收费)
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)calculateDriveRouteWithStartPoints:(NSArray<AMapNaviPoint *> *)startPoints
                                 endPoints:(NSArray<AMapNaviPoint *> *)endPoints
                                 wayPoints:(nullable NSArray<AMapNaviPoint *> *)wayPoints
                           drivingStrategy:(AMapNaviDrivingStrategy)strategy;

/**
 * @brief 根据高德POIId进行驾车路径规划,为了保证路径规划的准确性,请尽量使用此方法. since 6.1.0
 * @param startPOIId  起点POIId,如果以“我的位置”作为起点,请传nil
 * @param endPOIId    终点POIId,必填
 * @param wayPOIIds   途经点POIId,最多支持16个途经点. 超过16个会取前16个
 * @param strategy    路径的计算策略，建议使用 AMapNaviDrivingStrategyMultipleDefault，与[高德地图]默认策略一致 (避让拥堵+速度优先+避免收费)
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)calculateDriveRouteWithStartPointPOIId:(nullable NSString *)startPOIId
                                 endPointPOIId:(nonnull NSString *)endPOIId
                                wayPointsPOIId:(nullable NSArray<NSString *> *)wayPOIIds
                               drivingStrategy:(AMapNaviDrivingStrategy)strategy;
/**
 * @brief 根据高德POIInfo进行驾车路径规划,为了保证路径规划的准确性,请尽量使用此方法. since 6.4.0
 * @param startPOIInfo  起点POIInfo,参考 AMapNaviPOIInfo. 如果以“我的位置”作为起点,请传nil. 如果startPOIInfo不为nil,那么POIID合法,优先使用ID参与算路,否则使用坐标点.
 * @param endPOIInfo    终点POIInfo,参考 AMapNaviPOIInfo. 如果POIID合法,优先使用ID参与算路,否则使用坐标点. 注意:POIID和坐标点不能同时为空
 * @param wayPOIInfos   途经点POIInfo,最多支持16个途经点,超过16个会取前16个. 如果POIID合法,优先使用ID参与算路,否则使用坐标点. 注意:POIID和坐标点不能同时为空
 * @param strategy      路径的计算策略，建议使用 AMapNaviDrivingStrategyMultipleDefault，与[高德地图]默认策略一致 (避让拥堵+速度优先+避免收费)
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)calculateDriveRouteWithStartPOIInfo:(nullable AMapNaviPOIInfo *)startPOIInfo
                                 endPOIInfo:(nonnull AMapNaviPOIInfo *)endPOIInfo
                                wayPOIInfos:(nullable NSArray<AMapNaviPOIInfo *> *)wayPOIInfos
                            drivingStrategy:(AMapNaviDrivingStrategy)strategy;

/**
 * @brief 独立算路能力接口，可用于不干扰本次导航的单独算路场景. since 7.7.0
 * @param startPOIInfo  起点POIInfo,参考 AMapNaviPOIInfo. 如果以“我的位置”作为起点,请传nil. 如果startPOIInfo不为nil,那么POIID合法,优先使用ID参与算路,否则使用坐标点.
 * @param endPOIInfo    终点POIInfo,参考 AMapNaviPOIInfo. 如果POIID合法,优先使用ID参与算路,否则使用坐标点. 注意:POIID和坐标点不能同时为空
 * @param wayPOIInfos   途经点POIInfo,最多支持16个途经点,超过16个会取前16个. 如果POIID合法,优先使用ID参与算路,否则使用坐标点. 注意:POIID和坐标点不能同时为空
 * @param strategy      路径的计算策略，建议使用 AMapNaviDrivingStrategyMultipleDefault，与[高德地图]默认策略一致 (避让拥堵+速度优先+避免收费)
 * @param callback 算路完成的回调.  算路成功时，routeGroup 不为空；算路失败时，error 不为空，error.code参照 AMapNaviCalcRouteState.
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)independentCalculateDriveRouteWithStartPOIInfo:(nullable AMapNaviPOIInfo *)startPOIInfo
                                            endPOIInfo:(nonnull AMapNaviPOIInfo *)endPOIInfo
                                           wayPOIInfos:(nullable NSArray<AMapNaviPOIInfo *> *)wayPOIInfos
                                       drivingStrategy:(AMapNaviDrivingStrategy)strategy
                                              callback:(nullable void (^)(AMapNaviRouteGroup *_Nullable routeGroup, NSError *_Nullable error))callback;
/**
 * @brief 导航过程中重新规划路径(起点为当前位置,途经点和终点位置不变)
 * @param strategy 路径的计算策略，建议使用 AMapNaviDrivingStrategyMultipleDefault，与[高德地图]默认策略一致 (避让拥堵+速度优先+避免收费)
 * @return 重新规划路径所需条件和参数校验是否成功, 不代表算路成功与否, 如非导航状态下调用此方法会返回NO.
 */
- (BOOL)recalculateDriveRouteWithDrivingStrategy:(AMapNaviDrivingStrategy)strategy;

#pragma mark - Manual

/**
 * @brief 设置车牌信息. 已废弃，请使用 setVehicleInfo: 替代，since 6.0.0
 * @param province 车牌省份缩写，例如："京"
 * @param number 除省份及标点之外，车牌的字母和数字，例如："NH1N11"
 */
- (void)setVehicleProvince:(NSString *)province number:(NSString *)number __attribute__((deprecated("已废弃，请使用 setVehicleInfo: 替代，since 6.0.0")));

/**
 * @brief 设置车辆信息. since 6.0.0
 * @param vehicleInfo 车辆信息，参考 AMapNaviVehicleInfo. 如果要清空已设置的车辆信息，传入nil即可.
 * @return 是否设置成功
 */
- (BOOL)setVehicleInfo:(nullable AMapNaviVehicleInfo *)vehicleInfo;

/**
 * @brief 设置播报模式. 注意：如果在导航过程中设置，需要在下次算路后才能起作用，如偏航重算、手动刷新后.
 * @param mode 参考  AMapNaviBroadcastMode . 默认新手详细播报( AMapNaviBroadcastModeDetailed )
 * @return 是否成功
 */
- (BOOL)setBroadcastMode:(AMapNaviBroadcastMode)mode;

/**
 * @brief 设置网约车模式. since 6.4.0
 * @param type 参考 AMapNaviOnlineCarHailingType. 默认为 AMapNaviOnlineCarHailingTypeNone (非网约车模式, 即正常模式)
 * @return 是否设置成功
 */
- (BOOL)setOnlineCarHailingType:(AMapNaviOnlineCarHailingType)type;

#pragma mark - Traffic Status

/**
 * @brief 获取某一范围内的路况光柱信息
 * @param startPosition 光柱范围在路径中的起始位置,取值范围[0, routeLength)
 * @param distance 光柱范围的距离,startPosition + distance 和的取值范围(0, routelength]
 * @return 该范围内路况信息数组,可用于绘制光柱,参考 AMapNaviTrafficStatus 类.
 */
- (nullable NSArray<AMapNaviTrafficStatus *> *)getTrafficStatusesWithStartPosition:(int)startPosition distance:(int)distance;

/**
 *  @brief 获取当前道路的路况光柱信息
 *  @return 该范围内路况信息数组,可用于绘制光柱,参考 AMapNaviTrafficStatus 类.
 */
- (nullable NSArray<AMapNaviTrafficStatus *> *)getTrafficStatuses;

#pragma mark - Xcode Simulate Location

/**
 * @brief 设置Xcode模拟定位点是否参与导航. 注意：此方法仅供开发者调试使用. since 6.7.0
 * @param enableNavi 模拟的定位点是否参与导航, 默认为NO.
 */
- (void)setXcodeSimulateLocationEnable:(BOOL)enableNavi __attribute__((deprecated("已废弃，since 7.5.0")));

#pragma mark - 服务区详情信息
/**
 * @brief 设置是否打开服务区详情信息. since 8.0.0
 * @param enable 请求服务详情信息的功能是否打开, 默认为NO.
 */
- (void)setServiceAreaDetailsEnable:(BOOL)enable;

#pragma mark - push路线相关

/**
 * @brief 路线还原接口。since 9.0.0
 * @param startPOIInfo  起点POIInfo，参考 AMapNaviPOIInfo。如果以“我的位置”作为起点,请传nil。 如果startPOIInfo不为nil,那么POIID合法，优先使用ID参与算路,否则使用坐标点.
 * @param endPOIInfo    终点POIInfo，参考 AMapNaviPOIInfo。如果POIID合法，优先使用ID参与算路,否则使用坐标点. 注意:POIID和坐标点不能同时为空
 * @param wayPOIInfos   途经点POIInfo,最多支持16个途经点,超过16个会取前16个。如果POIID合法,优先使用ID参与算路,否则使用坐标点。 注意:POIID和坐标点不能同时为空。
 * @param strategy      路径的计算策略。
 * @return 路线还原是否成功。
 */
- (BOOL)pushDriveRouteWithRouteGuideData:(nonnull NSData *)routeData
                            startPOIInfo:(nonnull AMapNaviPOIInfo *)startPOIInfo
                              endPOIInfo:(nonnull AMapNaviPOIInfo *)endPOIInfo
                             wayPOIInfos:(nullable NSArray<AMapNaviPOIInfo *> *)wayPOIInfos
                         drivingStrategy:(AMapNaviDrivingStrategy)strategy;

// 5.1 算路协议升级后的路线还原接口 routeguide 协议版本号 since 9.0.0
/**
 * @brief 获取导航路线还原版本号。since 9.0.0
 * @return routeguide 协议版本号。
 */
- (NSString *_Nullable)getPushDataNaviVersion;

/**
 * @brief 获得 routeService 版本号。
 * @return routeService 协议版本号。
 */
- (NSString *_Nullable)routeSDKVersion;

/**
 * @brief 获得 routeServer 版本号。
 * @return routeServer 协议版本号。
 */
- (NSString *_Nullable)routeServerVersion;
@end

#pragma mark - Escort

@interface AMapNaviDriveManager (Escort)

/**
 * 设置一路护航任务id.  注意：此方法必须在"开始算路"之前设置, 否则无效, since 6.7.0
 * @param missonID 一路护航的任务id
 * @return 是否设置成功
 */
- (BOOL)setEscortMissonID:(NSNumber *)missonID;

@end

#pragma mark - Private

@interface AMapNaviDriveManager (Private)
/**
 * @brief 私有静态方法,外部禁止调用. since 7.8.0
 */
+ (BOOL)setCustomCloudControlEnable:(BOOL)enable;
/**
 * @brief 私有实例接口,外部禁止调用. since 7.8.0
 */
- (BOOL)setExtenalCloudControl:(nullable NSString *)cloudControlString;

/**
 * @brief 获取限行数据接口. 注意：当前接口为付费接口，使用当前接口需要 官网联系https://lbs.amap.com/ 商务  since 9.0.1
 * @param callback 获取限行数据的回调.  success 代表是否获取限行数据成功，获取限行数据成功时，responseData 不为空；获取限行数据失败时，errorDesc 不为空.
 *1.  success 为true response成功时返回结构体：
 {
 "code": 1, ----code的value 为 1 请求限行数据成功
 "citynums": 1,
 "citys": [{
     "citycode": 000,
     "rulenums": 1,
     "cityname": "XX市",
     "title": "XXX限行政策",
     "rules": [{
         "ruleid": 1766888,
         "ring": 0,
         "effect": 1,
         "local": 2,
         "vehicle": 1,
         "time": "全天限行",
         "policyname": "二环及以内外地机动车限行",
         "summary": "二环路及以内道路（不含外侧辅路）",
         "desc": "2021年11月1日起，外地全部机动车限行",
         "otherdesc": "",
         "centerpoint": "116.397451,39.909060",
         "linepoints": "",
         "areapoints": ""。
     }]
 }]
}
 code：
 code的value 为 1 请求限行数据成功， code 为value 非1值，则代表限行数据服务返回失败
 areapoints：
 1.在同一限行区域存在一个限行多边形时,限行数据为经度和纬度使用逗号(,)隔开,多个经纬度使用分号(;)隔开；
  example一个多边形数据:
  |---------------- 多边形1--------------------|  每一个多边形对应一个polygon
  lon1,lat1;lon2,lat2;lon3,lat3;lon4,lat4;
 2.在同一限行区域存在多个限行多边形时,多个多边形之间的数据使用竖线 (|) 隔开；
  example3个多边形数据:
  |---------------- 多边形1--------------------|  |----------- 多边形2-----------|      |----------- 多边形3-----------|
  lon1,lat1;lon2,lat2;lon3,lat3;lon4,lat4|  lon5,lat5;lon6,lat6;lon7,lat7|    lon8,lat8;lon9,lat9;lon10,lat10
 * 2.success 为false response为空，errorDesc为返回的错误描述
 * @return 获取限行条件是否满足；路线上数据不为空,且路线上有限行信息，则返回YES，否则的话则返回NO；不代表获取限行数据成功与否
*/
- (BOOL)getRestrictareaInfoInRoute:(AMapNaviRoute *)route callback:(nonnull void (^)(BOOL responseSuccess, NSString *responseData, NSString *errorDesc))callback;

@end

#pragma mark - AMapNaviDriveManagerDelegate
@protocol AMapNaviDriveManagerDelegate <NSObject>
@optional
/**
 * @brief 发生错误时,会调用代理的此方法
 * @param driveManager 驾车导航管理类
 * @param error 错误信息
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error;

/**
 * @brief 驾车路径规划成功后的回调函数，请尽量使用 -driveManager:onCalculateRouteSuccessWithType: 替代此方法
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 驾车路径规划成功后的回调函数 since 6.1.0
 * @param driveManager 驾车导航管理类
 * @param type 路径规划类型,参考 AMapNaviRoutePlanType
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteSuccessWithType:(AMapNaviRoutePlanType)type;

/**
 * @brief 驾车路径规划失败后的回调函数. 从5.3.0版本起,算路失败后导航SDK只对外通知算路失败,SDK内部不再执行停止导航的相关逻辑.因此,当算路失败后,不会收到 driveManager:updateNaviMode: 回调; AMapNaviDriveManager.naviMode 不会切换到 AMapNaviModeNone 状态, 而是会保持在 AMapNaviModeGPS or AMapNaviModeEmulator 状态.
 * @param driveManager 驾车导航管理类
 * @param error 错误信息,error.code参照 AMapNaviCalcRouteState
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error;

/**
 * @brief 驾车路径规划失败后的回调函数. since 6.1.0
 * @param driveManager 驾车导航管理类
 * @param error 错误信息,error.code参照 AMapNaviCalcRouteState
 * @param type 路径规划类型,参考 AMapNaviRoutePlanType
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error routePlanType:(AMapNaviRoutePlanType)type;

/**
 * @brief 启动导航后回调函数
 * @param naviMode 导航类型，参考 AMapNaviMode .
 * @param driveManager 驾车导航管理类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode;

/**
 * @brief 出现偏航需要重新计算路径时的回调函数.偏航后 SDK 内部将自动重新路径规划,该方法将在自动重新路径规划前通知您进行额外的处理，您无需自行算路.
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 前方遇到拥堵需要重新计算路径时的回调函数.拥堵后 SDK 将自动重新路径规划,该方法将在自动重新路径规划前通知您进行额外的处理，您无需自行算路.
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 导航到达某个途经点的回调函数
 * @param driveManager 驾车导航管理类
 * @param wayPointIndex 到达的途径点的索引值，表示的是 AMapNaviRoute.wayPointsInfo 的索引.
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex;

/**
 * @brief 开发者请根据实际情况返回是否正在播报语音，如果正在播报语音，请返回YES, 如果没有在播报语音，请返回NO
 * @param driveManager 驾车导航管理类
 * @return 如一直返回YES，SDK内部会认为外界声道较忙，导致部分文字无法吐出; 如一直返回NO，文字吐出的频率可能会过快，会出现打断的情况，所以请根据实际情况返回。
 */
- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 导航播报信息回调函数,此回调函数需要和driveManagerIsNaviSoundPlaying:配合使用
 * @param driveManager 驾车导航管理类
 * @param soundString 播报文字
 * @param soundStringType 播报类型,参考 AMapNaviSoundType. 注意：since 6.0.0 AMapNaviSoundType 只返回 AMapNaviSoundTypeDefault
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType;

/**
 * @brief 模拟导航到达目的地后的回调函数
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 实时导航到达目的地后的回调函数
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 导航(巡航)过程中播放提示音的回调函数. since 5.4.0
 * @param driveManager 驾车导航管理类
 * @param ringType 提示音类型,参考 AMapNaviRingType .
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onNaviPlayRing:(AMapNaviRingType)ringType;

/**
 * @brief 卫星定位信号强弱回调函数. since 5.5.0
 * @param driveManager 驾车导航管理类
 * @param gpsSignalStrength 卫星定位信号强度类型,参考 AMapNaviGPSSignalStrength .
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateGPSSignalStrength:(AMapNaviGPSSignalStrength)gpsSignalStrength;

/**
 * @brief 实时导航中关于路线的‘信息通知’回调. since 6.2.0
 * @param driveManager 驾车导航管理类
 * @param notifyData 通知信息, 参考 AMapNaviRouteNotifyData .
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager postRouteNotification:(AMapNaviRouteNotifyData *)notifyData;

/**
 * @brief 多路线实时导航模式下，建议将某备选路线切换为主导航路线的回调函数. since 6.3.0
 * @param driveManager 驾车导航管理类
 * @param suggestChangeMainNaviRouteInfo 切换主导航路线的相关信息, 参考 AMapNaviSuggestChangeMainNaviRouteInfo .
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onSuggestChangeMainNaviRoute:(AMapNaviSuggestChangeMainNaviRouteInfo *)suggestChangeMainNaviRouteInfo;

/**
 * @brief 驾车导航道路舒适度回调。特别注意：当前接口为收费接口，您如果申请试用或者正式应用都请通过工单系统提交商务合作类工单进行沟通 https://lbs.amap.com/ since 9.3.5
 * @param manager 驾车导航管理类
 * @param driveComfort 驾车舒适度信息对象
 */
- (void)driveManager:(AMapNaviDriveManager *_Nullable)manager onUpdateDriveComfort:(AMapNaviDriveComfort *_Nonnull)driveComfort;

/**
 * 驾车导航三急（急加速/急减速/急转弯）事件回调。特别注意：当前接口为收费接口，您如果申请试用或者正式应用都请通过工单系统提交商务合作类工单进行沟通 https://lbs.amap.com/ since 9.3.5
 * @param manager 驾车导航管理类
 * @param driveEvent 驾驶事件信息对象
 */
- (void)driveManager:(AMapNaviDriveManager *_Nullable)manager onUpdateDriveEvent:(AMapNaviDriveEvent *_Nonnull)driveEvent;

/**
 * 路段限速值，进入新的路段后，会回调当前路段的限速值，进入没有限速的路段时，限速值回调为0。since 9.6.0
 * @param manager 驾车导航管理类
 * @param speed 路段限速值
 */
- (void)driveManager:(AMapNaviDriveManager *_Nullable)manager onUpdateNaviSpeedLimitSection:(NSInteger)speed;
@end

NS_ASSUME_NONNULL_END

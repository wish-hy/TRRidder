//
//  AMapNaviWalkView.h
//  AMapNaviKit
//
//  Created by AutoNavi on 15/12/28.
//  Copyright © 2016年 Amap. All rights reserved.
//

#import "AMapNaviHeaderHandler.h"
#import "AMapNaviCommonObj.h"
#import "AMapNaviWalkDataRepresentable.h"

NS_ASSUME_NONNULL_BEGIN

///步行导航界面显示模式
typedef NS_ENUM(NSInteger, AMapNaviWalkViewShowMode)
{
    AMapNaviWalkViewShowModeCarPositionLocked = 1,  ///< 锁车状态
    AMapNaviWalkViewShowModeOverview = 2,           ///< 全览状态
    AMapNaviWalkViewShowModeNormal = 3,             ///< 普通状态
};

@protocol AMapNaviWalkViewDelegate;

///步行导航界面.该类实现 AMapNaviWalkDataRepresentable 协议,可通过 AMapNaviWalkManager 的addDataRepresentative:方法进行注册展示步行导航过程.
@interface AMapNaviWalkView : UIView<AMapNaviWalkDataRepresentable>

#pragma mark - Delegate

///实现了 AMapNaviWalkViewDelegate 协议的类指针
@property (nonatomic, weak) id<AMapNaviWalkViewDelegate> delegate;

#pragma mark - Options

///目前是否为横屏状态. since 7.4.0 内部会自行监听 UIDeviceOrientationDidChange 进行横竖屏切换，无需再设置此值，但用户要自行保证 AMapNaviWalkView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight，让 AMapNaviWalkView 能够跟着父View一起变化. 可通过回调 -walkView:didChangeOrientation: 获取横竖屏切换时机
@property (nonatomic, assign, readonly) BOOL isLandscape;

///导航界面跟随模式,默认AMapNaviViewTrackingModeMapNorth
@property (nonatomic, assign) AMapNaviViewTrackingMode trackingMode;

///导航界面显示模式,默认AMapNaviWalkViewShowModeCarPositionLocked
@property (nonatomic, assign) AMapNaviWalkViewShowMode showMode;

///是否显示界面元素,默认YES
@property (nonatomic, assign) BOOL showUIElements;

///是否显示全览按钮,默认YES
@property (nonatomic, assign) BOOL showBrowseRouteButton;

///是否显示更多按钮,默认YES
@property (nonatomic, assign) BOOL showMoreButton;

///是否显示转向箭头,默认YES
@property (nonatomic, assign) BOOL showTurnArrow;

///是否显示传感器方向信息,默认NO.设置为YES后,自车图标方向将显示为设备方向
@property (nonatomic, assign) BOOL showSensorHeading __attribute((deprecated("已废弃，自车图标方向将显示为设备方向，不再支持设置。since 10.0.900")));

///导航界面日夜模式类型, 默认为 AMapNaviViewMapModeTypeDay(白天模式) since 8.0.0
@property (nonatomic, assign) AMapNaviViewMapModeType mapViewModeType __attribute((deprecated("已废弃，不支持外部设置。since 10.0.900")));


#pragma mark - MapView

///是否显示指南针,默认NO
@property (nonatomic, assign) BOOL showCompass;

///非锁车状态下地图cameraDegree，锁车态下内部会处理，默认35.0，范围[0,60]。since 10.0.900
@property (nonatomic, assign) CGFloat cameraDegree;

///当前地图是否显示比例尺，默认NO
@property (nonatomic, assign) BOOL showScale;

///当前地图比例尺的原点位置，默认(10,10)
@property (nonatomic, assign) CGPoint scaleOrigin;

///地图的视图锚点. (0, 0)为左上角，(1, 1)为右下角. 可通过设置此值来改变自车图标的默认显示位置. 注意:只有showUIElements为NO时，设置此值才有效 since 8.0.0
@property (nonatomic, assign) CGPoint screenAnchor;

///指南针原点位置. since 8.0.0
@property (nonatomic, assign) CGPoint compassOrigin;

/**
 * @brief 自定义地图样式设置,可以支持分级样式配置，如控制不同级别显示不同的颜色(自6.6.0开始使用新版样式，旧版样式无法在新版接口setCustomMapStyleOptions:(MAMapCustomStyleOptions *)styleOptions中使用，请到官网(lbs.amap.com)更新新版样式文件)
 * @param styleOptions 自定义样式options. since 6.6.0
 */
- (void)setCustomMapStyleOptions:(MAMapCustomStyleOptions *)styleOptions;

#pragma mark - Polyline Texture

///路线polyline的宽度,设置0恢复默认宽度
@property (nonatomic, assign) CGFloat lineWidth;

///标准路线Polyline的纹理图片,设置nil恢复默认纹理.纹理图片需满足：长宽相等，且宽度值为2的次幂
@property (nonatomic, copy, nullable) UIImage *normalTexture __attribute((deprecated("已废弃, 请使用 routeStatusColor 替代 since 10.0.900")));

///走过的路线是否置灰,默认为NO. since 7.4.0
@property (nonatomic, assign) BOOL showGreyAfterPass;

///路线纹理部分走过后置灰的纹理图片,设置nil恢复默认纹理. 纹理图片需满足：长宽相等，且宽度值为2的次幂. since 7.4.0
@property (nonatomic, copy, nullable) UIImage *greyTexture __attribute((deprecated("已废弃, 请使用 routeGreyColor 替代 since 10.0.900")));;

// 路线走过后置灰的颜色 since 10.0.900
@property (nonatomic, strong) AMapNaviPolylineGreyColor *routeGreyColor;

///路线的颜色，在调用 addDataRepresentative 前设置，status 设置为 AMapNaviRouteStatusDefault since 10.0.900
@property (nonatomic, copy) AMapNaviPolylineTrafficStatusColor *routeStatusColor;

#pragma mark - Other

/**
 * @brief 在全览状态下调用此函数能够让路线显示在可视区域内(排除EdgePadding后剩余的区域)，保证路线不被自定义界面元素遮挡. 比如showUIElements为NO时（自定义界面）横竖屏切换后，可以调用此函数. since 8.0.0
 */
- (void)updateRoutePolylineInTheVisualRangeWhenTheShowModeIsOverview;

#pragma mark - Image

/**
 * @brief 设置路径起点图标
 * @param startPointImage 起点图标
 */
- (void)setStartPointImage:(nullable UIImage *)startPointImage;

/**
 * @brief 设置路径终点图标
 * @param endPointImage 终点图标
 */
- (void)setEndPointImage:(nullable UIImage *)endPointImage;

/**
 * @brief 设置自车图标
 * @param carImage 自车图标
 */
- (void)setCarImage:(nullable UIImage *)carImage;

/**
 * @brief 设置自车罗盘图标
 * @param carCompassImage 自车罗盘图标
 */
- (void)setCarCompassImage:(nullable UIImage *)carCompassImage;

/**
 * @brief 设置路径途经点图标 since 9.3.5
 * @param wayPointImage 途经点图标
 */
- (void)setWayPointImage:(nullable UIImage *)wayPointImage;
@end

@protocol AMapNaviWalkViewDelegate <NSObject>
@optional

/**
 * @brief 导航界面关闭按钮点击时的回调函数
 * @param walkView 步行导航界面
 */
- (void)walkViewCloseButtonClicked:(AMapNaviWalkView *)walkView;

/**
 * @brief 导航界面更多按钮点击时的回调函数
 * @param walkView 步行导航界面
 */
- (void)walkViewMoreButtonClicked:(AMapNaviWalkView *)walkView;

/**
 * @brief 导航界面转向指示View点击时的回调函数
 * @param walkView 步行导航界面
 */
- (void)walkViewTrunIndicatorViewTapped:(AMapNaviWalkView *)walkView;

/**
 * @brief 导航界面显示模式改变后的回调函数
 * @param walkView 步行导航界面
 * @param showMode 显示模式
 */
- (void)walkView:(AMapNaviWalkView *)walkView didChangeShowMode:(AMapNaviWalkViewShowMode)showMode;

/**
 * @brief 导航界面跟随模式改变后的回调函数. since 7.4.0
 * @param walkView 步行导航界面
 * @param trackMode 跟随模式
 */
- (void)walkView:(AMapNaviWalkView *)walkView didChangeTrackingMode:(AMapNaviViewTrackingMode)trackMode;

/**
 * @brief 导航界面横竖屏切换后的回调函数. since 7.4.0
 * @param walkView 步行导航界面
 * @param isLandscape 是否是横屏
 */
- (void)walkView:(AMapNaviWalkView *)walkView didChangeOrientation:(BOOL)isLandscape;

/**
 * @brief 导航界面白天黑夜模式切换后的回调函数. since 8.0.0
 * @param walkView 步行导航界面
 * @param showStandardNightType 是否为黑夜模式
 */
- (void)walkView:(AMapNaviWalkView *)walkView didChangeDayNightType:(BOOL)showStandardNightType;

/**
 * @brief 在showUIElements为NO时，步行导航界面需要实时的取得可视区域，比如切换成全览时、横竖屏切换时. 注意：此回调只在showUIElements为NO时，才会调用且比较频繁，在获取EdgePadding时请勿进行大量的计算. since 8.0.0
 * @param walkView 步行导航界面
 * @return 如(100, 50, 80, 60)表示的是：walkView.bounds 上边留出100px，左边留出50px，底部留出80px，右边留出60px后的区域为可视区域，一般EdgePadding的值由用户的界面布局决定.
 */
- (UIEdgeInsets)walkViewEdgePadding:(AMapNaviWalkView *)walkView;

@end

NS_ASSUME_NONNULL_END

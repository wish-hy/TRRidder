//
//  AMapNaviManagerConfig.h
//  AMapNaviManagerConfig
//
//  Created by yuanmenglong on 2021/8/25.
//  Copyright © 2021 Amap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapServices.h>
#import "AMapNaviCommonObj.h"
NS_ASSUME_NONNULL_BEGIN

@interface AMapNaviManagerConfig : NSObject

@property (nonatomic, assign) BOOL customviewShowViaEtaEnable;

/**
 * @brief AMapNaviManagerConfig单例. since 8.0.1
 * @return AMapNaviManagerConfig实例
 */
+ (instancetype)sharedConfig;

#pragma mark - Privacy 隐私合规
/**
 * @brief 更新App是否显示隐私弹窗的状态，隐私弹窗是否包含高德SDK隐私协议内容的状态，注意：必须在导航任何一个manager实例化之前调用. since 8.1.0
 * @param showStatus 隐私弹窗状态
 * @param containStatus 包含高德SDK隐私协议状态
 */
- (void)updatePrivacyShow:(AMapPrivacyShowStatus)showStatus privacyInfo:(AMapPrivacyInfoStatus)containStatus;

/**
 * @brief 更新用户授权高德SDK隐私协议状态，注意：必须在导航任何一个manager实例化之前调用. since 8.1.0
 * @param agreeStatus 用户授权高德SDK隐私协议状态
 */
- (void)updatePrivacyAgree:(AMapPrivacyAgreeStatus)agreeStatus;

@end

#pragma mark - Private

@interface AMapNaviManagerConfig (Private)

/**
 * @brief 设置途径点私有实例接口,外部禁止调用. since 7.9.0
 */
- (void)setViaPointEtaDisplayEnable:(BOOL )isEnable;

- (BOOL)isShowViaEta;
@end


NS_ASSUME_NONNULL_END

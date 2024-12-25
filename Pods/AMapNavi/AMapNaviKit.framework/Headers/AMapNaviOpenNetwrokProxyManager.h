//
//  AMapNaviOpenNetwrokProxyManager.h
//  AMapNaviKit
//
//  Created by chenyu on 2023/8/7.
//  Copyright © 2023 Amap. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AMapNaviOpenNetwrokProxyDelegate;

@interface AMapNaviOpenNetwrokProxyManager : NSObject

/**
 * @brief AMapNaviOpenNetwrokProxyManager 单例. since 10.0.1
 * @return AMapNaviOpenNetwrokProxyManager 实例
 */
+ (AMapNaviOpenNetwrokProxyManager *)sharedInstance;

#pragma mark - delegate
///实现了 AMapNaviOpenNetwrokProxyDelegate 协议的类指针
@property (nonatomic, weak) id<AMapNaviOpenNetwrokProxyDelegate> delegate;

@end


#pragma mark - AMapNaviOpenNetwrokProxy
@protocol AMapNaviOpenNetwrokProxyDelegate <NSObject>

@optional

/**
 * @brief 通过path获取代理host，开发者需要保证host的合法性。since 10.0.1
 * @param path 网络请求的path
 */
- (NSString *)getHostByPath:(NSString *)path;

/**
 * @brief 开发者请根据实际情况返回对应的请求path是否需要携带参数，参数和数据放在URL中，需要注意携带的数据不易过多，且需要对key、value进行encode。since 10.0.1
 * @param path 网络请求的path
 * @return 根据path返回需要携带的数据，没有需要携带的数据可返回nil，也可不实现。
 */
- (NSDictionary *)getExtRequestParamByPath:(NSString *)path;

/**
 * @brief 通过path获取代理host。since 10.0.1
 * @param path 网络请求的path
 * @param repsoneStr 服务返回的数据
 */
- (void)onResponseExtParam:(NSString *)path repsoneStr:(NSString *)repsoneStr;

@end

NS_ASSUME_NONNULL_END

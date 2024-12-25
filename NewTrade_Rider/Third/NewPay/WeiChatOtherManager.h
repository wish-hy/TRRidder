//
//  WeiChatOtherDelegate.h
//  UnifyPayDemo
//
//  Created by MacW on 2020/3/11.
//  Copyright © 2020 LiuMengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeiChatOtherManager : NSObject <WXApiDelegate>

+ (instancetype)shareManager;
@end

NS_ASSUME_NONNULL_END

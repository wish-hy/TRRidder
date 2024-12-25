//
//  WeiChatOtherDelegate.m
//  UnifyPayDemo
//
//  Created by MacW on 2020/3/11.
//  Copyright © 2020 LiuMengkai. All rights reserved.
//

#import "WeiChatOtherManager.h"

@implementation WeiChatOtherManager

static WeiChatOtherManager *_WXPayOtherManager = nil;

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WXPayOtherManager = [[WeiChatOtherManager alloc] init];
    });
    return _WXPayOtherManager;
}
/*
 if code.elementsEqual("1003") {
     SVProgressHUD.showInfo(withStatus: "请安装支付宝客户端")
 } else if code.elementsEqual("1000") {
     SVProgressHUD.showInfo(withStatus: "取消支付")
 } else if code.elementsEqual("1002") {
     SVProgressHUD.showInfo(withStatus: "网络连接错误")
 } else if code.elementsEqual("1001") {
     SVProgressHUD.showInfo(withStatus: "参数错误")
 } else if code.elementsEqual("2003") {
     SVProgressHUD.showInfo(withStatus: "订单支付失败")
 } else if code.elementsEqual("9999") {
     SVProgressHUD.showInfo(withStatus: "其他支付错误")
 } else if code.elementsEqual("2002") {
     SVProgressHUD.showInfo(withStatus: "订单号重复")
 } else if code.elementsEqual("2001") || code.elementsEqual("0000"){
     SVProgressHUD.showSuccess(withStatus: "支付成功")
     NotificationCenter.default.post(name: .init(Notification_Name_Pay_Suceess), object: nil)
 } else {
     
 }
}
 */
- (void)onResp:(BaseResp*)resp {
    //处理微信分享等功能
    if ([resp isKindOfClass:[WXLaunchMiniProgramResp class]])
    {
        WXLaunchMiniProgramResp *res = (WXLaunchMiniProgramResp *)resp;
        NSString *code = res.extMsg;
        if ([code isEqualToString:@"2001"] || [code isEqualToString:@"0000"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_Name_Pay_Suceess" object:nil];
        } else if ([code isEqualToString:@"1000"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_Name_Pay_Cancel" object:nil];
            //支付取消
            //支付取消
        }
    }
    
}
@end

//
//  SocketConnection.h
//  SocketDemo
//
//  Created by 4399 on 2021/3/25.
//  Copyright © 2021 liran. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol SocketConnectionDelegate<NSObject>
//接受数据
- (void)recvMsg:(NSData *)data;
//连接结果
- (void)didConnected:(BOOL)isSuccess;
//断开连接 0 服务断开 1 自己断开
- (void)didDisConnected:(BOOL)isSuccess reson:(int)reason;
@end

@interface SocketConnection : NSObject
@property (nonatomic, assign) BOOL isconnected;
@property (nonatomic, assign) id<SocketConnectionDelegate> delegate;
@property (nonatomic) NSString *IP_ADRR;
@property (nonatomic) NSInteger PORT;
- (BOOL)socketConnection;

- (BOOL)stopConnection;

- (void)recvMsg;

- (void)sendMsg:(NSData *)msg;



@end

NS_ASSUME_NONNULL_END

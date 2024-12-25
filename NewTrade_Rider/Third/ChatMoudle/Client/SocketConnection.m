//
//  SocketConnection.m
//  SocketDemo
//
//  Created by 4399 on 2021/3/25.
//  Copyright © 2021 liran. All rights reserved.
//


#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import "SocketConnection.h"
#import "ProtobufDecoder.h"
//htons将一个无符号整型数据转为网络字节顺序，不同cpu是不同的顺序
//#define SOCKET_PORT htons(7214)
////ip地址：以本地为例子
//#define IP_ADRR "192.168.1.13"


@interface SocketConnection()

@property (nonatomic,assign) int clientId;
@end

@implementation SocketConnection

- (BOOL)socketConnection{
    NSLog(@"xzy111111");
    //创建socket
    /// int socket(int family, int type, int protocol);
    ///参数一：family：协议簇或者协议域（AF_INET：IPv4协议；AF_INET6:IPv6协议；AF_LOCAL：Unix域协议；AF_ROUTE：路由套接字；AF_KEY：密钥套接字）
    ///参数二：type：套接字类型（SOCK_STREAM：字节流套接字；SOCK_DGRAM：数据包套接字；SOCK_EQPACKET：有序分组套接字；SOCK_RAW：原始套接字）
    ///参数三：protocol协议类型（IPPROTO_TCP：TCP传输协议；IPPROTO_UDP：UDP传输协议；IPPROTO_SCTP：SCTP传输协议；0:选择所给定family和type组合的系统默认值）
    ///
    ///
    
    ///int connect(int sockfd, const struct sockaddr * servaddr, socklen_t addrlen)
    ///参数一：sockfd（socket描述符）
    ///参数二：servaddr（socket地址结构体指针）
    ///参数三：addrlen（socket地址结构体大小）
    int socketId = socket(AF_INET, SOCK_STREAM, 0);
    self.clientId = socketId;
    if (socketId == -1) {
        if (_delegate && [_delegate respondsToSelector:@selector(didConnected:)]) {
            [_delegate didConnected:false];
        }
        return false;
    }
    //连接socket
    struct sockaddr_in socketAdrr;
    struct in_addr socketIn_adrr;
    
    socketAdrr.sin_family = AF_INET;
    socketAdrr.sin_port = htons(_PORT);

    
//    if _IP_ADRR != nil {
        socketIn_adrr.s_addr = inet_addr([_IP_ADRR UTF8String]);
//    }
    socketAdrr.sin_addr = socketIn_adrr;
    
    //放置debug崩溃？
    int set = 1;
    setsockopt(socketId, SOL_SOCKET, SO_NOSIGPIPE, (void*)&set, sizeof(int));
    
    int result = connect(socketId, (const struct sockaddr *)&socketAdrr, sizeof(socketAdrr));
    if(result != 0){
        //链接失败重来
        _isconnected = FALSE;
        if (_delegate && [_delegate respondsToSelector:@selector(didConnected:)]) {
            [_delegate didConnected:false];
        }
        return false;
    }
   
    _isconnected = TRUE;
    if (_delegate && [_delegate respondsToSelector:@selector(didConnected:)]) {
        [_delegate didConnected:true];
    }
    ///异步接受信息，防止阻塞主线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self recvMsg];
    });
    
    return true;
}
- (BOOL)stopConnection{
    if (self.clientId) {
        int close_result = close(self.clientId);
        if (close_result == -1) {
            if (_delegate && [_delegate respondsToSelector:@selector(didDisConnected:reson:)]) {
                [_delegate didDisConnected:false reson:-1];
            }
            return false;
        }else{
            _isconnected = FALSE;
            if (_delegate && [_delegate respondsToSelector:@selector(didDisConnected:reson:)]) {
                [_delegate didDisConnected:true reson:1];
            }
            return  true;
        }
    }
    //没有id 是不会链接成功的
    return  true;
}


- (void)recvMsg{
    while (1) {
        uint8_t buffers[1024];
        ///ssize_t recv(int, void *, size_t, int)
        ///参数一：socket标志符
        ///参数二：缓冲区
        ///参数三：缓冲区大小
        ///参数四：指定调用方式，一般设置为0
        ssize_t sizeLen = recv(self.clientId, buffers, sizeof(buffers), 0);
        if(sizeLen == 0){
            //服务器那边断开 重连
            _isconnected = false;
            if (_delegate && [_delegate respondsToSelector:@selector(didDisConnected:reson:)]) {
                [_delegate didDisConnected:true reson:0];
            }
            return;
        }
        if (sizeLen == -1) {
            //自己断开
            _isconnected = false;
            return;;
        }
        
        
        NSData *data = [NSData dataWithBytes:buffers length:sizeLen];
        if (_delegate && [_delegate respondsToSelector:@selector(recvMsg:)]) {
            [_delegate recvMsg :data];
        }
//        NSData *data = [NSData dataWithBytes:buffers length:sizeLen];
//        [buffer appendData:data];
        
//        ProtobufDecoder *decoder = [[ProtobufDecoder alloc] init];
//        NSMutableData *buffer = [NSMutableData data];
//        NSData *data = [NSData dataWithBytes:buffers length:sizeLen];
//        if ([decoder hasCompleteMessageInBuffer:data]) {
//            NSData *completeMessage = [decoder extractCompleteMessageFromBuffer:buffer];
//            if (completeMessage) {
//                           if (_delegate && [_delegate respondsToSelector:@selector(recvMsg:)]) {
//                               [_delegate recvMsg:completeMessage];
//                           }
//                       } else {
//                           break;
//                       }
//        }else{
//            [buffer appendData:data];  // 将接收到的数据追加到缓冲区
//        }
//       
//        [buffer appendData:data];  将接收到的数据追加到缓冲区
//        while (TRUE) {
//            NSData *completeMessage = [decoder extractCompleteMessageFromBuffer:buffer];
//            if (completeMessage) {
//                if (_delegate && [_delegate respondsToSelector:@selector(recvMsg:)]) {
//                    [_delegate recvMsg:completeMessage];
//                }
//            } else {
//                break;
//            }
//        }
    }
}


- (void)sendMsg:(NSData *)msg{
    if(msg.length <= 0) return;
    const void *buff = [msg bytes];
    ///ssize_t     write(int __fd, const void * __buf, size_t __nbyte)
    ///参数一：socket标志符
    ///参数二：缓冲区
    ///参数三：缓冲区大小
    ssize_t sizeLen = write(self.clientId, buff, strlen(buff));
   
}


// 检查缓冲区中是否有完整的消息
//- (BOOL)hasCompleteMessageInBuffer {
//    // 读取 Varint 编码的长度前缀
//        UInt32 length = 0;
//        NSUInteger shift = 0;
//        for (int i = 0; i < _buffer.length; ++i) {
//            UInt8 byte = [_buffer bytes][i];
//            length |= ((UInt32)(byte & 0x7F) << shift);
//            if ((byte & 0x80) == 0) {
//                break;
//            }
//            shift += 7;
//        }
//        
//        // 检查缓冲区中是否有足够的数据来构成一个完整的消息
//        return _buffer.length - (shift / 7 + 1) >= length;
//}
//// 从缓冲区中提取完整的消息
//- (NSData *)extractCompleteMessageFromBuffer {
//    // 实现提取逻辑
//    // 例如，根据 Protobuf 的 Varint 长度前缀提取消息
//    NSData *message = _buffer; // 假设整个缓冲区是一个完整的消息
//    [_buffer setLength:0]; // 清空缓冲区
//    return message;
//}
@end

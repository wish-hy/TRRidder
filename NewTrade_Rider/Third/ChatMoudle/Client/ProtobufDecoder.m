//
//  ProtobufDecoder.m
//  NewTrade_Rider
//
//  Created by xzy on 2024/12/13.
//

// ProtobufDecoder.m
#import "ProtobufDecoder.h"

@implementation ProtobufDecoder

- (BOOL)hasCompleteMessageInBuffer:(NSData *)buffer {
    if (buffer.length == 0) return NO;
    
    NSUInteger cursor = 0;
    UInt32 length = 0;
    NSInteger shift = 0;
    
    // 读取 Varint 长度前缀
    while (cursor < buffer.length) {
        UInt8 byte = ((UInt8 *)buffer.bytes)[cursor];
        length |= ((UInt32)(byte & 0x7F) << shift);
        cursor++;
        if ((byte & 0x80) == 0) {
            break; // 找到了 Varint 的最后一个字节
        }
        shift += 7;
        
        // 如果 shift 超过 28，说明 Varint 编码有误，因为 Varint 最长占用5个字节
        if (shift >= 28) {
            return NO;
        }
    }
    
    // 检查缓冲区是否包含完整的消息
    return cursor + length <= buffer.length;
}



- (NSData *)extractCompleteMessageFromBuffer:(NSMutableData *)buffer {
    if (![self hasCompleteMessageInBuffer:buffer]) {
        return nil;
    }
    
    // 从缓冲区中提取消息
    // 这里需要实现提取逻辑，例如根据 Protobuf 的 Varint 长度前缀提取消息
    // 假设我们已经知道消息的长度，并且它存储在 `length` 变量中
    UInt32 length = 0;
    NSUInteger shift = 0;
    const uint8_t *bytes = buffer.bytes;
    for (int i = 0; i < buffer.length; ++i) {
        UInt8 byte = bytes[i];
        length |= ((UInt32)(byte & 0x7F) << shift);
        if ((byte & 0x80) == 0) {
            break;
        }
        shift += 7;
    }
    
    NSRange range = NSMakeRange(shift / 7 + 1, length);
    NSData *message = [buffer subdataWithRange:range];
    [buffer replaceBytesInRange:range withBytes:NULL length:0];
    
    return message;
}

@end


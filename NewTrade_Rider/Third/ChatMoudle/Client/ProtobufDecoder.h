//
//  ProtobufDecoder.h
//  NewTrade_Rider
//
//  Created by xzy on 2024/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProtobufDecoder : NSObject
- (BOOL)hasCompleteMessageInBuffer:(NSData *)buffer;
- (NSData *)extractCompleteMessageFromBuffer:(NSMutableData *)buffer;
@end

NS_ASSUME_NONNULL_END

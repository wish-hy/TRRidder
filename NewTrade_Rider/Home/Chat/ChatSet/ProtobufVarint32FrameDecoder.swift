//
//  SwiftProtobuf.swift
//  NewTrade_Rider
//
//  Created by xzy on 2024/12/13.
//

import Foundation

public class ProtobufVarint32FrameDecoder:NSObject {
    private var buffer = Data()
    private let delegate: ReceiveDelegate?

    init(delegate: ReceiveDelegate?) {
        self.delegate = delegate
    }

    func decode(data: Data) -> Data? {
        buffer.append(data)
        
        while buffer.count > 0 {
            guard let messageLength = readMessageLength(from: buffer) else {
                // 不完整的长度前缀，等待更多数据
                return nil
            }
            
            guard buffer.count >= messageLength else {
                // 不完整的消息，等待更多数据
                return nil
            }
            
            let messageData = buffer.subdata(in: 0..<messageLength)
            buffer.removeSubrange(0..<messageLength)
            
            // 通过代理返回解码后的消息
            delegate?.didReceive(message: messageData)
        }
        
        return nil
    }
    
    private func readMessageLength(from data: Data) -> Int? {
        var length: UInt32 = 0
        var shift = 0
        
        for i in 0..<data.count {
            let byte = data[i]
            length |= (UInt32(byte & 0x7F) << shift)
            shift += 7
            
            if (byte & 0x80) == 0 {
                return Int(length) + i + 1 - data.count
            }
        }
        
        return nil
    }
}

protocol ReceiveDelegate: AnyObject {
    func didReceive(message: Data)
}



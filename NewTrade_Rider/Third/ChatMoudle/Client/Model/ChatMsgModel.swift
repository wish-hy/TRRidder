//
//  ChatMsgModel.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/3/26.
//

import UIKit
import WCDBSwift
//消息模型 本地管理
enum MsgType : Int{
    case text = 0
    case image = 1
    case voice = 2
    case video = 3
    case file = 4
    case emotion = 5
    case link = 6
    case location = 7
    //不保存在数据库，做提示用，比如聊天日期展示
    case tip = -1
}
class ChatMsgModel: TRBaseModel,TableCodable {

    
    var receiveId : String = ""
    var msgID : String = ""
    var msgContent : String = ""
    var sendTime : Int64 = 0
    var type : Int = 1
    var sender : Int64 = 0
    var sessionID : String = ""
    //以下两个需要本地维护
    var sendInfo : ChatUserModel?
    
    var localFile : Data?
    enum CodingKeys: String, CodingTableKey {
         typealias Root = ChatMsgModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(msgID, isPrimary: true)
        }
        case msgID
         case msgContent
        case sendTime
        case type
        case sender
        case sessionID
     }

}

//
//  ChatSessionModel.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/3/18.
//

import UIKit
import WCDBSwift
//会话模型 本地管理
class ChatSessionModel: TRBaseModel, TableCodable {

    //社交ID
    var scUserId : String = ""
    var sessionId : String = ""
    var receiveName : String = ""
    var receiveId : String = ""
    var receivePicUrl : String = ""
    var receiveType : String = ""
    var lastMessage : String = ""
    var lastMessageTime : Int64 = 0
    var lastMessageType : Int = 1
    var unread : Int = 0
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ChatSessionModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(sessionId, isPrimary: true)
        }
        case scUserId
        case sessionId
        case receiveName
        case receivePicUrl
        case receiveType
        case lastMessage
        case lastMessageTime
        case lastMessageType
        case unread
        case receiveId
     }
}


//    func encode(with coder: NSCoder) {
//        coder.encode(id, forKey: "id")
//        coder.encode(name, forKey: "name")
//        coder.encode(lastMessage, forKey: "lastMessage")
//        coder.encode(lastMessageTime, forKey: "lastMessageTime")
//    }
//
//    required init?(coder: NSCoder) {
//        id = coder.decodeObject(forKey:"id") as! String
//        name = coder.decodeObject(forKey: "name") as! String
//        icon = coder.decodeObject(forKey: "icon") as! String
//
//        lastMessage = coder.decodeObject(forKey: "lastMessage") as! String
//        lastMessageTime = coder.decodeObject(forKey: "lastMessageTime") as! String
//
//    }

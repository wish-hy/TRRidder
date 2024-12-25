//
//  ChatGroupModel.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/4/1.
//

import UIKit
import WCDBSwift

class ChatGroupModel : TRBaseModel,TableCodable{
    var id : String = ""
    var scUserID : String = ""
    var groupID : String = ""
    var sessionID : String = ""
    var role : String = ""
    var remind_type : String = ""
    var nickName : String = ""
    var note : String = ""
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ChatGroupModel
//        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id
        case scUserID
        case groupID
        case role
        case remind_type
        case nickName
        case note

        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(id, isPrimary: true)
        }
     }
    
}

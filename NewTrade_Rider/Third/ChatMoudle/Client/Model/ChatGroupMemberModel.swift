//
//  ChatGroupMemberModel.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/4/1.
//

import UIKit
import WCDBSwift

//群成员信息 id 由用户ID和群ID组成
class ChatGroupMemberModel: TRBaseModel,TableCodable {
    var id : String = ""
    var scUserID : String = ""
    var groupID : String = ""
    var role : String = ""
    //提醒类型
    var remindType : String = ""
    //备注名
    var aliasName : String = ""
    //备注
    var note : String = ""
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ChatGroupMemberModel
//        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id
        case scUserID
        case groupID
        case role
        case remindType
        case aliasName
        case note

        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(id, isPrimary: true)
        }
     }
}

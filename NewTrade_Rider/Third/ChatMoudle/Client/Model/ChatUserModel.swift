//
//  ChatUserModel.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/3/29.
//

import UIKit
import WCDBSwift

class ChatUserModel: TRBaseModel, TableCodable {
    var id : String = ""
    var nickName : String = ""
    var pictureUrl : String = ""
    var updateTime : String = ""
    var roleName : String = ""
    //后端返回，不归档
    var hasChange : Bool = false
    var hasFollow : Bool = false
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ChatUserModel
//        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id
        case nickName
        case pictureUrl
        case updateTime
        case roleName
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(id, isPrimary: true)
        }
     }
    

}

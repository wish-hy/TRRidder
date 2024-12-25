//
//  TROrderReasonModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/3/12.
//

import UIKit

class TROrderReasonModel: TRBaseModel {
    var delForfeitTypeArr : String = "" // 关联处罚类型：DelForfeitTypeEnum,多个逗号分割
    var exceptionReason : String = "" // 异常原因
    var forfeitTypeName : String = "" // 处罚类型名称
    var hasCanCancel : Bool = false // 是否可以取消
    var hasMustCancel : Bool = false // 是否必选取消
    var id : String = ""
    var code : String = ""
}
class TROrderReasonManage: TRBaseModel {
    var data : [TROrderReasonModel] = []
    var code : Int = -1
}

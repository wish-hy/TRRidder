//
//  CommonFunctionsModel.swift
//  NewTrade_Rider
//
//  Created by xzy on 2024/11/25.
//

import Foundation
class CommonFunctionsModel: TRBaseModel {
    var evaluationCount : String = ""    //我的评价
    var historyOrderCount : String = ""    //历史订单
    var totalAmount : String = ""    //我的钱包元
    var violationAppealCount : String = ""    //违规申述
}
class CommonFunctionsManage: TRBaseModel {
    var code : Int = -1
    var data : CommonFunctionsModel = CommonFunctionsModel()
}

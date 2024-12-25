//
//  TRQuestionModel.swift
//  NewTrade_Seller
//
//  Created by xph on 2024/1/12.
//

import UIKit

class TRQuestionModel: TRBaseModel {
    var problem : String = ""
    var id : String = ""
    var updateTime : String = ""
    var answer : String = ""
}
class TRQuestionDetail: TRBaseModel {
    var data : TRQuestionModel = TRQuestionModel()
    var code : Int = -1
}
class TRQuestionList: TRBaseModel {
    var records : [TRQuestionModel] = []
}
class TRQuestionManage: TRBaseModel {
    var data : TRQuestionList = TRQuestionList()
    var code : Int = -1
}

//
//  TRTrafficeTypeModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/27.
//

import UIKit

class TRCommonTypeModel: TRBaseModel {
    var color : String = ""
    var createTime : String = ""
    var description : String = ""
    //上传值
    var dictKey : String = ""
    var dictValue : String = ""
    var dtCode : String = ""
    var enabled : String = ""
    var id : String = ""

    
    var code : String = ""
    var name : String = ""



}
class TRCommonTypeManage: TRBaseModel {
    var code : Int = -1
    var data : [TRCommonTypeModel] = []
}

//
//  TRTrafficModel.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRTrafficModel: TRBaseModel {
    //申请里面的模型
    var riderType : String = "机车骑手"
    var traffic : String = "小货车"
    var type  : String = "新能源"
    var imgs : [String] = [""]
    var owner : String = "王福慧"
    var code : String = "粤B·123456"
    var nextCheckTime : String = "2026-04-08"
    
    
    //设置里面的模型
    var id : String = ""
    var arId : String = ""
    var arName : String = ""
    var inspectionDate : String = ""
    var numberplate : String = ""
    var iconUrl : String = ""
    func clear(){
        riderType = ""
        traffic = ""
        type = ""
        imgs = []
        owner = ""
        owner = ""
        code = ""
        nextCheckTime = ""
    }
}

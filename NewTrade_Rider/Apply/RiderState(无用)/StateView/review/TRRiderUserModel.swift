//
//  TRRiderUserModel.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderUserModel: NSObject {
    // 骑手预览信息和提审信息模型 ，
    var no : String = "qs1234567890"
    var totalDay : String = "90"
    var totalOrder : String = "1316546456"
    var name : String = "王富贵"
    var sex : String = "男"
    var nation : String = "汉"
    var birth : String = "1989-08-07"
    var address : String = "广东省深圳市宝安区"
    var idCard : String = "44742419890807541X"
    var idCardDate : String = "2025-08-07"
    
    var trafficInfo : TRTrafficModel = TRTrafficModel()
    
    
    var workAddress = ""
    var phone = ""
    var code = ""
    var vihicleInfo = "" // 普通骑手 专送骑手
    
    var idCardImg_Front : UIImage?
    var idCardImg_Back : UIImage?
    var headImg : UIImage?
    func clear(){
        no = ""
        name = ""
        sex = ""
        nation = ""
        address = ""
        phone = ""
        code = ""
        address = ""
        idCard = ""
        idCardDate = ""
        birth = ""
        trafficInfo.clear()
    }
}

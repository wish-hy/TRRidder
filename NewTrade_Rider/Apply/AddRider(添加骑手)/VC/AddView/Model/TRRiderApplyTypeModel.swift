//
//  TRRiderApplyTypeModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/19.
//

import UIKit

class TRRiderVehicleTypeModel : TRBaseModel {
    var code : String = ""
    var energyType : String = ""
    var iconUrl : String = ""
    var id : String = ""
    var name : String = ""
    
}
class TRRiderApplyTypeModel: TRBaseModel {
    var serCode : String = ""
    var serCodeDesc : String = ""
    var vtList : [TRRiderVehicleTypeModel] = []
    
    //暂时是本地数据
    var name : String = ""
    var intro : String = ""
    var localImgName : String = ""
}
class TRRiderApplyTypeManage: TRBaseModel {
    var data : [TRRiderApplyTypeModel] = []
    var code : Int = -1
    
    func dealNetData(){
        
        for tm in data {
            if tm.serCode.elementsEqual("MALL") {
                tm.name = "商城配送"
                tm.intro = "嘉马商城订单"
                tm.localImgName = "rider_type_mall"
            } else if tm.serCode.elementsEqual("LOCAL_FAST_DEL") {
                tm.name = "同城跑腿"
                tm.intro = "同城跑腿订单"
                tm.localImgName = "rider_type_localCity"
            } else if tm.serCode.elementsEqual("LOCAL_DEL_GOODS") {
                tm.name = "同城送货"
                tm.intro = "同城送货订单"
                tm.localImgName = "rider_type_express"
            }
        }
    }
    
    //当没有车辆类型 生成本地的数据
     func createModels() {
         data.removeAll()
         
        let tm1 = TRRiderApplyTypeModel()
        tm1.name = "商城配送"
        tm1.intro = "嘉马商城订单"
        tm1.localImgName = "rider_type_mall"
        
        let tm2 = TRRiderApplyTypeModel()
        tm2.name = "同城跑腿"
        tm2.intro = "同城跑腿订单"
        tm2.localImgName = "rider_type_localCity"
        
        let tm3 = TRRiderApplyTypeModel()
        tm3.name = "同城送货"
        tm3.intro = "同城送货订单"
        tm3.localImgName = "rider_type_express"
        
         data.append(tm1)
         data.append(tm2)
         data.append(tm3)
    }
}

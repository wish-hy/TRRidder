//
//  TRRiderApplyRecordModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit

class TRRiderApplyRecordModel: TRBaseModel {
    var areaAddress : String = ""
    var authStatus : String = ""
    var authStatusDesc : String = ""
    var id : String = ""
    var time : String = ""
    var name : String = ""
    var profilePicUrl : String = ""
    var authOperator : String = ""
    var serviceCode : String = ""
    var serviceCodeDesc : String = "商城配送"
    var authContext : String = ""
    var authTime : String = ""
    var authVehicleInfo : String = ""
    var createTime : String = ""
    var phone : String = ""
    var numberplate : String = "----"
    var vehicleType : String = "--"
}
class TRRiderApplyRecordContainer: TRBaseModel {
    //列表接口
    var records : [TRRiderApplyRecordModel] = []
    
    //详情接口
    var data : TRRiderApplyRecordModel = TRRiderApplyRecordModel()
    var code = -1
}
class TRRiderApplyRecordManage: TRBaseModel {
    var code : Int = -1
    var data : TRRiderApplyRecordContainer = TRRiderApplyRecordContainer()
}

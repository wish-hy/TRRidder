//
//  TRRidderApplyVehicleSelModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/26.
//

import UIKit

class TRRidderApplyVehicleSelModel: TRBaseModel {
    var iconUrl : String = ""
    var id : String = ""
    var numberplate : String = ""
    var codeName : String = ""
    var arId : String = ""
    var arName : String = ""
    //是否可用 本地数据
    var isUseful : Bool = true
}
class TRRidderApplyVehicleSelContainer: TRBaseModel {
    var allowVehicleList : [TRRidderApplyVehicleSelModel] = []
    var notAllowVehicleList : [TRRidderApplyVehicleSelModel] = []

    //首页设置的
    var notAvailable : [TRRidderApplyVehicleSelModel] = []
    var available : [TRRidderApplyVehicleSelModel] = []
}
class TRRidderApplyVehicleSelManage: TRBaseModel {
    var code : Int = -1
    var data = TRRidderApplyVehicleSelContainer()
    
}
class TRRidderApplyVehicleMutilSelManage: TRBaseModel {
    var code : Int = -1
    var data : [TRRidderApplyVehicleSelContainer] = []
    
}

//
//  TRBeginSetModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/2/19.
//

import UIKit

class TRBeginSetModel: NSObject {
    var hasAppo : Bool = false
    var hasReal : Bool = false
    var appoBeginTime : String = ""
    var appoEndTime : String = ""
    //车辆信息
    var curVehicleId : String = ""
    var arId : String = ""
    var arName : String = ""
    var inspectionDate : String = ""
    var numberplate : String = ""
    var iconUrl : String = ""
}

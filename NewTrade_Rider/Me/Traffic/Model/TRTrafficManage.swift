//
//  TRTrafficManage.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/2/19.
//

import UIKit

class TRTrafficList: TRBaseModel {
    var records : [TRApplerVehicleInfoModel] = []
    var size : Int = 0

}
class TRTrafficManage: TRBaseModel {
    var data : TRTrafficList = TRTrafficList()
    var code : Int = -1
}
class TRTrafficContainer: TRBaseModel {
    var data : TRApplerVehicleInfoModel = TRApplerVehicleInfoModel()
    var code : Int = -1
}

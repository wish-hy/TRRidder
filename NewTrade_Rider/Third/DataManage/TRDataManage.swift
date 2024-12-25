//
//  TRDataManage.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/27.
//

import UIKit

class TRDataManage {
    static let shared = TRDataManage()
    //用户当前定位
    //是否进行中的订单
    var hasOrder : Bool = true
    var curCoordinate : CLLocationCoordinate2D?
    var curLongLat : String = ""
    var riderModel : TRApplerRiderInfoModel = TRApplerRiderInfoModel()
    var userModel : TRUserModel = TRUserModel()
    
    var applyModel : TRApplerRiderContainer = TRApplerRiderContainer()
    private init() {
    }

}

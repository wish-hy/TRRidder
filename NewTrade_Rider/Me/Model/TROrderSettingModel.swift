//
//  TROrderSettingModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/2/19.
//

import UIKit

class TROrderSettingModel: TRBaseModel {
    var alwaysAddress : String = ""
    var alwaysLatLong : String = ""
    var id : String = ""
    var localMinDelFee : String = "0"
    var mallMinDelFee : String = "0"
    var maxReceive : String = ""
    var delGoodsMinDelFee : String = "0"

}
class TROrderSettingManage: TRBaseModel {
    var code : Int = -1
    var data : TROrderSettingModel = TROrderSettingModel()
}

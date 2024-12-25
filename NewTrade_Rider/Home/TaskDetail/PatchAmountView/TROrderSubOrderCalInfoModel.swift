//
//  TROrderSubOrderCalInfoModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/5.
//

import UIKit

class TROrderSubOrderCalInfoModel: TRBaseModel {
    var dlgoId : String = ""
    var measureMethod : String = ""
    var patchAmount : String = ""
}
class TROrderSubOrderCalInfoManage: TRBaseModel {
    var code : Int = -1
    var data : TROrderSubOrderCalInfoModel = TROrderSubOrderCalInfoModel()
}

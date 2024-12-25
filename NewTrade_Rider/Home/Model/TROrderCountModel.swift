//
//  TROrderCountModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/10/12.
//

import UIKit

class TROrderCountModel: TRBaseModel {
    var deliveringCount : String = ""
    var takeCount : String = ""
    var waitingCount : String = ""
}
class TROrderCountManage : TRBaseModel {
    var data : TROrderCountModel = TROrderCountModel()
    var code : Int = -1
}

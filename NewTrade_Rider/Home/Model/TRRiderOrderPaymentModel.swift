//
//  TRRiderOrderPaymentModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/17.
//

import UIKit

class TRRiderOrderPaymentModel: TRBaseModel {
    var orderNo : String = ""
}
class TRRiderOrderPaymentManage: TRBaseModel {
    var code : Int = -1
    var data : TRRiderOrderPaymentModel = TRRiderOrderPaymentModel()
}

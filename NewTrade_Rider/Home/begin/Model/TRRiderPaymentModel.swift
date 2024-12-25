//
//  TRRiderPaymentModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/16.
//

import UIKit

class TRRiderPaymentModel: TRBaseModel {
    //0=正常开工,1=需要缴纳保证金,2=需要缴纳授信金额
    var payAmount : String = ""
    var protocolType : String = ""
    var receiveAmount : String = ""
    var status : Int = -1
    var vehicleType : String = ""
    var vehicleTypeDesc : String = ""
    var workStatus : String = ""
}
class TRRiderPaymentManage: TRBaseModel {
    var data : TRRiderPaymentModel = TRRiderPaymentModel()
    var code : Int = -1
}

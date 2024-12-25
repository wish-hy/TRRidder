//
//  TRRiderStaticsModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/5/31.
//

import UIKit

class TRRiderStaticsModel: TRBaseModel {
    var appealNumber : String = ""
    var avgDeliveryTime : String = ""
    var completeDeliveryTime : String = ""
    var completeOrderNumber : String = ""
    var customerSatisfactionScore : String = ""
    var deliveryOnTimeRate : String = ""
    var forfeitAmount : String = ""
    var inviteRewardAmount : String = ""
    var localDeliveryAmount : String = ""
    var mallDeliveryAmount : String = ""
    var memberTipAmount : String = ""
    var memberTipNumber : String = ""
    var onLineTime : String = ""
    var onTimeOrderNumber : String = ""
    var orderNumber : String = ""
    var realTimeNumber : String = ""

    var reservationNumber : String = ""
    var statisticsDate : String = ""
    var storeTipAmount : String = ""
    var storeTipNumber : String = ""
    var timeOutOrderNumber : String = ""
    var todayCompleteOrderNumber : String = ""
    var todayOrderNumber : String = ""
    var todayTotalActualIncome : Double = 0

    var todayTotalPreIncome : String = ""
    var totalActualIncome : Double = 0
    var totalDeliveryAmount : String = ""
    var totalDeliveryMileage : String = ""
    var totalInviteNumber : String = ""

    
    var userEvaluateNumber : String = ""
    var userEvaluateScore : String = ""


}
class TRRiderStaticsManage: TRBaseModel {

    var data : TRRiderStaticsModel = TRRiderStaticsModel()
    var code : Int = -1
}

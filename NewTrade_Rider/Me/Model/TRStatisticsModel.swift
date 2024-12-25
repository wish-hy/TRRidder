//
//  TRStatisticsModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/15.
//

import UIKit

class TRStatisticsModel: TRBaseModel {
    var memberTotalTipAmount : String = "0"
   var memberTotalTipNumber : String = "0"
   var storeTipAmount : String = "0"
   var storeTipNumber : String = "0"
   var todayCompleteOrderNumber : String = "0"
   var totalAppealNumber : String = "0"
   var totalCompleteOrderNumber : String = "0"
   var totalEvaluateNumber : String = "0"
   var totalExpectIncome : String = "0"
   var totalInviteNumber : String = "0"
   var totalInviteRewardAmount : String = "0"
   var totalOrderNumber : String = "0"
    //另外接口的
    var avaAmount : String = "0"
}
class TRStatisticsManage: TRBaseModel {
    var code : Int = -1
    var data : TRStatisticsModel = TRStatisticsModel()
}

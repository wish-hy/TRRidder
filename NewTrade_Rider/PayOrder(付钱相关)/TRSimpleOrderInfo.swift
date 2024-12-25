//
//  TRSimpleOrderInfo.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/17.
//

import UIKit


enum SimpleOrderType : Int {
    //商城订单
    case mall
    //打赏
    case tips
}
class TRSimpleOrderInfo: TRBaseModel {
    var orderNos : [String] = []
    var orderNo : String = ""
    var payTotalAmount : String = ""
    var result : Bool = false
    var payTimeOut : String = ""
    var timeout : String = ""
    var transactionNo : String = ""
    var payType : OrderPayType = .ALI_PAY
    
    
    var SimpleOrderType : SimpleOrderType = .mall
}
class TRSimpleOrderManage: TRBaseModel {
    var code : Int = -1
    var data : TRSimpleOrderInfo = TRSimpleOrderInfo()
}

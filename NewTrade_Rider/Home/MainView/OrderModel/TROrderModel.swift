//
//  TROrderModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/3/9.
//

import UIKit

//送货子订单
class TRDelSubOrder : TRBaseModel {
    var createTime : String = ""
    var dlgoId : String = ""
    var id : String = ""
    var measureMethod : String = ""
    var orderNo : String = ""
    var payAmount : String = ""
    var payStatus : String = ""
    var payTimeOut : String = ""

    
    var payTransactionNo : String = ""
    var subOrderNo : String = ""
    var subOrderType : String = ""
    var totalVolume : String = ""
    var totalWeight : String = ""
    var updateTime : String = ""
   
}

class TRItemModel : TRBaseModel {
    var createTime : String = ""
    var id : String = ""
    var productId : String = ""
    var productName : String = ""
    var ssId : String = ""
    var weight : Int = 0
    var num : Int = 0
    var price : String = "0"
    var originalPrice : String = ""
    var sellPrice : String = ""
    var productPicUrl : String = ""
    var transactionNo : String = ""
}

class TROrderModel: TRBaseModel {
    //送货
    var delGoodsMethod : String = ""
    var delGoodsMethodDesc : String = ""
    var goodInfoUrls : [String] = []
    var maxHeight : String = ""
    var maxLength : String = ""
    var totalCount : String = ""
    var packTypeName : String = ""
    //体积
    var totalVolume : String = ""
    var totalWeight : Double = 0.0
    var weight : Double = 0.0
    
    var createTime : String = ""
    var deliverAmount : String = ""
    
    /*
     0:可以补差价
     1:不可以补差价
     2:补差价待支付

     */
    var subType : Int = 0
    // MALL/
    var deliveryType : String = ""  // MALL=商城，LOCAL=同城,  LOCAL_DEL_GOODS 同城送货。 LOCAL_FAST_DEL 同城跑腿
    var estimateBeginTime : String = ""
    var estimateEndTime : String = ""
    var status : String = "" //配送状态：NEW=新订单,WAITING_TAKE=待取货,DELIVERY=配送中,ARRIVE=送达,CANCEL=已取消,可用值:PAYING,NEW,WAITING_TAKE,DELIVERING,ARRIVE,CANCEL
    
    var estimateTime : String = ""
    
    var pickUpEndTime = ""
    var pickUpStartTime = ""
    
    var currentDayReceiveOrderNum : String = ""
    var orderNo : String = ""
    var transactionNo : String = ""
    var ptName : String = ""
    var receiverAddress : String = ""
    var receiverAreaAddress : String = ""
    var senderAddress : String = ""
    var hasCode : Bool = false //是否开启收货码
    var hasInvoice : Bool = false // 是否开票
    var senderAreaAddress : String = ""
    
    var memberDistance : String = ""
    var storeDistance : String = ""
    var deliveryDistance : String = ""

    var timelinessType : String = ""  // ESERVE=预约单，NORMAL=实时单,可用
    var storeName : String = ""
    //详情补充
    var receiverLongLat : String = ""
    var receiverName : String = ""
    var receiverPhone : String = ""
    /*
     scMemberUserId=1792752298120704002
     .... scStoreUserId=1782744963545559041
     */
    var subOrder : TRDelSubOrder = TRDelSubOrder()
    var scMemberUserId : Int64 = 0
    var scStoreUserId : Int64 = 0
    var remark : String = ""
    //同城会用这个字段
    var senderRemark : String = ""
    var payAmount : String = ""
    var senderLongLat : String = ""
    var senderName : String = ""
    var senderPhone : String = ""
    var orderItemList : [TRItemModel] = []

    var payType : String = "线上支付"
    //骑手类型
    var riderTypeDesc : String = "普通"
    var insureAmount : String = "0"
    var memberTipAmount : String = "0"
    
    
    func dealRemark(){
        if remark.isEmpty {
            remark = senderRemark
        }
    }
}
class TROrderContainer : TRBaseModel {
    var code : Int = -1
    var data : TROrderModel = TROrderModel()
}
class TROrderList: TRBaseModel {
    var records : [TROrderModel] = []
}
class TROrderManage: TRBaseModel {
    var code : Int = -1
    var data : TROrderList = TROrderList()
}

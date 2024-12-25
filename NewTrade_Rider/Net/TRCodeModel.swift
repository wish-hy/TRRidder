//
//  TRCodeModel.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/19.
//

import UIKit
import HandyJSON
// 只返回code 和 data 的接口
class TRCodeModel: TRBaseModel {
    var data : Any?
    var code : Int = -1

}
class TRBoolModel: TRBaseModel {
    var data : Bool = false
    var code : Int = -1

}

class TRPicModel: TRBaseModel {
    var data : [String] = []
    var code : Int = -1

}

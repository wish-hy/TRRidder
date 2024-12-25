//
//  TRAddressModel.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/12.
//

import UIKit
class TRAddressModel : TRBaseModel {
    var name : String = ""
    var level : String = ""
    var id : String = ""
    var parentId : String = ""
    var code : String = ""
    var hasOpened : Bool = false
    var townAddress : String = ""
}

class TRAddressManage: TRBaseModel {
    var data : [TRAddressModel] = []
    var code : Int = -1
}

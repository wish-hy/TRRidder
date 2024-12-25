//
//  TRADModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/29.
//

import UIKit

class TRADModel: TRBaseModel {
    var updateTime : String = ""
    var title : String = ""
    var id : String = ""
    var content : String = ""
    var pictureUrl : String = ""
    
    var author : String = ""

    var readCount : String = ""
    var createTime : String = ""

}
class TRADList: TRBaseModel {
    var records : [TRADModel] = []
}
class TRADManage: TRBaseModel {
    var code : Int = -1
    var data = TRADList()
}

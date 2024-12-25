//
//  TRNationModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/29.
//

import UIKit

class TRNationModel: TRBaseModel {
    var dictKey : String = ""
    var dictValue : String = ""
    var sequence : Int = 0
}
class TRNationManage: TRBaseModel {
    var code : Int = -1
    var data : [TRNationModel] = []
}

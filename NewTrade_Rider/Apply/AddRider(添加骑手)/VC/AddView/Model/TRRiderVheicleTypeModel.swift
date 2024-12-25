//
//  TRRiderVheicleTypeModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/22.
//

import UIKit

class TRRiderVheicleTypeModel: TRBaseModel {
    var energyType : String = ""
    var energyTypeDesc : String = ""
    var iconUrl : String = ""
    var id : String = ""
    var name = ""
    var code : String = ""
    var hasLicense : Bool = false
    var hasCertificate : Bool = false
}
class TRRiderVheicleTypeContainer : TRBaseModel {
    var energyType : String = ""
    var energyTypeDesc : String = ""
    
    
    var serCode : String = ""
    var serCodeDesc : String = ""
    var vtList : [TRRiderVheicleTypeModel] = []
    
}
class TRRiderVheicleTypeManage: TRBaseModel {
    var code : Int = -1
    var data : [TRRiderVheicleTypeContainer] = []
}

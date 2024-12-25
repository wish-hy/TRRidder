//
//  TRRidderApplyTypeItemModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/18.
//

import UIKit

class TRRidderApplyTypeItemModel: NSObject {
    var name : String = ""
    var intro : String = ""
    var imgName : String = ""
    
    var isSel : Bool = false
    init(name: String, intro: String, imgName: String) {
        self.name = name
        self.intro = intro
        self.imgName = imgName
    }
    
    
    static func createRiderType()->[TRRidderApplyTypeItemModel] {
        let mallModel = TRRidderApplyTypeItemModel(name: "商城配送", intro: "嘉马商城订单", imgName: "rider_type_mall")
        
        let localCity_qModel = TRRidderApplyTypeItemModel(name: "同城快货", intro: "同城配送订单", imgName: "rider_type_localCity")

        let localCityModel = TRRidderApplyTypeItemModel(name: "同城送货", intro: "同城送货订单", imgName: "rider_type_express")
        
            return [mallModel, localCity_qModel, localCityModel]
       
    }
}

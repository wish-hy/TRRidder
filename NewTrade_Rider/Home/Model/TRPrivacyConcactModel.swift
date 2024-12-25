//
//  TRPrivacyConcactModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/9/27.
//

import UIKit

class TRPrivacyConcactModel: TRBaseModel {
    var amrName : String = ""
    var phoneNo : String = ""
}
class TRPrivacyConcactManage: TRBaseModel {
    var data : TRPrivacyConcactModel = TRPrivacyConcactModel()
    var code : Int = -1
}

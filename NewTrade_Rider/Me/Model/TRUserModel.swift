//
//  TRUserModel.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/1/4.
//

import UIKit

class TRUserModel: TRBaseModel {
    var accountId : String = ""
    var id : String = ""
    var ipBelong : String = ""
    var likeNumber : Int64 = 0
    var fansNumber : Int64 = 0
    var followNumber : Int64 = 0
    var collectNumber : Int64 = 0
    var description : String = ""
    var nickName : String = ""
    var userId : String = ""
    var name : String = ""
    var sex : Bool = false
    var headerPic : String = ""
    var profilePic : String = ""
    var areaAddress : String = ""
    var address : String = ""
    var phone : String = ""
    var pictureUrl : String = ""
    var netLoclImgModel : NetLocImageModel = NetLocImageModel()
    var hasFollow : Bool = false
    //个人信息
    var detailAddress : String = ""
    var residentialAddress : String = ""
    
    //当前车辆信息
    //车辆信息名字
    var codeName : String = ""
    var appoBeginTime : String = ""
    var appoEndTime : String = ""
    var hasAppo : Bool = false
    var hasReal : Bool = false
    
    
    var curVehicleId : String = ""
    var arId : String = ""
    var arName : String = ""
    var inspectionDate : String = ""
    var numberplate : String = ""
    var iconUrl : String = ""
    
    //社交信息
    var scUserId : String = ""
    var scPictureUrl : String = ""
    var imToken : String = ""
    func dealNetData(){
        netLoclImgModel.netURL = profilePic
        netLoclImgModel.netName = headerPic
    }
    
    func getRealName()->String{
        if !nickName.isEmpty {return nickName}
        if !name.isEmpty {return name}
        return ""
    }
    func getRealHeadUrl()->String{
        if !profilePic.isEmpty {return profilePic}
        if !pictureUrl.isEmpty {return pictureUrl}
        return ""
    }
}
class TRUserManage: TRBaseModel {
    var code : Int = -1
    var data : TRUserModel = TRUserModel()
}
class TRUserContainer : TRBaseModel {
    var records : [TRUserModel] = []
}
class TRUserList : TRBaseModel {
    var code : Int = -1
    var data : TRUserContainer = TRUserContainer()
}

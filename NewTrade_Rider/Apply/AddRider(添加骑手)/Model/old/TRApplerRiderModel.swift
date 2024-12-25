//
//  TRApplyRiderModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/25.
//

import UIKit
/*
    旧版本的申请模型
 
 */
class TRApplerRiderInfoModel: TRBaseModel {
    // 1
    var codeProvince : String = ""
    var codeCity : String = ""
    var codeDistrict : String = ""
    var codeTown : String = ""
    var areaAddress : String = ""
    var townAddress : String = ""
    var serviceCode : String = "MALL"
    var name : String = ""

    //不用了
    var serviceCodes : [String] = []
    var riderType : String = ""
    
    var profilePic : String = ""
    
    var profilePicUrl : String = ""
    
    var curAuthStatus : String = ""
    var id : String = ""
    
    var appoBeginTime : String = ""
    var appoEndTime : String = ""
    var hasAppo : Bool = false
    var hasReal : Bool = false
    //当前车辆信息
    var codeName : String = ""
    var curVehicleId : String = ""
    var arId : String = ""
    var arName : String = ""
    var inspectionDate : String = ""
    var numberplate : String = ""
    var iconUrl : String = ""
    //SIDEWALK,DRIVEWAY 导航方式 从申请信息里的车辆信息中获取的
    var pathType : String = ""
    //审核信息
    var authContext : String = ""
    
    var trainingResult : String = ""
    var headerPicNetModel : NetLocImageModel = NetLocImageModel()
    func dealNetModel(){
    
        if riderType.isEmpty {
            riderType = "GENERAL"
        }
        if serviceCode.isEmpty {
            serviceCode = "MALL"
        }
//        if serviceCodes.isEmpty {
//            serviceCode = "MALL"
//        } else if serviceCodes.count == 1 {
//            let s = serviceCodes.first
//            if s!.elementsEqual("MALL") {
//                serviceCode = "MALL"
//            } else {
//                serviceCode = "LOCAL"
//            }
//        } else {
//            //多类型 还未定义
//            serviceCode = "MALL"
//        }
        
        headerPicNetModel.removeAll()
        headerPicNetModel.netURL = profilePicUrl
        headerPicNetModel.netName = profilePic
    }
}

class TRApplerUserInfoModel: TRBaseModel {
    //个人中心 修改证件信息需要的两个字段
    var realName : String = "--"
//    var idCardAddress : String = "--"
    
    
    //第2部
    var idCardBack : String = ""
    var idCardFront : String = ""
    var sex : Bool?
    var nation : String = ""
    var birthday : String = ""
    var idCard : String = ""
//    var idAreaAddress : String = ""
//    var idDetailsAddress : String = ""
    var idDetailsAddress : String = ""
    var validBeginTime : String = ""
    var validEndTime : String = ""
    var id : String = ""
    
    var idCardBackUrl : String = ""
    var idCardFrontUrl : String = ""
    var idCardBackNetModel : NetLocImageModel = NetLocImageModel()
    var idCardFrontNetModel : NetLocImageModel = NetLocImageModel()
    func dealNetModel(){
        idCardBackNetModel.removeAll()
        idCardFrontNetModel.removeAll()
        idCardBackNetModel.netURL = idCardBackUrl
        idCardBackNetModel.netName = idCardBack
        
        idCardFrontNetModel.netURL = idCardFrontUrl
        idCardFrontNetModel.netName = idCardFront
        
    }
}
class TRApplerVehicleInfoModel: TRBaseModel {
    //车辆列表及详情会有的
    var arName : String = ""
    var iconUrl : String = ""
    var  arId : String = ""
//申请车辆信息
    var code : String = ""
    var codeName : String = ""
    var energyType : String = ""
    var energyTypeDesc : String = ""
    var name : String = ""//车辆名字
    var drivingLicense : String = ""
    var registerCertificate : String = ""
    var frontPicture : String = ""
    var groupPicture : String = ""
    var sidePicture : String = ""
    var backPicture : String = ""
    var numberplate : String = ""
    var inspectionDate : String = ""
    //SIDEWALK,DRIVEWAY 导航方式
    var pathType : String = ""
    var owner : String = ""
    var id : String = ""
    var frontPictureUrl : String = ""
    var groupPictureUrl : String = ""
    var backPictureUrl : String = ""
    var sidePictureUrl : String = ""
    var registerCertificateUrl : String = ""
    var drivingLicenseUrl :String = ""
    
    
    var frontPictureNetModel : NetLocImageModel = NetLocImageModel()
    var groupPictureNetModel : NetLocImageModel = NetLocImageModel()
    var backPictureNetModel : NetLocImageModel = NetLocImageModel()
    var sidePictureNetModel : NetLocImageModel = NetLocImageModel()
    var registerCertificateNetModel : NetLocImageModel = NetLocImageModel()
    var drivingLicenseNetModel : NetLocImageModel = NetLocImageModel()
    
    //本地标记 根据车辆类型来确定
    /*
     hasCertificate 是否需要行驶证
     hasLicense 是否需要驾驶证
     */
    var hasLicense : Bool = false
    var hasCertificate : Bool = false
    
    func dealNetModel(){
        
        frontPictureNetModel.removeAll()
        groupPictureNetModel.removeAll()
        backPictureNetModel.removeAll()
        
        frontPictureNetModel.netURL = frontPictureUrl
        frontPictureNetModel.netName = frontPicture
        
        groupPictureNetModel.netURL = groupPictureUrl
        groupPictureNetModel.netName = groupPicture
        
        backPictureNetModel.netURL = backPictureUrl
        backPictureNetModel.netName = backPicture
        
        sidePictureNetModel.netURL = sidePictureUrl
        sidePictureNetModel.netName = sidePicture
        
        registerCertificateNetModel.netURL = registerCertificateUrl
        registerCertificateNetModel.netName = registerCertificate
        
        drivingLicenseNetModel.netName = drivingLicense
        drivingLicenseNetModel.netURL = drivingLicenseUrl
    }
}
class TRApplyAuthRecord : TRBaseModel {
    var arId : String = ""
    var authContext : String = ""
    var authOperator : String = ""
    var authStatus : String = ""
    var createTime : String = ""
    var id : String = ""

}

class TRApplerRiderContainer: TRBaseModel {
    var agentId : String = ""
    var agentName : String = ""
    var agentPhone : String = ""
    var appoBeginTime : String = ""
    var appoEndTime : String = ""
    var approveNum : String = ""
    var arId : String = ""
    var pathType : String = ""
    var areaAddress : String = ""
    var authRecord : TRApplyAuthRecord = TRApplyAuthRecord()
    
    var vehicleInfo : TRApplerVehicleInfoModel = TRApplerVehicleInfoModel()
    var userInfo : TRApplerUserInfoModel = TRApplerUserInfoModel()
    var riderInfo : TRApplerRiderInfoModel = TRApplerRiderInfoModel()
   
    var curAuthStatus : String = ""
    //当前工作状态
    var curWorkStatus : String = ""
    func dealNetModel(){
        vehicleInfo.dealNetModel()
        userInfo.dealNetModel()
        riderInfo.dealNetModel()
        //导航方式
        riderInfo.pathType = vehicleInfo.pathType
    }
    required init() {
            super.init()
            riderInfo.riderType = "GENERAL"
            riderInfo.serviceCode = "MALL"
    }
    
    func saveToLocalToAccount(account : String) {
       let jsonStr = self.toJSONString(prettyPrint: true)
        if jsonStr == nil {
            SVProgressHUD.showInfo(withStatus: "归档失败")
        }
//        let path =
//        jsonStr?.write(to: <#T##URL#>, atomically: true, encoding: .utf8)
        //保存数据
        userInfo.idCardBackNetModel.saveImgToLocal(filePath: account )
        
        userInfo.idCardFrontNetModel.saveImgToLocal(filePath: account )
        vehicleInfo.backPictureNetModel.saveImgToLocal(filePath: account )
        vehicleInfo.frontPictureNetModel.saveImgToLocal(filePath: account )
        vehicleInfo.sidePictureNetModel.saveImgToLocal(filePath: account)
        vehicleInfo.groupPictureNetModel.saveImgToLocal(filePath: account)
        
        vehicleInfo.drivingLicenseNetModel.saveImgToLocal(filePath: account)
        vehicleInfo.registerCertificateNetModel.saveImgToLocal(filePath: account)
        
        riderInfo.headerPicNetModel.saveImgToLocal(filePath: account)
        
        TRFileManage.share.save_string_to_path(source: jsonStr!, path: account,fileName: "applyInfo")
        
        
        //保存图片
        
    }
    static func readFromLocalToAccount(account : String)->TRApplerRiderContainer?{
        let str = TRFileManage.share.read_string_from_path(path: "\(account)/applyInfo")
      
        let model = TRApplerRiderContainer.deserialize(from: str)
        guard let model = model else { return model }
        //添加站位图片
        model.userInfo.idCardBackNetModel.spadImgToLocal()
        model.userInfo.idCardFrontNetModel.spadImgToLocal()

        model.vehicleInfo.backPictureNetModel.spadImgToLocal()
        model.vehicleInfo.frontPictureNetModel.spadImgToLocal()
        model.vehicleInfo.sidePictureNetModel.spadImgToLocal()
        model.vehicleInfo.groupPictureNetModel.spadImgToLocal()
        
        model.vehicleInfo.drivingLicenseNetModel.spadImgToLocal()
        model.vehicleInfo.registerCertificateNetModel.spadImgToLocal()

        model.riderInfo.headerPicNetModel.spadImgToLocal()
        //回复图片
        model.userInfo.idCardBackNetModel.readImgFromLocal(filePath: account)
        model.userInfo.idCardFrontNetModel.readImgFromLocal(filePath: account)

        model.vehicleInfo.backPictureNetModel.readImgFromLocal(filePath: account)
        model.vehicleInfo.frontPictureNetModel.readImgFromLocal(filePath: account)
        model.vehicleInfo.sidePictureNetModel.readImgFromLocal(filePath: account)
        model.vehicleInfo.groupPictureNetModel.readImgFromLocal(filePath: account)
        
        model.vehicleInfo.drivingLicenseNetModel.readImgFromLocal(filePath: account)
        model.vehicleInfo.registerCertificateNetModel.readImgFromLocal(filePath: account)

        model.riderInfo.headerPicNetModel.readImgFromLocal(filePath: account)
        
        
        return model
    }
    static func deleteLocal(){
        let  account = TRTool.getData(key: "phone") as! String
        TRFileManage.share.delete_dir(dir: "\(account)/applyInfo")
    }
    static func existLocalInfo()->Bool {
        let  account = TRTool.getData(key: "phone") as! String
        if TRFileManage.share.existFileOrDir(path: "\(account)/applyInfo"){
            return true
        }
        return false
    }
}
class TRApplerRiderManange: TRBaseModel {
    var data : TRApplerRiderContainer = TRApplerRiderContainer()
    var code : Int = -1
}

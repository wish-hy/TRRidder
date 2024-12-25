//
//  TRRidderApplyInfoModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/18.
//

import UIKit

class TRRidderApplyInfoManage : TRBaseModel {
    var code : Int = -1
    var data : TRRidderApplyInfoModel = TRRidderApplyInfoModel()
}

class TRRidderApplyInfoModel: TRBaseModel {
    
    var address : String = ""
    var areaAddress : String = ""
    var authVehicleId : String = ""
    var birthday : String = ""
    var codeCity : String = ""
    var codeDistrict : String = ""
    var codeProvince : String = ""
    var codeTown : String = ""
    var idCard : String = ""
    var idCardBack : String = ""
    var idCardFront : String = ""
    var idDetailsAddress : String = ""
    var name : String = ""
    var nation : String = ""
    var phone : String = ""
    var profilePic : String = ""
    var serviceCode : String = ""
    var sex : Bool = false
    var validBeginTime : String = ""
    var validEndTime : String = ""

    var idCardBackUrl : String = ""
    var idCardFrontUrl : String = ""
    var idCardBackNetModel : NetLocImageModel = NetLocImageModel()
    var idCardFrontNetModel : NetLocImageModel = NetLocImageModel()
    var vehicleInfo : TRRidderApplyInfoVehicleModel = TRRidderApplyInfoVehicleModel()

    //暂无
    var curAuthStatus : String = ""
    func dealNetModel(){
        idCardBackNetModel.removeAll()
        idCardFrontNetModel.removeAll()
        idCardBackNetModel.netURL = idCardBackUrl
        idCardBackNetModel.netName = idCardBack
        idCardFrontNetModel.netURL = idCardFrontUrl
        idCardFrontNetModel.netName = idCardFront
    }
  
    
    //归档相关(模型和图片分开归档),删除由外界模型管理
    func saveToLocal(){
       let jsonStr = self.toJSONString(prettyPrint: true)
        if jsonStr == nil {
            SVProgressHUD.showInfo(withStatus: "归档失败")
        }
//        let path =
//        jsonStr?.write(to: <#T##URL#>, atomically: true, encoding: .utf8)
        //保存数据
        idCardBackNetModel.saveImgToLocal(filePath: "RIDER_APPLY")
        idCardFrontNetModel.saveImgToLocal(filePath: "RIDER_APPLY")
        vehicleInfo.backPictureNetModel.saveImgToLocal(filePath: "RIDER_APPLY")
        vehicleInfo.frontPictureNetModel.saveImgToLocal(filePath: "RIDER_APPLY")
        vehicleInfo.sidePictureNetModel.saveImgToLocal(filePath: "RIDER_APPLY")
        vehicleInfo.groupPictureNetModel.saveImgToLocal(filePath: "RIDER_APPLY")
        
        vehicleInfo.drivingLicenseNetModel.saveImgToLocal(filePath: "RIDER_APPLY")
        vehicleInfo.registerCertificateNetModel.saveImgToLocal(filePath: "RIDER_APPLY")
        
        
        TRFileManage.share.save_string_to_path(source: jsonStr!, path: "RIDER_APPLY",fileName: "applyInfo")
        
        
        //保存图片
        
    }
    func readFromLocal()->TRRidderApplyInfoModel?{
        let str = TRFileManage.share.read_string_from_path(path: "RIDER_APPLY/applyInfo")

        let model = TRRidderApplyInfoModel.deserialize(from: str)
        guard let model = model else { return model }
        
//未恢复图片
        
        return model
    }
    
}
class TRRidderApplyInfoVehicleModel: TRBaseModel {
    var frontPicture : String = ""
    var backPicture : String = ""
    var code : String = ""
    var drivingLicense : String = ""
    var groupPicture : String = ""
    var icon : String = ""
    var inspectionDate : String = ""
    var numberplate : String = ""
    var owner : String = ""
    var registerCertificate : String = ""
    var sidePicture : String = ""
    
    var frontPictureUrl : String = ""
    var backPictureUrl : String = ""
    var drivingLicenseUrl : String = ""
    var groupPictureUrl : String = ""
    var registerCertificateUrl : String = ""
    var sidePictureUrl : String = ""
    
    var frontPictureNetModel : NetLocImageModel = NetLocImageModel()
    var groupPictureNetModel : NetLocImageModel = NetLocImageModel()
    var backPictureNetModel : NetLocImageModel = NetLocImageModel()
    var sidePictureNetModel : NetLocImageModel = NetLocImageModel()
    var registerCertificateNetModel : NetLocImageModel = NetLocImageModel()
    var drivingLicenseNetModel : NetLocImageModel = NetLocImageModel()

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

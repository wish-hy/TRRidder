//
//  TRAddRiderVViewController.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit
import RxSwift
import RxCocoa
class TRAddRiderVViewController: BasicViewController, UIScrollViewDelegate  {
    let headerH = 288.0
    let offsetY = 80.0 + (IS_IphoneX ? 0.0 : 44.0)
    var backBtn : UIButton!
    
    
    var scrollView : UIScrollView!
    
    var accountView : TRAddRiderAccountInfoView!
    var licenseView : TRAddRiderLicenseInfoView!
    var vihicleView : TRAddRiderVihicleView!
    var currentView : UIView?
    var model = TRApplerRiderContainer()

    private var step : Int = 1
    var bottom1View : TRBottomButton1View!
    var bottom2View : TRBottomButton2View!
    var bottom3View : TRBottomButton2View!
    
    let bag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        toFirst()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configAccountView()
        configTopView()
        currentView = accountView
        if !model.riderInfo.curAuthStatus.isEmpty {
            let vc = TRRiderApplyStateViewController()
            vc.model = model
            let navVC = BasicNavViewController(rootViewController: vc)
            self.navigationController?.pushViewController(vc , animated: false)
        }
        if model.vehicleInfo.id.isEmpty {
            if TRApplerRiderContainer.existLocalInfo() {
                let account = TRTool.getData(key: "phone") as! String
                var readModel :TRApplerRiderContainer!
                if !TRTool.isNullOrEmplty(s: account) {
                    readModel = TRApplerRiderContainer.readFromLocalToAccount(account: account)
                }
                if readModel != nil{
                    let alertView = TRAlertView(frame: .zero)
                    alertView.titleLab.text = "是否恢复上次编辑内容"
                    alertView.cancelBtn.setTitle("取消", for: .normal)
                    alertView.sureBtn.setTitle("确认", for: .normal)
                    alertView.cancelBlock = { _ in
                        TRApplerRiderContainer.deleteLocal()
                    }
                    alertView.block = { _ in
                        SVProgressHUD.show()
                        DispatchQueue.global().async {[self] in
                            DispatchQueue.main.async {
                                SVProgressHUD.dismiss()
                                self.model = readModel!
                                if self.accountView != nil {
                                    self.accountView.model = readModel
                                }
                                if self.vihicleView != nil {
                                    self.vihicleView.model = readModel
                                }
                                if self.licenseView != nil {
                                    self.licenseView.model = readModel
                                }
                            }
                        }
                        }
                    alertView.addToWindow()
                }else{
                    return;
                }
            }
        }
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.configLicenseView()
                self.configVihicleView()
                self.view.bringSubviewToFront(self.navBar!)
                self.licenseView.isHidden = true
                self.vihicleView.isHidden = true
                
                self.bottom2View.isHidden = true
                self.bottom3View.isHidden = true
                
                self.accountView.block = {[weak self](y) in
                    guard let self = self else { return  }
                    if currentView == accountView {
                        if y >= StatusBar_Height {
                            self.configBarTheme(isLight: false)
                        } else {
                            self.configBarTheme(isLight: true)
                        }
                    }
                }
                
                self.licenseView.block = {[weak self](y) in
                    guard let self = self else { return  }
                    if currentView == licenseView {
                        if y >= StatusBar_Height {
                            self.configBarTheme(isLight: false)
                        } else {
                            self.configBarTheme(isLight: true)
                        }
                    }
                }
                
                self.vihicleView.block = {[weak self](y) in
                    guard let self = self else { return  }
                    if currentView == vihicleView {
                        if y >= StatusBar_Height {
                            self.configBarTheme(isLight: false)
                        } else {
                            self.configBarTheme(isLight: true)
                        }
                    }
                }
        }
    }
        
        
    }
    private func toSecond(){
        if self.accountView == nil || self.licenseView == nil || self.vihicleView == nil {
            return
        }
        step = 2
        self.accountView.isHidden = true
        self.licenseView.isHidden = false
        self.vihicleView.isHidden = true
        
        self.bottom1View.isHidden = true
        self.bottom2View.isHidden = false
        self.bottom3View.isHidden = true
        
        currentView = licenseView
    
        if licenseView.tableView.contentOffset.y >= StatusBar_Height {
            self.configBarTheme(isLight: false)
        } else {
            self.configBarTheme(isLight: true)
        }
    }
    func toFirst(){
        if self.accountView == nil || self.licenseView == nil || self.vihicleView == nil {
            return
        }
        step = 1
        self.accountView.isHidden = false
        self.licenseView.isHidden = true
        self.vihicleView.isHidden = true
        
        self.bottom1View.isHidden = false
        self.bottom2View.isHidden = true
        self.bottom3View.isHidden = true
        currentView = accountView
        if accountView.tableView.contentOffset.y >= StatusBar_Height {
            self.configBarTheme(isLight: false)
        } else {
            self.configBarTheme(isLight: true)
        }
    }
    private func toThird(){
        step = 3
        self.accountView.isHidden = true
        self.licenseView.isHidden = true
        self.vihicleView.isHidden = false
        self.vihicleView.selIndex = self.accountView.selIndex
        
        self.bottom1View.isHidden = true
        self.bottom2View.isHidden = true
        self.bottom3View.isHidden = false
        //需要请求车辆类型
        self.vihicleView.getTrafficType()
        currentView = vihicleView
        if vihicleView.tableView.contentOffset.y >= StatusBar_Height {
            self.configBarTheme(isLight: false)
        } else {
            self.configBarTheme(isLight: true)
        }
    }
    private func commitInfo(){
        var num = model.vehicleInfo.numberplate
        if model.vehicleInfo.numberplate.contains("·") {
            num = num.replacingOccurrences(of: "·", with: "")
        }
//        var userInfo = [
//           
//        ] as [String : Any]
        
        let vehicleInfo = [
            "id" : model.vehicleInfo.id,
            "energyType" : model.vehicleInfo.energyType,
            "code":model.vehicleInfo.code,
            "drivingLicense":model.vehicleInfo.drivingLicenseNetModel.netNameArr.last ?? "",
            "registerCertificate":model.vehicleInfo.registerCertificateNetModel.netNameArr.last ?? "",
            "frontPicture":model.vehicleInfo.frontPictureNetModel.netNameArr.last ?? "",
            "groupPicture":model.vehicleInfo.groupPictureNetModel.netNameArr.last ?? "",
            "sidePicture":model.vehicleInfo.sidePictureNetModel.netNameArr.last ?? "",
            "backPicture": model.vehicleInfo.backPictureNetModel.netNameArr.last ?? "",
            "numberplate":num,
            "owner" : model.vehicleInfo.owner,

            "inspectionDate":model.vehicleInfo.inspectionDate
        ] as [String : Any]
        
//        let riderInfo = [
//           
//        ]
    
        let pars = [
            "idCardBack":model.userInfo.idCardBackNetModel.netNameArr.last ?? "",
            "idCardFront":model.userInfo.idCardFrontNetModel.netNameArr.last ?? "",
            "name":model.riderInfo.name,
            "sex":model.userInfo.sex!,
            "nation":model.userInfo.nation,
            "birthday":model.userInfo.birthday,
            "idDetailsAddress":model.userInfo.idDetailsAddress,
            "idCard":model.userInfo.idCard,
            "validBeginTime":model.userInfo.validBeginTime,
            "validEndTime":model.userInfo.validEndTime,
            "codeProvince":model.riderInfo.codeProvince,
            "codeCity":model.riderInfo.codeCity,
            "codeDistrict":model.riderInfo.codeDistrict,
            "codeTown":model.riderInfo.codeTown,
            "areaAddress":model.riderInfo.areaAddress,
            "townAddress" : model.riderInfo.townAddress,
            "serviceCode":model.riderInfo.serviceCode,
            "profilePic":model.riderInfo.headerPicNetModel.getName(),
            
            "vehicleInfo" : vehicleInfo
        ] as [String : Any]
        SVProgressHUD.show()
        TRNetManager.shared.post_no_lodding(url: URL_Rider_Apply_Add, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                DispatchQueue.global().async {
                    TRApplerRiderContainer.deleteLocal()
                }
                model.riderInfo.curAuthStatus = "UNAUDITED"
                let vc = TRRiderApplyStateViewController()
                vc.model = model
                 vc.hidesBottomBarWhenPushed = true
                 self.navigationController?.pushViewController(vc , animated: true)
            } else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
            }
        }
        
    }
    private func updateInfo(){
        var num = model.vehicleInfo.numberplate
        if model.vehicleInfo.numberplate.contains("·") {
            num = num.replacingOccurrences(of: "·", with: "")
        }
      
        let vehicleInfo = [
            "id" : model.vehicleInfo.id,
            "energyType" : model.vehicleInfo.energyType,
            "code":model.vehicleInfo.code,
            "drivingLicense":model.vehicleInfo.drivingLicenseNetModel.netNameArr.last ?? "",
            "registerCertificate":model.vehicleInfo.registerCertificateNetModel.netNameArr.last ?? "",
            "frontPicture":model.vehicleInfo.frontPictureNetModel.netNameArr.last ?? "",
            "groupPicture":model.vehicleInfo.groupPictureNetModel.netNameArr.last ?? "",
            "sidePicture":model.vehicleInfo.sidePictureNetModel.netNameArr.last ?? "",
            "backPicture": model.vehicleInfo.backPictureNetModel.netNameArr.last ?? "",
            "numberplate":num,
            "owner" : model.vehicleInfo.owner,

            "inspectionDate":model.vehicleInfo.inspectionDate
        ] as [String : Any]
        
//        let riderInfo = [
//
//        ]
        let pars = [
            "idCardBack":model.userInfo.idCardBackNetModel.netNameArr.last ?? "",
            "idCardFront":model.userInfo.idCardFrontNetModel.netNameArr.last ?? "",
            "name":model.riderInfo.name,
            "sex":model.userInfo.sex!,
            "nation":model.userInfo.nation,
            "birthday":model.userInfo.birthday,
            "idDetailsAddress":model.userInfo.idDetailsAddress,
            "idCard":model.userInfo.idCard,
            "validBeginTime":model.userInfo.validBeginTime,
            "validEndTime":model.userInfo.validEndTime,
            "codeProvince":model.riderInfo.codeProvince,
            "codeCity":model.riderInfo.codeCity,
            "codeDistrict":model.riderInfo.codeDistrict,
            "codeTown":model.riderInfo.codeTown,
            "areaAddress":model.riderInfo.areaAddress,
            "townAddress" : model.riderInfo.townAddress,
            "serviceCode":model.riderInfo.serviceCode,
            "profilePic":model.riderInfo.headerPicNetModel.getName(),
            
            "vehicleInfo" : vehicleInfo
        ] as [String : Any]
        SVProgressHUD.show()
        TRNetManager.shared.post_no_lodding(url: URL_Rider_Apply_Add, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                model.riderInfo.curAuthStatus = "UNAUDITED"
                let vc = TRRiderApplyStateViewController()
                vc.model = model
                 vc.hidesBottomBarWhenPushed = true
                 self.navigationController?.pushViewController(vc , animated: true)
            } else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
            }
        }
        
    }
   
    private func configAccountView(){
        self.bottom1View = TRBottomButton1View(frame: .zero)
        self.bottom1View.saveBtn.setTitle("保存下一步", for: .normal)
        self.bottom1View.saveBtn.backgroundColor = .applyColor()
        self.bottom1View.backgroundColor = .white
        self.view.addSubview(self.bottom1View)
        self.accountView = TRAddRiderAccountInfoView (frame: .zero)
        accountView.model = model
        view.addSubview(self.accountView)
        
        bottom1View.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        accountView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(bottom1View.snp.top)
            make.top.equalTo(self.view).offset(Nav_Height)
        }
        
        self.bottom1View.saveBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            if model.riderInfo.codeCity.isEmpty  ||
                model.riderInfo.codeDistrict.isEmpty || model.riderInfo.codeProvince.isEmpty {
                
                SVProgressHUD.showInfo(withStatus: "请完善区域信息")
                // 请选择工作地点
                return
            }
            if  model.riderInfo.codeTown.isEmpty && model.riderInfo.serviceCode.elementsEqual("MALL") {
                SVProgressHUD.showInfo(withStatus: "请完善乡镇街道信息")
                // 请选择工作地点
                return
            }
            toSecond()
        }).disposed(by: self.bag)


    }
    private func configLicenseView(){
        self.bottom2View = TRBottomButton2View(frame: .zero)
        self.bottom2View.backgroundColor = .white
        self.bottom2View.leftBtn.backgroundColor = .hexColor(hexValue: 0xF1F3F4)
        self.bottom2View.leftBtn.setTitleColor(.txtColor(), for: .normal)
        self.bottom2View.rightBtn.backgroundColor = .applyColor()

        self.bottom2View.leftBtn.setTitle("上一步", for: .normal)
        self.bottom2View.rightBtn.setTitle("下一步", for: .normal)
        self.view.addSubview(self.bottom2View)
        self.licenseView = TRAddRiderLicenseInfoView (frame: .zero)
        licenseView.model = model
        view.addSubview(self.licenseView)
        
        
        
        bottom2View.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        licenseView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(bottom2View.snp.top)
            make.top.equalTo(self.view).offset(Nav_Height)

        }
        self.bottom2View.leftBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            
            toFirst()

        }).disposed(by: self.bag)

        self.bottom2View.rightBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else {return}
        if model.userInfo.idCardFrontNetModel.getName().isEmpty {
            SVProgressHUD.showInfo(withStatus: "请上传身份证人像面")
            return
        }
        if  model.userInfo.idCardBackNetModel.getName().isEmpty {
            SVProgressHUD.showInfo(withStatus: "请上传身份证国徽面")
            return
        }
        if model.riderInfo.name.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请输入名字")
            return
        }
        
        if model.userInfo.sex == nil {
            SVProgressHUD.showInfo(withStatus: "请选择性别")
            return
        }
        
        if model.userInfo.nation.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请选择民族")
            return
        }
        if model.userInfo.birthday.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请选择出生日期")
            return
        }
        if model.userInfo.idDetailsAddress.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请输入地址")
            return
        }
        if model.userInfo.idCard.count != 18 {
            SVProgressHUD.showInfo(withStatus: "请输入18位身份证号")
            return
        }
        if !TRTool.checkIdentityCardNumber(model.userInfo.idCard) {
            SVProgressHUD.showInfo(withStatus: "请输入有效的身份证号")
            return
        }
        if model.userInfo.validEndTime.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请选择证件有效期")
            return
        }
        
            toThird()
        }).disposed(by: self.bag)

        
    }

    private func configVihicleView(){
        self.bottom3View = TRBottomButton2View(frame: .zero)
        self.bottom3View.leftBtn.backgroundColor = .hexColor(hexValue: 0xF1F3F4)
        self.bottom3View.leftBtn.setTitleColor(.txtColor(), for: .normal)
        self.bottom3View.leftBtn.setTitle("上一步", for: .normal)
        self.bottom3View.rightBtn.setTitle("确定保存", for: .normal)
        self.bottom3View.backgroundColor = .white
        self.view.addSubview(self.bottom3View)
        self.vihicleView = TRAddRiderVihicleView (frame: .zero)
        vihicleView.model = model
        view.addSubview(self.vihicleView)
        
        bottom3View.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        vihicleView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(bottom1View.snp.top)
            make.top.equalTo(self.view).offset(Nav_Height)

        }
        
        self.bottom3View.leftBtn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self = self else {return}
            self.accountView.isHidden = true
            self.licenseView.isHidden = false
            self.vihicleView.isHidden = true
            
            self.bottom1View.isHidden = true
            self.bottom2View.isHidden = false
            self.bottom3View.isHidden = true
            
            currentView = licenseView
            if licenseView.tableView.contentOffset.y >= StatusBar_Height {
                self.configBarTheme(isLight: false)
            } else {
                self.configBarTheme(isLight: true)
            }
            }).disposed(by: self.bag)
        self.bottom3View.rightBtn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self = self else {return}
            if model.vehicleInfo.energyType.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请选择能源类型")
                return
            }
            if model.vehicleInfo.code.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请选择车辆类型")
                return
            }
            if model.vehicleInfo.drivingLicenseNetModel.getName().isEmpty && model.vehicleInfo.hasLicense{
                SVProgressHUD.showInfo(withStatus: "请上传驾驶证")
                return
            }
            if model.vehicleInfo.registerCertificateNetModel.getName().isEmpty && model.vehicleInfo.hasCertificate{
                SVProgressHUD.showInfo(withStatus: "请上传行驶证")
                return
            }
            if model.vehicleInfo.owner.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请输入车辆所有人")
                return
            }
            if model.vehicleInfo.codeName.contains("电动车") {
                if model.vehicleInfo.numberplate.isEmpty {
                    SVProgressHUD.showInfo(withStatus: "请输入车牌号")
                    return
                }
            }else{
                if vihicleView.type.elementsEqual("新能源"){
                    let numberplate = model.vehicleInfo.numberplate
                    if numberplate.count < 8 {
                        SVProgressHUD.showInfo(withStatus: "请输入车牌号")
                        return
                    }
                } else {
                    let numberplate = model.vehicleInfo.numberplate
                    if numberplate.count < 7 {
                        SVProgressHUD.showInfo(withStatus: "请输入车牌号")
                        return
                    }
                }
            }
            
            if model.vehicleInfo.inspectionDate.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请选择下次年检时间")
                return
            }

            if model.vehicleInfo.frontPictureNetModel.getName().isEmpty ||
                model.vehicleInfo.sidePictureNetModel.getName().isEmpty ||
                model.vehicleInfo.groupPictureNetModel.getName().isEmpty ||
                model.vehicleInfo.backPictureNetModel.getName().isEmpty{
                SVProgressHUD.showInfo(withStatus: "请完善车辆图片信息")
                return
            }
            
            if  model.userInfo.id.isEmpty {
                commitInfo()
            } else {
                updateInfo()
            }
        }).disposed(by: self.bag)
    }
    
    

    private func configTopView(){
        configNavBar()
        backBtn =  configNavLeftBtn()
        configNavTitle(title: "添加骑手")
        navBar?.backgroundColor = .white
        navBar?.titleLab?.textColor = .txtColor()
        backBtn.addTarget(self, action: #selector(jumpAction), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        
    }
    @objc func jumpAction(){
        if step == 3 {
            toSecond()
        } else if step == 2 {
            toFirst()
        } else {
            let alertView = TRAlertView(frame: .zero)
            alertView.addToWindow()
            alertView.titleLab.text = "是否退出？"
            alertView.sureBtn.setTitle("确定", for: .normal)
            alertView.cancelBtn.setTitle("取消", for: .normal)
            alertView.block = {[weak self] _ in
                guard let self = self  else { return }
                
                logout()
            }
            
            
        }
    }
    func saveApplyData(){
        if model.vehicleInfo.id.isEmpty {
            if !model.riderInfo.name.isEmpty ||
                !model.riderInfo.areaAddress.isEmpty ||
                !model.userInfo.nation.isEmpty ||
                !model.userInfo.idDetailsAddress.isEmpty ||
                !model.userInfo.idCardBackNetModel.netName.isEmpty ||
                !model.userInfo.idCardFrontNetModel.netName.isEmpty
            
            {
                DispatchQueue.global().async {[self] in
                    let account = TRTool.getData(key: "phone") as! String
                    if !TRTool.isNullOrEmplty(s: account) {
                        self.model.saveToLocalToAccount(account: account)
                    }
                }
            }
        }
    }
    private func logout(){
        //如果全是本地数据 就保存下
        saveApplyData()
        
        TRTool.saveData(value: "", key: Save_Key_Token)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let loginController = TRLoginViewController()
        let navController = BasicNavViewController(rootViewController: loginController)
        delegate.window?.rootViewController = navController;
    }
    private func configBarTheme(isLight : Bool){
        guard let navBar = navBar else { return }
        let backBtn = navBar.leftView as! UIButton
        if isLight {
            navBar.backgroundColor = .white
            navBar.titleLab?.textColor = .txtColor()
            backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
            //透明
//            navBar.backgroundColor = .clear
//            navBar.titleLab?.textColor = .white
//            backBtn.setImage(UIImage(named: "nav_white"), for: .normal)
        } else {
            navBar.backgroundColor = .white
            navBar.titleLab?.textColor = .txtColor()
            backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        }
    }
    
}

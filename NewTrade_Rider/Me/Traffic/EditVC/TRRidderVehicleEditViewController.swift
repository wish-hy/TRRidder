//
//  TRRidderVehicleEditViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/27.
//

import UIKit
import ZLPhotoBrowser
import Alamofire

class TRRidderVehicleEditViewController: BasicViewController , UITableViewDelegate, UITableViewDataSource {
    var headerView : TRRiderAddHeader!
    var imgV : UIImageView!
    var sections : [String] = ["骑手车辆信息","车辆照片"]
    var tableView : UITableView!
    var bottomView : TRBottomButton1View!
    var block : Float_Block?
    //服务类型
    var serviceCode : String?
    var model : TRApplerRiderContainer = TRApplerRiderContainer()
    var vehicleInfo : TRApplerVehicleInfoModel = TRApplerVehicleInfoModel()
    
    var needLicense = "*上传驾驶证"
    var needCertificate = "*上传行驶证"
    var items : [String] = []
    //旧
    let TYPE_1 = "非新能源"
    let TYPE_2 = "新能源"
    var type = "非新能源"
    private var energyTypes : [TRCommonTypeModel] = []
    private var trafficTypes : [TRCommonTypeModel] = []
    //新
    
    private var showVehicleTypeArr : [TRRiderVheicleTypeContainer] = []
    private var currentSelEnergyIndex = -1
    private var vehicleTypeArr : [TRRiderVheicleTypeContainer] = [] {
        didSet {
            showVehicleTypeArr.removeAll()
            for m in vehicleTypeArr {
                if !m.vtList.isEmpty {
                    showVehicleTypeArr.append(m)
                }
            }
            currentSelEnergyIndex = 0
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    
    private func setupView(){
        configNavBar()
        navBar?.backgroundColor = .white
        configNavLeftBtn()
        if vehicleInfo.id.isEmpty {
            configNavTitle(title: "添加车辆")
        } else {
            configNavTitle(title: "编辑车辆")
        }
        items = ["*能源类型","*车辆类型",needLicense,needCertificate,"*车辆所有人","*车牌号","*下次年检"]

        model.vehicleInfo = vehicleInfo
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(TRInputImg_2Cell.self, forCellReuseIdentifier: "img_2")
        tableView.register(TRAddInfoTItleHeader.self, forHeaderFooterViewReuseIdentifier: "header")

        tableView.register(TRInputImg_4Cell.self, forCellReuseIdentifier: "img_4")

        tableView.register(TRInputVihicleCodeCell.self, forCellReuseIdentifier: "code")
        //普通的车牌号输入
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_traffic_code")

        //为了防止事件复用
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_trafficType")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_traffic")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_time")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_owner")
        self.view.addSubview(tableView)
        
        bottomView = TRBottomButton1View(frame: .zero)
        bottomView.saveBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        self.view.addSubview(bottomView)
        
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top)
            make.left.right.equalTo(self.view).inset(0)
            make.top.equalTo(self.view).inset(Nav_Height + 15)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        getTrafficType()
        
        if !vehicleInfo.id.isEmpty {
            getVehicleDetail()
        }
    }
    
    private func getVehicleDetail(){
        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Traffic_Detail, pars: ["id": vehicleInfo.id]) {[weak self] dict in
            guard let self = self else {return}
            guard let container = TRTrafficContainer.deserialize(from: dict) else {return}
            if container.code == 1 {
                let vm = container.data
                vm.dealNetModel()
                model.vehicleInfo = vm
                tableView.reloadData()
            } else {
                SVProgressHUD.showInfo(withStatus: "车辆图片加载失败")
            }
            
        }
    }
    @objc func addAction(){
        
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
        } else{
            if type.elementsEqual("新能源"){
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
        var num = model.vehicleInfo.numberplate
        if model.vehicleInfo.numberplate.contains("·") {
            num = num.replacingOccurrences(of: "·", with: "")
        }
        var  vehicleInfo = [
            /*"id" : model.vehicleInfo.id,*/
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
        var method : HTTPMethod = .post
        var url = URL_Traffic_Add
        var stip = "车辆添加成功"
        if !model.vehicleInfo.id.isEmpty {
            vehicleInfo["id"] = model.vehicleInfo.id
            method = .put
            url = URL_Traffic_Update
            stip = "车辆修改成功"
        }
        TRNetManager.shared.common_no_lodding(url: url, method: method, pars: vehicleInfo) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRBoolModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                if codeModel.data == true {
                    NotificationCenter.default.post(name: .init(Notification_Name_Vehicle_Change), object: nil)
                    SVProgressHUD.showSuccess(withStatus: stip)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showInfo(withStatus: "车辆添加失败，请重试")
                }
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
        
        
        
    }
    private func openCalbum(_ type : Int){
        TKPermissionPhoto.auth(withAlert: true , level: .readWrite) { ret in
            if ret {
                var uptype = ""
                var url = URL_V1_Vehicle_Upload
                if type == 1 || type == 2 {
                   url = URL_V1_Vehicle_Auth
                } else {
                    url = URL_V1_Vehicle_Upload
                }
                if type == 1 {
                    uptype = "DRIVER"
                } else if type == 2 {
                    uptype = "TRAVEL"
                } else if type == 3 {
                    uptype = "HEAD"
                } else if type == 4 {
                    uptype = "SIDE"
                } else if type == 5 {
                    uptype = "TAIL"
                } else if type == 6 {
                    uptype = "GROUP"
                }
                let config = ZLPhotoConfiguration.default()
                config.allowEditImage = true
                config.allowSelectGif = false
                config.allowSelectVideo = false
                config.maxSelectCount = 1
                let vc = ZLPhotoPreviewSheet(results: nil)
                vc.showPhotoLibrary(sender: self)
                vc.selectImageBlock = { [weak self] results, isOriginal in
                    guard let `self` = self else { return }
                    var imgs : [UIImage] = []
                    var datas : [Data] = []
                    for m in results {
                        //                        let data = m.image.jpegData(compressionQuality: 0.2)
                        let data = TRTool.compressImage(m.image)
                        imgs.append(m.image)
                        
                        datas.append(data!)
                    }
                    TRNetManager.shared.common_upload_pic(files: datas, URLString: url) {[weak self] response in
                        guard let self = self else {return}
                        guard let picModel = TRPicModel.deserialize(from: response) else { return }
                        if  picModel.code == Net_Code_Success && !picModel.data.isEmpty {
                            let nameStr = picModel.data
                            if type == 1 {
                                model.vehicleInfo.drivingLicenseNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)

                            } else if type == 2 {
                                model.vehicleInfo.registerCertificateNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)

                            } else if type == 3 {
                                model.vehicleInfo.frontPictureNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)

                            } else if type == 4 {
                                model.vehicleInfo.sidePictureNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)

                            } else if type == 5 {
                                model.vehicleInfo.backPictureNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)

                            } else if type == 6 {
                                model.vehicleInfo.groupPictureNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)

                            }
          
                            tableView.reloadData()

                            }
                    }
                }
            }
        }
        
        //1 驾驶证 2 行驶证 3 车头 4 侧 5 尾 6 合照
        
    }

    private func getTrafficEnergyType(){
        TRNetManager.shared.get_no_lodding(url: URL_Traffic_EnergyType, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCommonTypeManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                energyTypes = model.data
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    func getTrafficType(){
//        URL_Rider_Enable_Vehicle
        //
        SVProgressHUD.show()
        getTrafficEnergyType()
        var pars : [String : Any] = [:]
        if TRTool.isNullOrEmplty(s: serviceCode) {
            pars = [:]
        } else {
            pars = ["delDomain": serviceCode!]
        }
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Enable_Vehicle, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRRiderVheicleTypeManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                self.vehicleTypeArr = model.data
            }
        }
 
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRAddInfoTItleHeader
            header.lab.text = ""
            return header
        }
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        if indexPath.section == 0 {
            let item = items[indexPath.row]
            //["骑手类型","*骑手车辆","*车辆类型","*上传驾驶证","*上传行驶证","车辆所有人","车牌号","*下次年检"]
            if item.elementsEqual("骑手类型"){
//                let typeView = TRSimpleDataPicker(frame: .zero)
//                 let datas = ["普通骑手","专送骑手"]
//                typeView.items = datas
//                typeView.titleLab.text = "请选择骑手类型"
//                typeView.addToWindow()
//                typeView.openView()
//                typeView.block = {[weak self](index) in
//                     guard let self = self else {return}
//                     model.trafficInfo.riderType = datas[index]
//                     tableView.reloadData()
//                 }
            } else if item.elementsEqual("*车辆类型"){
                if currentSelEnergyIndex == -1 {
                    SVProgressHUD.showInfo(withStatus: "请先选择能源类型")
                    return
                }
                let typeView = TRSimpleDataPicker(frame: .zero)
                var datas : [String] = []
                let tm = showVehicleTypeArr[0]
                for am in tm.vtList {
                    datas.append(am.name)
                }
                typeView.items = datas
                typeView.titleLab.text = "请选择车辆类型"
                typeView.addToWindow()
                typeView.openView()
                typeView.block = {[weak self](index) in
                     guard let self = self else {return}
                    let m = tm.vtList[index]
                    let oriName = model.vehicleInfo.codeName
                    model.vehicleInfo.code = m.code
                    model.vehicleInfo.codeName = m.name
                    model.vehicleInfo.hasLicense = m.hasLicense
                    model.vehicleInfo.hasCertificate = m.hasCertificate
                    if m.hasCertificate {
                        needCertificate = "*上传行驶证"
                    } else {
                        needCertificate = "上传行驶证"
                    }
                    if m.hasLicense {
                        needLicense = "*上传驾驶证"
                    } else {
                        needLicense = "上传驾驶证"
                    }
                    items = ["*能源类型","*车辆类型",needLicense,needCertificate,"*车辆所有人","*车牌号","*下次年检"]

                    //如果原类型或者切换类型是电动车 车牌号清空
                    if model.vehicleInfo.codeName.contains("电动车") || oriName.contains("电动车"){
                        model.vehicleInfo.numberplate = ""
                    }
                     tableView.reloadData()
                 }
            } else if item.elementsEqual("*能源类型"){
                let typeView = TRSimpleDataPicker(frame: .zero)
                var datas : [String] = []
//                for m in showVehicleTypeArr {
//                    datas.append(m.energyTypeDesc)
//                }
                for m in energyTypes {
                    datas.append(m.dictValue)
                }
                typeView.items = datas
                typeView.titleLab.text = "请选择能源类型"
                typeView.addToWindow()
                typeView.openView()
                typeView.block = {[weak self](index) in
                    guard let self = self else {return}
                    type = datas[index]
//                    let m = showVehicleTypeArr[index]
//                    model.vehicleInfo.energyTypeDesc = m.energyTypeDesc
//                    model.vehicleInfo.energyType = m.energyType
                    let m = energyTypes[index]
                    model.vehicleInfo.energyTypeDesc = m.dictValue
                    model.vehicleInfo.energyType = m.dictKey
                    
                    currentSelEnergyIndex = index
                    //选择之后，车辆类型信息清空
                    model.vehicleInfo.code = ""
                    model.vehicleInfo.codeName = ""
//                     model.trafficInfo.traffic = datas[index]
//                    getTrafficType(m.dictKey)
                     tableView.reloadData()
                 }
            } else if item.elementsEqual("*下次年检"){
                let dateView = TRDatePickView(frame: .zero)
                dateView.titleLab.text = "请选择下次年检时间"
                dateView.dateType = .future
                dateView.addToWindow()
                dateView.openView()
                dateView.block = {[weak self](date) in
                     guard let self = self else {return}
                    let df = DateFormatter()
                    df.dateFormat = "YYYY-MM-dd"
                    let dateStr = df.string(from: date)
                     model.vehicleInfo.inspectionDate = dateStr
                     tableView.reloadData()
                 }
            }
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "img_4", for: indexPath) as! TRInputImg_4Cell
            cell.backPictureNetModel = model.vehicleInfo.backPictureNetModel
            cell.frontPictureNetModel = model.vehicleInfo.frontPictureNetModel
            cell.groupPictureNetModel = model.vehicleInfo.groupPictureNetModel
            cell.sidePictureNetModel = model.vehicleInfo.sidePictureNetModel
            cell.block = {[weak self](index) in
                guard let self  = self  else { return  }
                openCalbum(index)
            }
            return cell
        }
        
        let item = items[indexPath.row]
        if item.elementsEqual(needLicense) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "img_2", for: indexPath) as! TRInputImg_2Cell
            cell.leftImgV.image = UIImage(named: "driver_license_front")
            cell.leftNetModel = model.vehicleInfo.drivingLicenseNetModel
            cell.rightBtn.isHidden = true
            cell.rightImgV.isHidden = true
            
            cell.item = needLicense.replacingOccurrences(of: "上传", with: "")
            cell.leftBtn.setTitle("请上传驾驶证", for: .normal)
            cell.block = {[weak self]_ in
                guard let self  = self  else { return }
                openCalbum(1)
            }
            return cell
        } else if item.elementsEqual(needCertificate) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "img_2", for: indexPath) as! TRInputImg_2Cell
            cell.rightBtn.isHidden = true
            cell.rightImgV.isHidden = true
            cell.leftImgV.image = UIImage(named: "vehicle_license_front")
            cell.leftNetModel = model.vehicleInfo.registerCertificateNetModel

            cell.leftBtn.setTitle("请上传行驶证", for: .normal)
            cell.item = needCertificate.replacingOccurrences(of: "上传", with: "")
            cell.block = {[weak self]_ in
                guard let self  = self  else { return }
                openCalbum(2)
            }
            return cell

        } else if item.elementsEqual("*车牌号") {
            // model.vehicleInfo.codeName
            if model.vehicleInfo.codeName.contains("电动车") {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "common_traffic_code", for: indexPath) as! TRInputCommonCell
                cell.item = items[indexPath.row]
                cell.isInput = true
                cell.inset = true
                cell.valueTextField.placeholder = "请输入车牌号"
                cell.valueTextField.text = model.vehicleInfo.numberplate
            
                cell.valueTextField.textView.rx.text.skip(1).subscribe(onNext: {[weak self](t) in
                    guard let self  = self  else { return }
                    if !TRTool.isNullOrEmplty(s: t) {
                        let ss = t! as NSString
                        if ss.length > 10 {
                            model.vehicleInfo.numberplate = ss.substring(to: 10)
                        } else {
                            model.vehicleInfo.numberplate = t ?? ""
                        }
                       
                    } else {
                        model.vehicleInfo.numberplate = t ?? ""
                    }
                })
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "code", for: indexPath) as! TRInputVihicleCodeCell
                
                if type.elementsEqual("新能源"){
                    cell.codeView.limitNum = false
                } else {
                    cell.codeView.limitNum = true
                }
                cell.codeView.code = model.vehicleInfo.numberplate
                cell.codeView.textFiled.text = model.vehicleInfo.numberplate
                cell.codeView.textFiled.rx.text.skip(1).subscribe(onNext: {[weak self](t) in
                    guard let self  = self  else { return }
                    if !TRTool.isNullOrEmplty(s: t) {
                        let ss = t! as NSString
                        if ss.length > 8 {
                            model.vehicleInfo.numberplate = ss.substring(to: 8)
                        } else {
                            model.vehicleInfo.numberplate = t ?? ""
                        }
                    } else {
                        model.vehicleInfo.numberplate = t ?? ""
                    }
                }).disposed(by: cell.bag)
                return cell
            }
        }
                


        if item.elementsEqual("*下次年检"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_time", for: indexPath) as! TRInputCommonCell
            cell.item = items[indexPath.row]
            cell.isInput = false
            cell.inset = true
            cell.valueTextField.placeholder = "请选择下次年检时间"
            cell.valueTextField.text = model.vehicleInfo.inspectionDate
            return cell
        } else if item.elementsEqual("*车辆所有人"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_owner", for: indexPath) as! TRInputCommonCell
            cell.item = items[indexPath.row]
            cell.inset = true
            cell.valueTextField.placeholder = "请输入车辆所有人"
            cell.isInput = true
            cell.valueTextField.text = model.vehicleInfo.owner
//            cell.valueTextField.textView
            cell.valueTextField.textView.rx.text.skip(1).subscribe(onNext: {[weak self](t) in
                guard let self  = self  else { return }
                model.vehicleInfo.owner = t ?? ""
            }).disposed(by: cell.bag)
            return cell
        }else if item.elementsEqual("*车辆类型"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_trafficType", for: indexPath) as! TRInputCommonCell
            cell.item = items[indexPath.row]
            cell.inset = true
            cell.valueTextField.text = model.vehicleInfo.codeName
            cell.valueTextField.placeholder = "请选择车辆类型"

//            for m in trafficTypes {
//                if m.dictKey.elementsEqual(model.vehicleInfo.code) {
//                    cell.valueTextField.text = m.dictValue
//                }
//            }
            cell.isInput = false
            return cell
        }else if item.elementsEqual("*能源类型"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_traffic", for: indexPath) as! TRInputCommonCell
            cell.item = items[indexPath.row]
            cell.inset = true
            cell.valueTextField.placeholder = "请选择能源类型"
           
            cell.valueTextField.text = model.vehicleInfo.energyTypeDesc
            cell.isInput = false
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "common_traffic", for: indexPath) as! TRInputCommonCell
        return cell
    }
 


}

//
//  TRAddRiderVihicelView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit
import ZLPhotoBrowser

class TRAddRiderVihicleView: UIView, UITableViewDelegate, UITableViewDataSource {
    let headerH = 310.0
    let offsetY = 110.0 + (IS_IphoneX ? 0.0 : 44.0)
    var headerView : TRRiderAddHeader!
    var imgV : UIImageView!
    var sections : [String] = ["骑手车辆信息","车辆照片"]
    /*
     var hasLicense : Bool = false
     var hasCertificate : Bool = false
     */
    var needLicense = "*上传驾驶证"
    var needCertificate = "*上传行驶证"
    var items : [String] = []
    var tableView : UITableView!
    var block : Float_Block?
    var selIndex :Int?
    var model : TRApplerRiderContainer!
    
    //旧
    let TYPE_1 = "非新能源"
    let TYPE_2 = "新能源"
    let addIndex = 1
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
    override init(frame: CGRect) {
        super.init(frame: frame)
//        getTrafficType()
        items = ["配送业务","*能源类型","*车辆类型",needLicense,needCertificate,"*车辆所有人","*车牌号","*下次年检"]

        setupView()
        
    }
    
    private func setupView(){
       
        
        imgV = UIImageView(image: UIImage(named: "Add_rider_top_bg"))
        imgV.frame = CGRect(x: 0.0, y: 0.0, width: Screen_Width, height: headerH)

        imgV.contentMode = .scaleAspectFill
        self.addSubview(imgV)
        headerView = TRRiderAddHeader(frame: CGRect(x: 0.0, y: 0.0, width: Screen_Width, height: headerH))
        headerView.progressView.progress = 2

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
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_trafficType")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_traffic")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_time")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_owner")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_traffic_code")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "peisong")
        
        self.addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.left.right.equalTo(self).inset(0)
            make.top.equalTo(self).inset(0)
        }
    }
    func saveApplyData(){
        if model.vehicleInfo.id.isEmpty {
            DispatchQueue.global().async {[self] in
                let account = TRTool.getData(key: "phone") as! String
                if !TRTool.isNullOrEmplty(s: account) {
                    self.model.saveToLocalToAccount(account: account)
                }
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
                vc.showPhotoLibrary(sender: self.iq.viewContainingController()!)
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
                            saveApplyData()

                            }
                    }
                }
            }
        }
        
        //1 驾驶证 2 行驶证 3 车头 4 侧 5 尾 6 合照
        
    }
//    private func getTrafficType(_ type : String){
//        SVProgressHUD.show()
////        let url = URL_Traffic_Type + "?ty"
//        TRNetManager.shared.get_no_lodding(url: URL_Traffic_Type, pars: ["type":type]) {[weak self] dict in
//            guard let self = self else {return}
//            guard let model = TRCommonTypeManage.deserialize(from: dict) else {return}
//            if model.code == 1 {
//                trafficTypes = model.data
//            } else {
//                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
//            }
//        }
//    }
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
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Enable_Vehicle, pars: ["delDomain":model.riderInfo.serviceCode]) {[weak self] dict in
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
            return 45
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRAddInfoTItleHeader
            header.lab.text = "骑手车辆信息"
            return header
        }
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
        if indexPath.section == 0 {
//            guard let self = self else {return}
//            self.endEditing(true)
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
//                    items = ["*能源类型","*车辆类型",needLicense,needCertificate,"*车辆所有人","*车牌号","*下次年检"]
                    items = ["配送业务","*能源类型","*车辆类型",needLicense,needCertificate,"*车辆所有人","*车牌号","*下次年检"]

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
                    saveApplyData()
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
                    saveApplyData()
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
                        saveApplyData()
                    } else {
                        model.vehicleInfo.numberplate = t ?? ""
                        saveApplyData()
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
                        saveApplyData()
                    } else {
                        model.vehicleInfo.numberplate = t ?? ""
                        saveApplyData()
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
        }else if item.elementsEqual("配送业务"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "peisong", for: indexPath) as! TRInputCommonCell
            cell.inset = true
            cell.item = "配送业务"
            cell.isInput = true
            if selIndex == 2{
                cell.valueTextField.text = "同城送货"
            }else if selIndex == 1{
                cell.valueTextField.text = "同城跑腿"
            }else {
                cell.valueTextField.text = "商城配送"
            }
            cell.valueTextField.isUserInteractionEnabled = false
            return cell
        }
        else if item.elementsEqual("*车辆所有人"){
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
                saveApplyData()
            }).disposed(by: cell.bag)
            return cell
        }else if item.elementsEqual("*车辆类型"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_trafficType", for: indexPath) as! TRInputCommonCell
            cell.item = items[indexPath.row]
            cell.inset = true
            cell.valueTextField.text = model.vehicleInfo.codeName
            cell.valueTextField.placeholder = "请选择车辆类型"
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
        }
        imgV.frame = CGRect(x: 0, y: -scrollView.contentOffset.y, width: Screen_Width, height: headerH)
        if block != nil {
            block!(scrollView.contentOffset.y)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

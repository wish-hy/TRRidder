//
//  TRAddRiderLicenseView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import ZLPhotoBrowser
class TRAddRiderAccountInfoView: UIView, UITableViewDelegate, UITableViewDataSource {
    let headerH = 310.0
    let offsetY = 110.0 + (IS_IphoneX ? 0.0 : 44.0)
    var headerView : TRRiderAddHeader!
    var selIndex :Int?
    var imgV : UIImageView!
    var sections = ["骑手账号信息","骑手车辆信息","骑手头像",""]
    
    var items = ["*期望工作地点", "*乡/镇/街道"]
    
    var tableView : UITableView!
    var block : Float_Block?
    var model : TRApplerRiderContainer! {
           didSet {
               tableView.reloadData()
               //从文件读取数据，需要加载开通区域信息
               if applyAreaList.isEmpty && !model.riderInfo.codeDistrict.isEmpty {
                   getOpenAreaListData(code: model.riderInfo.codeDistrict)
               }
           }
       }
    //申请类型
    private var applyTypeModels : [TRRiderApplyTypeModel] = []
    
    private var currentApplyTypeModel : TRRiderApplyTypeModel?
    //申请区域
    
    private var applyAreaList :[TRAddressModel] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        //成功
        setupView()
        
        configRiderTypeData()
        
        // model.riderInfo.codeDistrict

    }
    

    
    private func setupView(){
        imgV = UIImageView(image: UIImage(named: "Add_rider_top_bg"))
        imgV.frame = CGRect(x: 0.0, y: 0, width: Screen_Width, height: headerH)

        imgV.contentMode = .scaleAspectFill
        self.addSubview(imgV)
        headerView = TRRiderAddHeader(frame: CGRect(x: 0.0, y: 0.0, width: Screen_Width, height:   310))
        headerView.progressView.progress = 0
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "map_address")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "area_select")
        tableView.register(TRAddRiderAccountInfoHeader.self, forHeaderFooterViewReuseIdentifier: "header")
          
  //        tableView.register(TRRiderAddHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRRidderApplyTypeCell.self, forCellReuseIdentifier: "type")
        tableView.register(TRRidderApplyTrafficTypeCell.self, forCellReuseIdentifier: "trafficType")
        tableView.register(TRInputHeadCell.self, forCellReuseIdentifier: "head")
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TRInputCodeCell.self, forCellReuseIdentifier: "code")

        tableView.register(TRVihicleSelCell.self, forCellReuseIdentifier: "vihicle1")
        tableView.register(TRVihicleSelCell.self, forCellReuseIdentifier: "vihicle")
            
        tableView.register(TRAppleyComQuesCell.self, forCellReuseIdentifier: "notice")
        self.addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.left.right.equalTo(self).inset(0)
            make.top.equalTo(self).offset(0)
        }

    }
    private func configRiderTypeData(){
        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Vehicle_Type_List, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let tModel = TRRiderApplyTypeManage.deserialize(from: dict) else {return}
            if tModel.code == 1 {
                tModel.dealNetData()
                self.applyTypeModels = tModel.data
                if !applyTypeModels.isEmpty {
                    for m in applyTypeModels {
                        if m.serCode.elementsEqual(model.riderInfo.serviceCode) {
                            currentApplyTypeModel = m
                        }
                    }
                    if currentApplyTypeModel == nil {
                        currentApplyTypeModel = applyTypeModels[0]
                    }
                }
                tableView.reloadData()
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
            
        }
    }
    
    private func getOpenAreaListData(code : String){
        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Opening_Area_List, pars: ["codeDistrict":code]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRAddressManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                applyAreaList = model.data
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
            
        }
    }

    
    private func openCalbum(_ type : String){
        TKPermissionPhoto.auth(withAlert: true , level: .readWrite) { ret in
            if ret {
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
                        let data = TRTool.compressImage(m.image)
                        imgs.append(m.image)
                        datas.append(data!)
                    }
                    
                    TRNetManager.shared.common_upload_pic(files: datas, URLString: URL_V1_HeadPic_Upload) {[weak self] responseObject in
                        guard let self = self  else { return }
                        guard let picModel = TRPicModel.deserialize(from: responseObject) else { return }
                        if picModel.code == Net_Code_Success && !picModel.data.isEmpty{
                            let nameStr = picModel.data
                            if type.elementsEqual("logo") {
                                model.riderInfo.headerPicNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)
                            }
                            tableView.reloadData()
                            saveApplyData()
                        } else {
                            SVProgressHUD.showInfo(withStatus: picModel.exceptionMsg)
                        }
                    }
                }
            }
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UITableView.automaticDimension
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
            return header
        }
        
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                TKPermissionLocationAlways.auth(withAlert: true) { ret in
                    if ret{
                        let vc = TRMapLocalViewController()
                        
                        vc.needAdjustHasOpening = false
                        vc.serviceCode = self.model.riderInfo.serviceCode
                        
                        vc.anni_block = {[weak self](ann) in
                            guard let self = self else { return }
                            let ann = ann as! TRPointAnnotation
                            model.riderInfo.codeProvince = ann.proCode
                            model.riderInfo.codeCity = ann.cityCode
                            model.riderInfo.codeDistrict = ann.disCode
                            model.riderInfo.areaAddress = ann.province + "," + ann.city + "," + ann.district
                            tableView.reloadData()
                            // model.riderInfo.codeDistrict
                            getOpenAreaListData(code: ann.disCode)
                            saveApplyData()
                         }
                        vc.hidesBottomBarWhenPushed = true
                        self.iq.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
                
            } else if indexPath.row == 1{
                let popView = TRAreaStreetSelPopView(frame: .zero)
                popView.applyAreaList = applyAreaList
                popView.contentHeight = Int(Screen_Height / 2)
                popView.addToWindow()
                popView.openView()
                
                popView.block = {[weak self] (index) in
                    guard let self  = self  else { return }
                    let m = applyAreaList[index]
//                    let arr = model.riderInfo.areaAddress.components(separatedBy: ",")
//                    model.riderInfo.areaAddress = "\(arr[0]),\(arr[1]),\(arr[2]),\(m.name)"
//                    model.riderInfo.areaAddress.append(",\(m.name)")
                    model.riderInfo.codeTown = m.code
                    model.riderInfo.townAddress = m.townAddress
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
        if section == 0 {
            return 2
        }else if section == 1 {
            if model == nil {
                return 2
            }
            if model.riderInfo.serviceCode.elementsEqual("MALL") {
                return 2
            } else {
                return 1
            }
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "type", for: indexPath) as! TRRidderApplyTypeCell
                    cell.riderTypes = applyTypeModels
                    if currentApplyTypeModel != nil {
                        cell.currentIndex = applyTypeModels.firstIndex(where: { m in
                            return m.serCode.elementsEqual(currentApplyTypeModel!.serCode)
                        }) ?? 0
                    }
                    cell.block = {[weak self] index in
                        guard let self = self else { return }
                        let m = applyTypeModels[index]
                        model.riderInfo.serviceCode = m.serCode
//                        model.riderInfo.areaAddress = ""
//                        model.riderInfo.townAddress = ""
                        selIndex = index
                        if !m.serCode.elementsEqual(currentApplyTypeModel!.serCode) {
                            currentApplyTypeModel = m
                            tableView.reloadData()
                            saveApplyData()
                        }
                    }
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "trafficType", for: indexPath) as! TRRidderApplyTrafficTypeCell
                    if currentApplyTypeModel != nil {
                        cell.models = currentApplyTypeModel!.vtList
                        cell.serName = currentApplyTypeModel!.name
                    }
                    
                    return cell
                }
            }  else if indexPath.section == 2 {
                //头像
                let cell = tableView.dequeueReusableCell(withIdentifier: "head", for: indexPath) as! TRInputHeadCell
                cell.netLocModel = model.riderInfo.headerPicNetModel
                cell.addPicBlock = {[weak self] in
                    guard let self  = self  else { return  }
                    openCalbum("logo")
                }
                cell.deleteBlock = {[weak self] in
                    guard let self  = self  else { return  }
                    model.riderInfo.headerPicNetModel.removeAll()
                    tableView.reloadData()
                    saveApplyData()
                }
                return cell
            } else if indexPath.section == 3 {
                //注意实现
                let cell = tableView.dequeueReusableCell(withIdentifier: "notice", for: indexPath) as! TRAppleyComQuesCell
                return cell
            }
        //
        let item = items[indexPath.row]
        if indexPath.row == 0 {
            //地图
            let cell = tableView.dequeueReusableCell(withIdentifier: "map_address", for: indexPath) as! TRInputCommonCell
//            if !model.riderInfo.areaAddress.isEmpty {
//                var ss = ""
//                let a = model.riderInfo.areaAddress.components(separatedBy: ",")
//                if a.count >= 3 {
//                    ss = String.init(format: "%@,%@,%@", a[0],a[1],a[2])
//                    cell.valueTextField.text = ss
//
//                } else {
//                    cell.valueTextField.text = model.riderInfo.areaAddress
//                }
//            } else {
//                cell.valueTextField.text = model.riderInfo.areaAddress
//            }
            cell.valueTextField.text = model.riderInfo.areaAddress
            cell.inset = true
            cell.item = item
            cell.isInput = false
            cell.arrowImgV.image = UIImage(named: "location_theme")
            cell.valueTextField.placeholder = "请选择工作地点"
            cell.valueTextField.snp.remakeConstraints { make in
                make.top.bottom.equalTo(cell.bgView).inset(16)
                make.right.equalTo(cell.arrowImgV.snp.left).offset(-5)
                make.left.equalTo(cell.bgView).offset(132)

            }
            return cell
           
        } else if indexPath.row == 1 {
            //区域选择
            let cell = tableView.dequeueReusableCell(withIdentifier: "area_select", for: indexPath) as! TRInputCommonCell
            if !model.riderInfo.townAddress.isEmpty {
                cell.valueTextField.text = model.riderInfo.townAddress
//                var ss = ""
//                let a = model.riderInfo.areaAddress.components(separatedBy: ",")
//                if a.count >= 4 {
//                    ss = String.init(format: "%@", a[3])
//                    cell.valueTextField.text = ss
//
//                } else {
//                    cell.valueTextField.text = ""
//                }
            } else {
                cell.valueTextField.text = ""
            }
            cell.inset = true
            cell.item = item
            cell.isInput = false
            cell.valueTextField.placeholder = "请选择乡/镇/街道"
            cell.valueTextField.snp.remakeConstraints { make in
                make.top.bottom.equalTo(cell.bgView).inset(16)
                make.right.equalTo(cell.arrowImgV.snp.left).offset(-5)
                make.left.equalTo(cell.bgView).offset(132)
            }
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "code", for: indexPath) as! TRInputCodeCell
            cell.model = model
            cell.inset = true
            cell.valueTextField.placeholder = "请输入验证码"
            cell.item = item
            cell.valueTextField.textView.rx.text.subscribe(onNext: {[weak self](txt) in
                guard let self  = self  else { return }
//                model.smsCode = txt ?? ""
            }).disposed(by: cell.bag)
            cell.valueTextField.snp.remakeConstraints { make in
                make.top.bottom.equalTo(cell.bgView).inset(16)
                make.right.equalTo(cell.sendBtn.snp.left).offset(-5)
                make.left.equalTo(cell.bgView).offset(132)
            }
        
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "code", for: indexPath) as! TRInputCodeCell

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

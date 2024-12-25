//
//  TRMineApplyVC.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit
import ZLPhotoBrowser

class TRMineApplyVC: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    
    var sections = ["骑手账号信息","骑手车辆信息","骑手头像",""]
    
    var items = ["*期望工作地点", "*乡/镇/街道"]
    
    private var riderCerModel : TRApplerUserInfoModel = TRApplerUserInfoModel()

    var block : Float_Block?
    var model : TRApplerRiderContainer = TRApplerRiderContainer() {
           didSet {
               tableView.reloadData()
           }
       }
    //申请类型
    private var applyTypeModels : [TRRiderApplyTypeModel] = []
    
    private var currentApplyTypeModel : TRRiderApplyTypeModel?
    //申请区域
    private var currentVehicle : TRRidderApplyVehicleSelModel?
    private var applyAreaList :[TRAddressModel] = []
    
    var bottomView : TRBottomButton1View!
    
    //正在申请
    private var isApplying : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configMainView()
    }
    
    private func configMainView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TRMineApplyAccounInfoCell.self, forCellReuseIdentifier: "info")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "map_address")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "area_select")
        //
        tableView.register(TRRidderApplyTrafficInputCell.self, forCellReuseIdentifier: "traffic_info")

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
        self.view.addSubview(tableView)
        
        bottomView = TRBottomButton1View(frame: .zero)
        bottomView.saveBtn.setTitle("提交申请", for: .normal)
        bottomView.saveBtn.addTarget(self, action: #selector(commitApplyInfo), for: .touchUpInside)
        bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top)
            make.left.right.equalTo(self.view).inset(0)
            make.top.equalTo(self.view).offset(Nav_Height)
            
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        configRiderTypeData()
    }
    
    private func setupNavBar(){
        configNavBar()
        configNavTitle(title: "申请骑手")
        configNavLeftBtn()
        let rightBtn = UIButton()
        rightBtn.setTitle("申请记录", for: .normal)
        rightBtn.titleLabel?.font = .trFont(14)
        rightBtn.setTitleColor(.txtColor(), for: .normal)
        rightBtn.setImage(UIImage(named: "record"), for: .normal)
        rightBtn.frame = .init(x: 0, y: 0, width: 75, height: 38)
        rightBtn.addTarget(self, action: #selector(recordAction), for: .touchUpInside)
        navBar?.rightView = rightBtn
    }
    
    @objc private func commitApplyInfo(){
        if isApplying {
            return
        }
        if currentApplyTypeModel == nil {
            SVProgressHUD.showInfo(withStatus: "请选择配送业务类型")
            return
        }
        if model.riderInfo.codeProvince.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请选择区域")
            return
        }
        if currentApplyTypeModel!.serCode.elementsEqual("MALL") && model.riderInfo.codeTown.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请选择乡/镇/街道")
            return
        }
        if currentVehicle == nil {
            SVProgressHUD.showInfo(withStatus: "请选择车辆")
            return
        }
        let pars = [
            "areaAddress": model.riderInfo.areaAddress,
            "townAddress": model.riderInfo.townAddress,

            "authVehicleId": currentVehicle!.id,
            "codeCity": model.riderInfo.codeCity,
            "codeDistrict": model.riderInfo.codeDistrict,
            "codeProvince": model.riderInfo.codeProvince,
            "codeTown": model.riderInfo.codeTown,
            "serviceCode": currentApplyTypeModel!.serCode
        ]
        isApplying = true
        TRNetManager.shared.post_no_lodding(url: URL_Rider_Apply_Again, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {
                isApplying = false
                return}
            if model.code == 1 {
                SVProgressHUD.showInfo(withStatus: "申请成功，请等待审核")
                self.navigationController?.popViewController(animated: true)
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
            isApplying = false
        }
    }
    
    
    @objc func recordAction(){
        let vc = TRRiderApplyRecordVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
    private func configRiderTypeData(){
        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Vehicle_Type_List, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRRiderApplyTypeManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                model.dealNetData()
                self.applyTypeModels = model.data
                if !applyTypeModels.isEmpty {
                    currentApplyTypeModel = applyTypeModels[0]
                }
                tableView.reloadData()
            } else {
                SVProgressHUD.showInfo(withStatus: "车辆类型获取失败")
                let tm = TRRiderApplyTypeManage()
                tm.createModels()
                self.applyTypeModels = tm.data
                if !applyTypeModels.isEmpty {
                    currentApplyTypeModel = applyTypeModels[0]
                }
                tableView.reloadData()
            }
        }
        
        
        TRNetManager.shared.get_no_lodding(url: URL_Rider_CerInfo, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let manageModel = TRRiderCerInfoManage.deserialize(from: dict) else {return}
            if manageModel.code == 1 {
                riderCerModel = manageModel.data
            } else {
                SVProgressHUD.showInfo(withStatus: manageModel.exceptionMsg)
            }
        }
    }
    
    private func queryTrafficInfo(){
        if currentApplyTypeModel == nil {
            SVProgressHUD.showInfo(withStatus: "请选择业务类型")
            return
        }

        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Vehicle_List, pars: ["delDomain":currentApplyTypeModel!.serCode]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRRidderApplyVehicleMutilSelManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                let popView = TRRiderTrafficSelPopView(frame: .zero)
                popView.containerModel = model.data[0]
                popView.contentHeight = Int(Screen_Height / 2)
                popView.contentView.backgroundColor = .bgColor()
                popView.addToWindow()
                popView.openView()
                popView.block = {[weak self] (vehicle) in
                    guard let self  = self  else { return }
                    self.currentVehicle = vehicle as? TRRidderApplyVehicleSelModel
                    tableView.reloadData()
                }
                popView.addBlock = {[weak self] in
                    guard let self  = self  else { return }
                    popView.closeView()
                    let vc = TRRidderVehicleEditViewController()
                    vc.serviceCode = currentApplyTypeModel!.serCode
                    self.navigationController?.pushViewController(vc , animated: true)
                }
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
        
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let vc = TRRiderApplyCerInfoVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc , animated: true)
        } else if indexPath.section == 1 {
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
                            
                            model.riderInfo.townAddress = ""
                            model.riderInfo.codeTown = ""
                            tableView.reloadData()
                            getOpenAreaListData(code: ann.disCode)
                         }
                        vc.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
                
            } else if indexPath.row == 1{
                if model.riderInfo.codeDistrict.isEmpty {
                    SVProgressHUD.showInfo(withStatus: "请选择区域")
                    return
                }
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
                }

            }
                        
        } else if indexPath.section == 2 {
            queryTrafficInfo()
            
        }

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1 {

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
                    let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! TRMineApplyAccounInfoCell
                    return cell
                } else if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "type", for: indexPath) as! TRRidderApplyTypeCell
                    cell.riderTypes = applyTypeModels
                    cell.block = {[weak self] index in
                        guard let self = self else { return }
                        let m = applyTypeModels[index]
                        model.riderInfo.serviceCode = m.serCode
                        model.riderInfo.areaAddress = ""
                        model.riderInfo.townAddress = ""
                        if !m.serCode.elementsEqual(currentApplyTypeModel!.serCode) {
                            currentApplyTypeModel = m
                            //要移除车辆
                            currentVehicle = nil
                            tableView.reloadData()
                        }
                    }
                    return cell
                } else if indexPath.row == 2{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "trafficType", for: indexPath) as! TRRidderApplyTrafficTypeCell
                    if currentApplyTypeModel != nil {
                        cell.models = currentApplyTypeModel!.vtList
                        cell.serName = currentApplyTypeModel!.name
                    }
                    
                    return cell
                }
            }  else if indexPath.section == 2 {
                //车辆
                let cell = tableView.dequeueReusableCell(withIdentifier: "traffic_info", for: indexPath) as! TRRidderApplyTrafficInputCell
                cell.model = currentVehicle

                return cell
                //头像
//                let cell = tableView.dequeueReusableCell(withIdentifier: "head", for: indexPath) as! TRInputHeadCell
//                cell.netLocModel = model.riderInfo.headerPicNetModel
//                cell.addPicBlock = {[weak self] in
//                    guard let self  = self  else { return  }
//                    openCalbum("logo")
//                }
//                cell.deleteBlock = {[weak self] in
//                    guard let self  = self  else { return  }
//                    model.riderInfo.headerPicNetModel.removeAll()
//                    tableView.reloadData()
//                }
//                return cell
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
    
 
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y <= 0 {
//            scrollView.contentOffset.y = 0
//        }
//       
//        if block != nil {
//            block!(scrollView.contentOffset.y)
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

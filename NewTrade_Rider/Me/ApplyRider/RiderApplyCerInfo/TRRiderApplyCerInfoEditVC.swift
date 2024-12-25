//
//  TRRiderApplyCerInfoEditVC.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit
import ZLPhotoBrowser

class TRRiderApplyCerInfoEditVC: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var model = TRApplerRiderContainer()
    var cerModel : TRApplerUserInfoModel?
    var bottomView : TRBottomButton1View!
    
    let items = ["*骑手身份证","*姓名","*性别","*民族","*出生日期","*住址","*身份证号码","*证件有效期"]
    var imgV : UIImageView!
    var nations : [String] = []

    var offsetBlock : Float_Block?
    var tableView : UITableView!
    var block : Float_Block?
    
    var isLoading : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        configNavTitle(title: "证件信息")
        configNavLeftBtn()
        
        if cerModel != nil {
            cerModel!.dealNetModel()
            model.userInfo = cerModel!
        }
        
        nations = nationStr.components(separatedBy: "、")

        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundView = headerView
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(TRTableViewCornerHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRTableViewCornerFooter.self, forHeaderFooterViewReuseIdentifier: "footer")

        tableView.register(TRInputImg_2Cell.self, forCellReuseIdentifier: "img_2")
      
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_name")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_sex")

        tableView.register(TRMutilLineInputView.self, forCellReuseIdentifier: "common_address")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_nation")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_birth")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_idCard")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_idCardDate")
        self.view.addSubview(tableView)

        nationList()
     
        bottomView = TRBottomButton1View(frame: .zero)
        bottomView.saveBtn.setTitle("确定修改", for: .normal)
        bottomView.saveBtn.addTarget(self, action: #selector(updateCerInfo), for: .touchUpInside)
        bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.bottom.equalTo(bottomView.snp.top)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        
    }
    @objc private func updateCerInfo(){
        if isLoading {
            isLoading = false
            return
        }
        isLoading = true
        if model.userInfo.idCardFrontNetModel.getName().isEmpty {
            SVProgressHUD.showInfo(withStatus: "请上传身份证人像面")
            return
        }
        if  model.userInfo.idCardBackNetModel.getName().isEmpty {
            SVProgressHUD.showInfo(withStatus: "请上传身份证国徽面")
            return
        }
        if model.userInfo.realName.isEmpty {
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
        
        
        let pars = [
            "idCardBack":model.userInfo.idCardBackNetModel.netNameArr.last ?? "",
            "idCardFront":model.userInfo.idCardFrontNetModel.netNameArr.last ?? "",
            "realName":model.riderInfo.name,
            "sex":model.userInfo.sex!,
            "nation":model.userInfo.nation,
            "birthday":model.userInfo.birthday,
            "idDetailsAddress":model.userInfo.idDetailsAddress,
            "idCard":model.userInfo.idCard,
            "validBeginTime":model.userInfo.validBeginTime,
            "validEndTime":model.userInfo.validEndTime,
                                
        ] as [String : Any]
        
        isLoading = true
        TRNetManager.shared.put_no_lodding(url: URL_Rider_CerInfo_Update, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {
                isLoading = false

                return}
            if codeModel.code == Net_Code_Success {
                let ret = codeModel.data as? Bool ?? false
                if ret {
                    SVProgressHUD.showInfo(withStatus: "修改成功，请等待审核")
                    self.navigationController!.popToViewController(self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 3] , animated: true)
                } else {
                    SVProgressHUD.showInfo(withStatus: "修改失败，请稍后重试")
                }
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
            isLoading = false
           
        }
    }
    //加载民族
    private func nationList(){
        TRNetManager.shared.get_no_lodding(url: URL_Nation_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRNationManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                nations.removeAll()
                for m in model.data {
                    nations.append(m.dictValue)
                }
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
                    TRNetManager.shared.common_upload_pic(files: datas, URLString: URL_Upload_idCard) {[weak self] response in
                        guard let self = self else {return}
                        guard let picModel  = TRPicModel.deserialize(from: response) else { return }
                       
                        if  picModel.code == Net_Code_Success && !picModel.data.isEmpty{
                            let nameStr = picModel.data
                            if type.elementsEqual("FRONT") {
                                model.userInfo.idCardFrontNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)
                            } else {
                                model.userInfo.idCardBackNetModel.addLocalImg(img: imgs.last!, netName: nameStr.last!)

                            }
                            tableView.reloadData()

                            }
                    }
                }
            }
        }
        
    }
    
   
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
        return footer
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        let item = items[indexPath.row]
        if item.elementsEqual("*性别") {
           let sexView = TRSimpleDataPicker(frame: .zero)
            let datas = ["男","女"]
            sexView.items = datas
            sexView.titleLab.text = "请选择性别"
            sexView.addToWindow()
            sexView.openView()
            sexView.block = {[weak self](index) in
                guard let self = self else {return}
                if index == 0 {
                    model.userInfo.sex = true
                } else {
                    model.userInfo.sex = false
                }
                tableView.reloadData()
            }
        } else if item.elementsEqual("*出生日期"){
            let dateView = TRDatePickView(frame: .zero)
            dateView.titleLab.text = "请选择出生日期"
            dateView.dateType = .birth
            dateView.addToWindow()
            dateView.openView()
            dateView.block = {[weak self](date) in
                guard let self = self else {return}
                let df = DateFormatter()
                df.dateFormat = "YYYY-MM-dd"
                let dateStr = df.string(from: date)
                model.userInfo.birthday = dateStr
                tableView.reloadData()
            }
        }  else if item.elementsEqual("*民族"){
            let nationView = TRSimpleDataPicker(frame: .zero)
            nationView.titleLab.text = "请选择民族"
            nationView.items = nations
            nationView.addToWindow()
            nationView.openView()
            nationView.block = {[weak self](index) in
                guard let self = self else {return}
                model.userInfo.nation = nations[index]
                tableView.reloadData()
            }
        }  else if item.elementsEqual("*证件有效期"){
//            let dateView = TRDatePickView(frame: .zero)
//            dateView.titleLab.text = "请选择证件有效期"
//            dateView.addToWindow()
//            dateView.openView()
//            dateView.block = {[weak self](date) in
//                guard let self = self else {return}
//                let df = DateFormatter()
//                df.dateFormat = "YYYY-MM-DD"
//                let dateStr = df.string(from: date)
//                model.userInfo.validEndTime = dateStr
//                tableView.reloadData()
//            }
            let dateView = TRVaildDatePicker(frame: .zero)
            dateView.addToWindow()
            dateView.openView()
            dateView.block = {[weak self](begin, end) in
                guard let self  = self  else { return  }
                model.userInfo.validBeginTime = begin
                model.userInfo.validEndTime = end
                tableView.reloadData()
            }
            
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "img_2", for: indexPath) as! TRInputImg_2Cell
            cell.leftNetModel = model.userInfo.idCardFrontNetModel
            cell.rightNetModel = model.userInfo.idCardBackNetModel
            cell.block = {[weak self](index) in
                guard let self  = self else { return }
                
                //1 左 2 有
                var type = "FRONT"
                if index == 1 {
                    type = "FRONT"
                } else {
                    type = "BACK"
                }
                openCalbum("\(type)")
            }
            cell.item = items[indexPath.row]
           
            return cell
        }
        let item = items[indexPath.row]


        if item.elementsEqual("*姓名"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_name", for: indexPath) as! TRInputCommonCell
            cell.item = item
            cell.inset = true
            cell.valueTextField.placeholder = "请输入姓名"
            cell.isInput = true
            cell.valueTextField.text = model.userInfo.realName
            cell.valueTextField.textView.rx.text.subscribe(onNext: {[weak self](text) in
                guard let self = self else { return }
                model.riderInfo.name = text ?? ""
            }).disposed(by: cell.bag)
            return cell

        } else if item.elementsEqual("*性别"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_sex", for: indexPath) as! TRInputCommonCell
            cell.item = item
            cell.inset = true
            cell.valueTextField.placeholder = "请选择性别"

            cell.isInput = false
            if model.userInfo.sex == nil {
                
                cell.valueTextField.text = ""
            } else {
                if model.userInfo.sex! {
                    cell.valueTextField.text = "男"
                } else {
                    cell.valueTextField.text = "女"
                }
            }
            return cell

        } else if item.elementsEqual("*民族"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_nation", for: indexPath) as! TRInputCommonCell
            cell.item = item
            cell.inset = true
            cell.valueTextField.placeholder = "请选择民族"

            cell.isInput = false
            cell.valueTextField.text = model.userInfo.nation
            return cell

        } else if item.elementsEqual("*出生日期"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_birth", for: indexPath) as! TRInputCommonCell
            cell.item = item
            cell.inset = true
            cell.valueTextField.placeholder = "请选择出生日期"

            cell.isInput = false
            cell.valueTextField.text = model.userInfo.birthday
            return cell

        } else if item.elementsEqual("*住址"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_address", for: indexPath) as! TRMutilLineInputView
            cell.item = item
            cell.inset = true
            cell.valueTextField.placeholder = "请输入住址"

            cell.isInput = true
            cell.valueTextField.text = model.userInfo.idDetailsAddress
            cell.valueTextField.textView.rx.text.subscribe(onNext: {[weak self](text) in
                guard let self = self else { return }
                model.userInfo.idDetailsAddress = text ?? ""
            }).disposed(by: cell.bag)
            return cell

        } else if item.elementsEqual("*身份证号码"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_idCard", for: indexPath) as! TRInputCommonCell
            cell.item = item
            cell.inset = true
            cell.valueTextField.placeholder = "请输入身份证号码"

            cell.isInput = true
            cell.valueTextField.text = model.userInfo.idCard
            cell.valueTextField.textView.rx.text.subscribe(onNext: {[weak self](text) in
                guard let self = self else { return }
                var tempStr = text
                if !TRTool.isNullOrEmplty(s: text) {
                    if text!.count > 18 {
                        let t = text as! NSString
                        tempStr = t.substring(to: 18)
                        cell.valueTextField.textView.text = tempStr

                    }
                }
                model.userInfo.idCard = tempStr ?? ""
            }).disposed(by: cell.bag)
            return cell

        } else if item.elementsEqual("*证件有效期"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "common_idCardDate", for: indexPath) as! TRInputCommonCell
            cell.item = item
            cell.inset = true
            cell.valueTextField.placeholder = "请输入证件有效期"

            cell.isInput = false
            if model.userInfo.validBeginTime.isEmpty {
                cell.valueTextField.text = ""
            } else {
                cell.valueTextField.text = model.userInfo.validBeginTime + "~" + model.userInfo.validEndTime
            }
//            if model.userInfo.validBeginTime.isEmpty {
//                cell.valueTextField.text = ""
//            } else {
//                cell.valueTextField.text = model.userInfo.validBeginTime + "~" + model.userInfo.validEndTime
//            }
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "common", for: indexPath) as! TRInputCommonCell

        return cell

    }
    
    
  
    
    
    let nationStr = "汉族、满族、蒙古族、回族、藏族、维吾尔族、苗族、彝族、壮族、布依族、侗族、瑶族、白族、土家族、哈尼族、哈萨克族、傣族、黎族、傈僳族、佤族、畲族、高山族、拉祜(音：护)族、水族、东乡族、纳西族、景颇族、柯尔克孜族、土族、达斡(音：握)尔族、仫(音：目)佬族、羌族、布朗族、撒拉族、毛南族、仡佬族、锡伯族、阿昌族、普米族、朝鲜族、塔吉克族、怒族、乌孜别克族、俄罗斯族、鄂温克族、德昂族、保安族、裕固族、京族、塔塔尔族、独龙族、鄂伦春族、赫哲族、门巴族、珞巴族、基诺族"

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

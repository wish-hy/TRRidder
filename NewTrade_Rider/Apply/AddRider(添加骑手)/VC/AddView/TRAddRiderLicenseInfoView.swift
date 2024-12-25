//
//  TRAddRiderAccountInfoView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit
import ZLPhotoBrowser
import RxSwift
import RxCocoa
class TRAddRiderLicenseInfoView: UIView , UITableViewDataSource, UITableViewDelegate{
    let headerH = 310.0
    let offsetY = 110.0 + (IS_IphoneX ? 0.0 : 44.0)
    var headerView : TRRiderAddHeader!    
    let items = ["*上传骑手身份证","*姓名","*性别","*民族","*出生日期","*住址","*身份证号码","*证件有效期"]
    var imgV : UIImageView!
    var nations : [String] = []

    var offsetBlock : Float_Block?
    var tableView : UITableView!
    var block : Float_Block?
    var model : TRApplerRiderContainer! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){

        imgV = UIImageView(image: UIImage(named: "Add_rider_top_bg"))
        imgV.frame = CGRect(x: 0.0, y: 0.0, width: Screen_Width, height: headerH)

        imgV.contentMode = .scaleAspectFill
        self.addSubview(imgV)
        headerView = TRRiderAddHeader(frame: CGRect(x: 0.0, y: 0.0, width: Screen_Width, height: headerH))
        headerView.progressView.progress = 1

        nations = nationStr.components(separatedBy: "、")

        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundView = headerView
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(TRAddInfoTItleHeader.self, forHeaderFooterViewReuseIdentifier: "header")

        tableView.register(TRInputImg_2Cell.self, forCellReuseIdentifier: "img_2")
      
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_name")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_sex")

        tableView.register(TRMutilLineInputView.self, forCellReuseIdentifier: "common_address")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_nation")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_birth")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_idCard")
        tableView.register(TRInputCommonCell.self, forCellReuseIdentifier: "common_idCardDate")

        tableView.tableHeaderView = headerView

        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.right.equalTo(self).inset(0)
            make.bottom.equalTo(self)
        }
        nationList()
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
                        //                        let data = m.image.jpegData(compressionQuality: 0.2)
                        let data = TRTool.compressImage(m.image)
                        imgs.append(m.image)
                        datas.append(data!)
                    }
                    
                    TRNetManager.shared.common_upload_pic(files: datas, URLString: URL_V1_IDCard_Upload) {[weak self] responseObject in
                        guard let self = self  else { return }
                        guard let picModel = TRPicModel.deserialize(from: responseObject) else { return }
                        if picModel.code == 1 && !picModel.data.isEmpty{
                            if type.elementsEqual("FRONT") {
                                model.userInfo.idCardFrontNetModel.addLocalImg(img: imgs.last!, netName: picModel.data.last!)
                            } else {
                                model.userInfo.idCardBackNetModel.addLocalImg(img: imgs.last!, netName: picModel.data.last!)
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
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
                saveApplyData()
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
                saveApplyData()
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
                saveApplyData()
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
                saveApplyData()
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
            cell.valueTextField.text = model.riderInfo.name
            cell.valueTextField.textView.rx.text.skip(1).subscribe(onNext: {[weak self](text) in
                guard let self = self else { return }
                model.riderInfo.name = text ?? ""
                saveApplyData()
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
                saveApplyData()
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
                        let t = text! as NSString
                        tempStr = t.substring(to: 18)
                        cell.valueTextField.textView.text = tempStr

                    }
                }
                model.userInfo.idCard = tempStr ?? ""
                saveApplyData()
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
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "common", for: indexPath) as! TRInputCommonCell

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
    
    
    let nationStr = "汉族、满族、蒙古族、回族、藏族、维吾尔族、苗族、彝族、壮族、布依族、侗族、瑶族、白族、土家族、哈尼族、哈萨克族、傣族、黎族、傈僳族、佤族、畲族、高山族、拉祜(音：护)族、水族、东乡族、纳西族、景颇族、柯尔克孜族、土族、达斡(音：握)尔族、仫(音：目)佬族、羌族、布朗族、撒拉族、毛南族、仡佬族、锡伯族、阿昌族、普米族、朝鲜族、塔吉克族、怒族、乌孜别克族、俄罗斯族、鄂温克族、德昂族、保安族、裕固族、京族、塔塔尔族、独龙族、鄂伦春族、赫哲族、门巴族、珞巴族、基诺族"
}

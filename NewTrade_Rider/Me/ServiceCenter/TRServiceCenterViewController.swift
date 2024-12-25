//
//  TRServiceCenterViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxCocoa
import RxSwift
import ZLPhotoBrowser
import IQKeyboardManagerSwift
class TRUserQuestionModel {
    var qustion : String = ""
    var phone : String = ""
}

class TRServiceCenterViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView : UITableView!
    
    var kfBtn : UIButton!
    var kfLab : UILabel!
    var netLocalModel : NetLocImageModel = NetLocImageModel()
    var questionList : [TRQuestionModel] = []
    
    var userQues : TRUserQuestionModel = TRUserQuestionModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        configNavTitle(title: "客服中心")
        configNavLeftBtn()
        IQKeyboardManager.shared.isEnabled = false
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRServiceTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TRServiceFeedTableViewCell.self, forCellReuseIdentifier: "cell1")

        
        tableView.register(TRServiceHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRServiceFooter.self, forHeaderFooterViewReuseIdentifier: "footer")
        self.view.addSubview(tableView)
        
        let serverBtn = UIButton()
        self.view.addSubview(serverBtn)
        let kfBtn = UIButton()
        kfBtn.isUserInteractionEnabled = false
        kfBtn.setImage(UIImage(named: "kf"), for: .normal)
        kfBtn.trCorner(24)
        kfBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        self.view.addSubview(kfBtn)
        let kfLab = UILabel()
        kfLab.text = "客服电话"
        kfLab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        kfLab.font = UIFont.trFont(fontSize: 13)
        self.view.addSubview(kfLab)
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.bottom.equalTo(self.view)
        }
        kfBtn.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.right.equalTo(self.view).offset(-16)
            make.bottom.equalTo(self.view).offset(0 - 54 - 16 - 48  - 10)
        }
        kfLab.snp.makeConstraints { make in
            make.centerX.equalTo(kfBtn)
            make.top.equalTo(kfBtn.snp.bottom).offset(2)
        }
        serverBtn.snp.makeConstraints { make in
            make.left.right.equalTo(kfBtn)
            make.top.equalTo(kfBtn)
            make.bottom.equalTo(kfLab)
        }
        commenQuestion()
        //18948786816
        serverBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else { return }
            TRTool.callPhone("18948786816")
        }).disposed(by: bag)
        
    }
    private func openCalbum(_ type : String){
        TKPermissionPhoto.auth(withAlert: true , level: .readWrite) { ret in
            if ret {
                let config = ZLPhotoConfiguration.default()
                config.allowEditImage = true
                config.allowSelectGif = false
                config.allowSelectVideo = false
                config.maxSelectCount = 4
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
                    TRNetManager.shared.common_upload_pic(files: datas, URLString: URL_V1_Sugges_Upload) {[weak self] responseObject in
                        guard let self = self  else { return }
                        guard let picModel = TRPicModel.deserialize(from: responseObject) else { return }
                        if picModel.code == 1 && !picModel.data.isEmpty{
                            netLocalModel.addLocalImgArr(imgs: imgs, netNames: picModel.data)
                            tableView.reloadData()
                        } else {
                            SVProgressHUD.showInfo(withStatus: picModel.exceptionMsg)
                        }
                    }
                }
            }
        }
        
    }
    private func commenQuestion(){
        let subPars : [String:String] = [:]
        let pars = [
            "current" : page,
            "param" : subPars,
            "size" : 3
        ] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Service_Question_list, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRQuestionManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                questionList = model.data.records
                tableView.reloadData()
            }
        }
    }
    private func commitQus(){
        if userQues.qustion.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请输入问题")
            return
        }
        if userQues.phone.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请输入联系方式")
            return
        }
        let res = netLocalModel.getName()
        let pars = [
            "content" : userQues.qustion,
            "platform" : APP_Platform,
            "phone" : userQues.phone,
            "client" : APP_Client,
            "resource" : res
        ]
        SVProgressHUD.show()
        TRNetManager.shared.post_no_lodding(url: URL_Feedback, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "提交成功")
                self.navigationController?.popViewController(animated: true)
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 54 + 16 + 35  + 50
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as! TRServiceFooter
            footer.btn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self  = self  else { return }
                commitQus()
                
            }).disposed(by: footer.bag)
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 55
        }
        
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let m = questionList[indexPath.row]
            let vc = TRQuestionDetailViewController()
            vc.item = m
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRServiceHeader
        if section == 0 {
            
            header.titleLab.text = "常见问题"
            header.moreBtn.isHidden = false
            header.moreBtn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self  = self  else { return }
                let vc  = TRMoreQuestionViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: header.bag)
        } else {
            header.titleLab.text = "反馈与建议"
            header.moreBtn.isHidden = true
        }
        //{
        return header

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return questionList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRServiceTableViewCell
            let m = questionList[indexPath.row]
            cell.titleLab.text = m.problem
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRServiceFeedTableViewCell
        cell.netLocImgModel = netLocalModel
        cell.phoneTF.keyboardType = .numberPad
        cell.phoneTF.rx.text.subscribe(onNext: {[weak self](txt) in
            guard let self  = self else { return }
            var p = txt
            if !TRTool.isNullOrEmplty(s: p) {
                if p!.count > 11 {
                    p = (p! as NSString).substring(to: 11)
                    cell.phoneTF.text = p
                }
            } else {
                p = ""
            }
            userQues.phone = p!
        }).disposed(by: bag)
        cell.limitView.textView.rx.text.subscribe(onNext: {[weak self](txt) in
            guard let self  = self else { return }
            userQues.qustion = txt ?? ""
        }).disposed(by: bag)
        cell.picView.block = {[weak self] in
            guard let self  = self  else { return }
            openCalbum("ques")
        }
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

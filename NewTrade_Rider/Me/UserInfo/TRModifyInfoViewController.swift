//
//  TRModifyInfoViewController.swift
//  NewTrade_Seller
//
//  Created by xph on 2024/1/11.
//

import UIKit
import NextGrowingTextView
import RxSwift
import RxCocoa
enum modifyUserInfoType {
    //用户信息
    case name
    case detailAddress
    //门店信息
    case storeName
    case storeAd
    case storePhone
    case storeAddress
}
class TRModifyInfoViewController: BasicViewController {
    var userModel : TRUserModel?
    var nameTF : TRPlaceHolderTextView!
    var type : modifyUserInfoType = .name
    var tipLab : UILabel!
    let bag = DisposeBag()
    let max = 10000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        costomNav()
        if userModel == nil || userModel!.id.isEmpty {
            SVProgressHUD.showInfo(withStatus: "未获取到用户信息")
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let inputBgView = UIView()
        inputBgView.backgroundColor = .white
        self.view.addSubview(inputBgView)
   
        nameTF = TRPlaceHolderTextView()

        switch type {
        case .name:
            nameTF.placeholder = "请输入姓名"
            nameTF.text = userModel!.name
        case .detailAddress:
            nameTF.placeholder = "请输入楼道、楼栋、小区"
            nameTF.text = userModel!.residentialAddress
        case .storeName:
            nameTF.placeholder = "请输入门店名称"
        case .storeAd:
            nameTF.placeholder = "请输入门店公告"
        case .storePhone:
            nameTF.placeholder = "请输入店铺电话"
        case .storeAddress:
            nameTF.placeholder = "请输入店铺地址"
        }
        nameTF.font = .trFont(fontSize: 15)
        nameTF.configuration.maxLines = 100
        self.view.addSubview(nameTF)
        
        tipLab = TRFactory.labelWith(font: .trFont(fontSize: 12), text: "0/\(self.max)", textColor: .hexColor(hexValue: 0x9B9C9C), superView: inputBgView)
        tipLab.isHidden = true
        inputBgView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height + 10)
            make.bottom.equalTo(tipLab).offset(10)
        }
        tipLab.snp.makeConstraints { make in
            make.right.equalTo(inputBgView).offset(-16)
            make.top.equalTo(nameTF.snp.bottom).offset(17)
        }
        nameTF.snp.makeConstraints { make in
            make.left.right.equalTo(inputBgView).inset(16)
            make.top.equalTo(inputBgView).inset(10)
            make.height.greaterThanOrEqualTo(20)
        }
        
//        nameTF.textView.rx.text.subscribe(onNext: {[weak self](t) in
//            if TRTool.isNullOrEmplty(s: t){return}
//            if t!.count <= self!.max {
//                self!.tipLab.text = "\(t!.count)/\(self!.max)"
//            } else {
//                let s = t! as NSString
//                self!.nameTF.textView.text = s.substring(with: .init(location: 0, length: self!.max))
//            }
//        }).disposed(by: bag)



    }
    
    @objc func copyName(){
        nameTF.textView.text = tipLab.text
    }
    private func costomNav(){
        configNavBar()
        if type == .name {
            configNavTitle(title: "修改姓名")
        } else {
            configNavTitle(title: "修改联系地址")
        }
        switch type {
        case .name:
            configNavTitle(title: "修改姓名")
        case .detailAddress:
            configNavTitle(title: "修改联系地址")
        case .storeName:
            configNavTitle(title: "修改门店名称")
        case .storeAd:
            configNavTitle(title: "修改门店公告")
        case .storePhone:
            configNavTitle(title: "修改店铺电话")
        case .storeAddress:
            configNavTitle(title: "修改店铺地址")
        }
        configNavLeftBtn()
        navBar?.contentView.backgroundColor = .white
        
        let saveBtn = TRFactory.buttonWithCorner(title: "保存", bgColor: .lightThemeColor(), font: .trMediumFont(fontSize: 13), corner: 15)
        saveBtn.frame = CGRect(x: 0, y: 0, width: 62, height: 30)
        navBar?.rightView = saveBtn
        
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }

    private func updateStoreInfo(){
        
    }
    @objc func saveAction(){
        var pars : [String : String] = [:]
        if !(type == .name || type == .detailAddress) {
            //更新店铺信息
            updateStoreInfo()
        }
        if type == .name {
            pars = [
                "name" : nameTF.textView.text
            ]
        } else if type == .detailAddress {
            pars = [
                "residentialAddress" : nameTF.textView.text
            ]
        } else {
            SVProgressHUD.showInfo(withStatus: "未知修改")
            return
        }
        TRNetManager.shared.put_no_lodding(url: URL_Me_Update_Info, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "信息更新成功")
                self.navigationController?.popViewController(animated: true)
                if type == .name {
                    userModel!.nickName = nameTF.textView.text
                } else if type == .detailAddress {
                    userModel!.residentialAddress = nameTF.textView.text
                }
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
        
    }


}

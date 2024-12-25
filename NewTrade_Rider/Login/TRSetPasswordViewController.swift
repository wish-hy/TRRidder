//
//  TRSetPasswordViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit
import RxSwift
import MZRSA_Swift

class TRSetPasswordViewController: BasicViewController {
    
    var phone : String = ""
    var code : String = ""
    var passwordField : UITextField!
    var codeLine : UIView!
    var loginBtn : UIButton!
    var eyeBtn : UIButton!
    private var myPw = ""
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let methodLab = UILabel()
        methodLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        methodLab.text = "设置登录密码"
        methodLab.font = .boldSystemFont(ofSize: 26)
        view.addSubview(methodLab)
        
        passwordField = UITextField()
        passwordField.textColor = UIColor.hexColor(hexValue: 0x141414)
        passwordField.font = .systemFont(ofSize: 16)
        passwordField.placeholder = "请输入登录密码"
        passwordField!.keyboardType = .asciiCapable
        passwordField.isSecureTextEntry = false
        view.addSubview(passwordField)
        
        eyeBtn = UIButton();
        eyeBtn.setImage(UIImage(named: "view"), for: .normal)
        view.addSubview(eyeBtn)
        
        codeLine = UIView();
        codeLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        view.addSubview(codeLine!)
        
        loginBtn = UIButton()
        loginBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        loginBtn.setTitle("确认", for: .normal)
        loginBtn.titleLabel?.font = .systemFont(ofSize: 18)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.layer.cornerRadius = 23
        loginBtn.layer.masksToBounds = true
        let bgLayer = CALayer()

        loginBtn.layer.shadowColor = UIColor(red: 0.36, green: 1, blue: 0.55, alpha: 0.25).cgColor
        loginBtn.layer.shadowOffset = CGSize(width: 0, height: 7)
        loginBtn.layer.shadowOpacity = 1
        loginBtn.layer.shadowRadius = 17
        
        view.addSubview(loginBtn)
        
        configNavBar()
        configNavLeftBtn()
        
//        let s = Int(arc4random()) % (999999 - 100000 + 1) + 100000
//        passwordField.text = "\(s)"
        methodLab.snp.makeConstraints { make in
            make.top.equalTo(view).offset(114)
            make.left.equalTo(view).offset(16)
        }
        passwordField.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.top.equalTo(methodLab.snp.bottom).offset(58)
            make.height.equalTo(35)
        }
        eyeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(passwordField)
            make.right.equalTo(passwordField)
            make.height.width.equalTo(24)
        }
        codeLine.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.top.equalTo(passwordField.snp.bottom)
            make.height.equalTo(1)
        }
        loginBtn.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.top.equalTo(codeLine).offset(80)
            make.height.equalTo(46)
        }
        
        loginBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            if TRTool.isNullOrEmplty(s: passwordField.text) {
                SVProgressHUD.showInfo(withStatus: "请输入密码")
                return
            }
            if passwordField!.text!.count < 6 || passwordField!.text!.count > 12 {
                SVProgressHUD.showInfo(withStatus: "请输入6~12位密码")
                return
            }
            var pw = MZRSA.encryptString(passwordField.text!, publicKey: rsa_pu_key)
             pw = pw!.replacingOccurrences(of: "\n", with: "")
            myPw = pw!.replacingOccurrences(of: "\r", with: "")
            let pars = [
                "phone" : phone,
                "password" : myPw,
                "smsCode" : code
            ]
            SVProgressHUD.show()
            TRNetManager.shared.post_no_lodding(url: URL_User_Register, pars: pars) {[weak self] dict in
                guard let self = self else {return}
                guard let model = TRCodeModel.deserialize(from: dict) else {return}
                if model.code == 1 {
                    loginAction()
                } else {
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                }
            }
            
            
            
        }).disposed(by: bag)
        eyeBtn.rx.tap.subscribe ( onNext : {[weak self] in
            self?.passwordField?.isSecureTextEntry = !(self?.passwordField?.isSecureTextEntry ?? false)
            if (self!.passwordField!.isSecureTextEntry) {
                self?.eyeBtn?.setImage(UIImage(named: "hidden"), for: .normal)
            } else {
                self?.eyeBtn?.setImage(UIImage(named: "view"), for: .normal)
            }
        }).disposed(by: bag)
    }
    
    private func loginAction(){
        let pars = [
            "account" : phone,
            "password" : myPw,
            "channelEnum" : APP_Platform,
            "clientEnum" : APP_Client,
            /*"deviceId" : TRTool.getUUID(),
            "mac" : TRTool.getMacInfo()*/
        ] as [String : String]
        SVProgressHUD.show()
        TRNetManager.shared.userAuthService(url: URL_User_Login_Pwd, method: .post, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
//                SVProgressHUD.showSuccess(withStatus: "登录成功")
                TRTool.saveData(value: model.data as! String, key: Save_Key_Token)
                //首次注册登录
                let vc = TRAddRiderVViewController()
                let navVC = BasicNavViewController(rootViewController: vc)
                UIApplication.shared.keyWindow?.rootViewController = navVC
            }  else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
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

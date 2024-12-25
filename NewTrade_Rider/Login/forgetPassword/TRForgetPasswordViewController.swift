//
//  TRForgetPasswordViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit
import RxSwift
import RxCocoa
import MZRSA_Swift
class TRForgetPasswordViewController: BasicViewController {
    var phoneTipLab : UILabel!
    var phoneTextField : LimitedInputTextFiled!
    var phoneLine : UIView!
    
    var codeTipLab : UILabel!
    var codeTextField : UITextField!
    var codeLine : UIView!
    var sendCodeBtn : UIButton!

    var newPwdTextField : UITextField!
    var newPwdLine : UIView!
    
    var againPwdTextField : UITextField!
    var againPwdLine : UIView!
    
    var nextBtn : UIButton!

    
    let bag = DisposeBag()
    
 
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
       
        self.view.backgroundColor = .white
        setViews()
        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "忘记密码")
        setActions()
        let p = TRTool.getData(key: "phone") as? String
        if !TRTool.isNullOrEmplty(s: p) {
            phoneTextField!.text = p
        }
    }
    
    private func setActions(){
        nextBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else { return }
            if phoneTextField!.text!.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请输入手机号")
                return
            }
            if phoneTextField!.text!.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请输入注册密码")
                return
            }
            if codeTextField!.text!.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请输入验证码")
                return
            }
            if newPwdTextField!.text!.count < 6 || newPwdTextField!.text!.count > 12 {
                SVProgressHUD.showInfo(withStatus: "请输入6~12位密码")
                return
            }
            if phoneTextField!.text!.count != 11 {
                SVProgressHUD.showInfo(withStatus: "请输入11位手机号")
                return
            }
            if codeTextField!.text!.count != 6 {
                SVProgressHUD.showInfo(withStatus: "请输入6位验证码")
                return
            }
            if !newPwdTextField!.text!.elementsEqual(againPwdTextField!.text!) {
                SVProgressHUD.showInfo(withStatus: "两次密码输入不一致")
                return
            }
            var pw = MZRSA.encryptString(newPwdTextField!.text!, publicKey: rsa_pu_key)
             pw = pw!.replacingOccurrences(of: "\n", with: "")
            pw = pw!.replacingOccurrences(of: "\r", with: "")
            let pars = [
                "phone" : phoneTextField!.text!,
                "newPwd" : pw,
                "code" : codeTextField!.text!
            ]
            SVProgressHUD.show()
            TRNetManager.shared.put_no_lodding(url: URL_User_Forget_Pwd, pars: pars) {[weak self] dict in
                guard let self = self else {return}
                guard let model = TRCodeModel.deserialize(from: dict) else {return}
                if model.code == 1 {
                    SVProgressHUD.showSuccess(withStatus: "密码找回成功")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                }
            }
        }).disposed(by: bag)
        
        codeTextField!.rx.text.subscribe(onNext: {[weak self] (t) in
            guard let self  = self  else { return }
            if !TRTool.isNullOrEmplty(s: t) {
                if t!.count > 6 {
                    let tempT = t as! NSString
                    codeTextField!.text = tempT.substring(to: 6)
                }
            }
        }).disposed(by: bag)
        phoneTextField.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.phoneLine.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        phoneTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.phoneLine.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        codeTextField.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.codeLine.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        codeTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.codeLine.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        againPwdTextField.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.againPwdLine.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        againPwdTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.againPwdLine.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        newPwdTextField.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.newPwdLine.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        newPwdTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.newPwdLine.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        sendCodeBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self else { return }
            if phoneTextField.text == nil || phoneTextField.text!.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请输入手机号")
                return
            }
            let pars = ["phone":phoneTextField!.text!]
          
            TRNetManager.shared.userAuthService(url: URL_Send_Code, method: .get, pars: pars) {[weak self] dict in
                guard let self = self else {return}
                guard let model = TRCodeModel.deserialize(from: dict) else {return}
                if model.code == 1 {
                    TRGCDTimer.share.destoryTimer(withName: "sendLoginCode1")
                    self.sendCodeBtn!.isUserInteractionEnabled = false
                    
                    SVProgressHUD.showSuccess(withStatus: "验证码发送成功")
                    var time = Time_Send_Code
                    TRGCDTimer.share.createTimer(withName: "sendLoginCode1", timeInterval: 1, queue: .main, repeats: true) {
                        time -= 1
                        if time <= 0 {
                            self.sendCodeBtn!.isUserInteractionEnabled = true
                            self.sendCodeBtn!.setTitle("重新发送", for: .normal)
                            TRGCDTimer.share.destoryTimer(withName: "sendLoginCode1")
                        } else {
                            self.sendCodeBtn!.setTitle("\(time)" + "s", for: .normal)
                        }
                    }
                } else {
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                }
            }
  
        }).disposed(by: bag)
        
    }
    
                             
        private func setViews(){
            let layerView = UIView()
            layerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 96)
            // fillCode
            let bgLayer1 = CAGradientLayer()
            bgLayer1.colors = [UIColor(red: 0.58, green: 1, blue: 0.91, alpha: 0.05).cgColor, UIColor(red: 0.15, green: 0.98, blue: 0.56, alpha: 0.03).cgColor]
            bgLayer1.locations = [0, 1]
            bgLayer1.frame = layerView.bounds
            bgLayer1.startPoint = CGPoint(x: 0, y: 0.5)
            bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
            layerView.layer.addSublayer(bgLayer1)
            view.addSubview(layerView)
            
            
            phoneTipLab = UILabel()
            phoneTipLab.text = "手机号"
            phoneTipLab.isHidden = false
            phoneTipLab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
            phoneTipLab.font = .systemFont(ofSize: 12)
            
            view.addSubview(phoneTipLab!)
            
            
            phoneTextField = LimitedInputTextFiled()
            phoneTextField.m_limitType = .init(2)
            phoneTextField.clearButtonMode = .whileEditing
            phoneTextField.textColor = UIColor.hexColor(hexValue: 0x141414)
            phoneTextField.font = .systemFont(ofSize: 16)
            phoneTextField.placeholder = "请输入手机号"
            phoneTextField.keyboardType = .phonePad
            
            view.addSubview(phoneTextField!)
            
            phoneLine = UIView();
            phoneLine.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
            view.addSubview(phoneLine!)
            
            codeTipLab = UILabel()
            codeTipLab.isHidden = true
            codeTipLab.text = "验证码输入错误"
            codeTipLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
            codeTipLab.font = .systemFont(ofSize: 12)
            codeTipLab.isHidden = true
            view.addSubview(codeTipLab!)
            
            codeTextField = UITextField()
            codeTextField.textColor = UIColor.hexColor(hexValue: 0x141414)
            codeTextField.font = .systemFont(ofSize: 16)
            codeTextField.placeholder = "请输入验证码"
            codeTextField.keyboardType = .numberPad
            view.addSubview(codeTextField!)
            
            codeLine = UIView();
            codeLine.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
            view.addSubview(codeLine!)
            
            sendCodeBtn = UIButton();
            sendCodeBtn.setTitle("发送验证码", for: .normal)
            sendCodeBtn.setTitleColor(UIColor.hexColor(hexValue: 0x13D066), for: .normal)
            sendCodeBtn.backgroundColor = UIColor.hexColor(hexValue: 0xE4FBEE)
            sendCodeBtn.layer.masksToBounds = true
            sendCodeBtn.layer.cornerRadius = 15;
            sendCodeBtn.titleLabel?.font = .systemFont(ofSize: 13)
            view.addSubview(sendCodeBtn!)
            
            newPwdTextField = UITextField()
            newPwdTextField.clearButtonMode = .whileEditing
            newPwdTextField.textColor = UIColor.hexColor(hexValue: 0x141414)
            newPwdTextField.font = .systemFont(ofSize: 16)
            newPwdTextField.placeholder = "新密码"
            newPwdTextField!.keyboardType = .asciiCapable
            view.addSubview(newPwdTextField!)
            newPwdLine = UIView();
            newPwdLine.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
            view.addSubview(newPwdLine!)
            
            againPwdTextField = UITextField()
            againPwdTextField.clearButtonMode = .whileEditing
            againPwdTextField.textColor = UIColor.hexColor(hexValue: 0x141414)
            againPwdTextField.font = .systemFont(ofSize: 16)
            againPwdTextField.placeholder = "确认新密码"
            againPwdTextField!.keyboardType = .asciiCapable
            view.addSubview(againPwdTextField!)
            againPwdLine = UIView();
            againPwdLine.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
            view.addSubview(againPwdLine!)
         
            nextBtn = UIButton()
            nextBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
            nextBtn.setTitle("提交", for: .normal)
            nextBtn.titleLabel?.font = .systemFont(ofSize: 18)
            nextBtn.setTitleColor(.white, for: .normal)
            let bgLayer = CALayer()
            bgLayer.frame = layerView.bounds
            bgLayer.backgroundColor = UIColor(red: 0.07, green: 0.82, blue: 0.4, alpha: 1).cgColor
            nextBtn.layer.addSublayer(bgLayer1)
            // shadowCode
            nextBtn.layer.shadowColor = UIColor(red: 0.36, green: 1, blue: 0.55, alpha: 0.25).cgColor
            nextBtn.layer.shadowOffset = CGSize(width: 0, height: 7)
            nextBtn.layer.shadowOpacity = 1
            nextBtn.layer.shadowRadius = 17
            
            view.addSubview(nextBtn!)
            
            phoneTipLab.snp.makeConstraints({ make in
                make.left.equalTo(view).offset(16)
                make.top.equalTo(self.view).offset(Nav_Height + 30)
                
            })
            
            phoneTextField.snp.makeConstraints { make in
                make.left.equalTo(view).offset(16)
                make.top.equalTo(phoneTipLab.snp.bottom).offset(10)
                make.height.equalTo(25)
                make.right.equalTo(view).inset(16)
            }
            phoneLine.snp.makeConstraints { make in
                make.left.right.equalTo(view).inset(16)
                make.height.equalTo(1)
                make.bottom.equalTo(phoneTextField!).offset(3)
            }
            
            codeTipLab.snp.makeConstraints { make in
                make.left.equalTo(view).offset(16)
                make.top.equalTo(phoneLine!).offset(16)
                make.right.equalTo(view).inset(16)
            }
            codeTextField.snp.makeConstraints { make in
                make.left.equalTo(view).offset(16)
                make.top.equalTo(phoneLine!).offset(40)
                make.height.equalTo(25)
                make.right.equalTo(view).inset(16)
            }
            sendCodeBtn.snp.makeConstraints({ make in
                make.bottom.equalTo(codeTextField!).inset(3)
                make.right.equalTo(codeTextField!)
                make.height.equalTo(30)
                make.width.equalTo(76)
            })
            codeLine.snp.makeConstraints { make in
                make.left.right.equalTo(view).inset(16)
                make.height.equalTo(1)
                make.bottom.equalTo(codeTextField!).offset(3)
            }
            
            newPwdTextField.snp.makeConstraints { make in
                make.left.equalTo(view).offset(16)
                make.top.equalTo(codeLine!).offset(40)
                make.height.equalTo(25)
                make.right.equalTo(view).inset(16)
            }
            newPwdLine.snp.makeConstraints { make in
                make.left.right.equalTo(view).inset(16)
                make.height.equalTo(1)
                make.bottom.equalTo(newPwdTextField!).offset(3)
            }
            againPwdTextField.snp.makeConstraints { make in
                make.left.equalTo(view).offset(16)
                make.top.equalTo(newPwdLine!).offset(40)
                make.height.equalTo(25)
                make.right.equalTo(view).inset(16)
            }
            againPwdLine.snp.makeConstraints { make in
                make.left.right.equalTo(view).inset(16)
                make.height.equalTo(1)
                make.bottom.equalTo(againPwdTextField!).offset(3)
            }
            
            nextBtn.snp.makeConstraints({ make in
                make.left.right.equalTo(view).inset(16)
                make.top.equalTo(againPwdLine.snp.bottom).offset(50)
                make.height.equalTo(46)
            })
            nextBtn.layer.cornerRadius = 23
            nextBtn.layer.masksToBounds = true
        
    }

}

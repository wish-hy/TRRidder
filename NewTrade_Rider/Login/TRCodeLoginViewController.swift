//
//  TRCodeLoginViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/4.
//

import UIKit
import RxSwift
import RxCocoa
class TRCodeLoginViewController: BasicViewController {
    var phoneTipLab : UILabel!
    var phoneTextField : LimitedInputTextFiled!
    var phoneLine : UIView!
    
    var codeTipLab : UILabel!
    var codeTextField : UITextField!
    var codeLine : UIView!
    var sendCodeBtn : UIButton!
    
    var agreeBtn : UIButton!
    var agreeLab : UILabel!
    var agreeLab1 : UILabel!
    var xyLab : UILabel!
    var zcLab : UILabel!
    var loginBtn : UIButton!
    
    var passwrodLoginBtn : UIButton!
    var noCodeBtn : UIButton!
    var wxLoginBtn : UIButton!
    
    var registerBtn : UIButton!
    var registerImg : UIImageView!
    
    let bag = DisposeBag()
    
    var isAgree : Bool = false
    var timer : Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setViews()
        setActions()
        self.view.backgroundColor = .white

        let p = TRTool.getData(key: "phone") as? String
        if !TRTool.isNullOrEmplty(s: p) {
            phoneTextField!.text = p
        }
        
        
        #if DEBUG
        let port = TRTool.getData(key: "Chat_Port") as? Int ?? 7214
        var title = "服务器：正式"
        if port == 7214 {
            title = "当前：测试环境"
        } else {
            title = "当前：正式环境"
        }
        let btn = TRFactory.buttonWith(title: title, textColor: .txtColor(), font: .trFont(12), superView: self.view)

        btn.alpha = 0.75
        btn.addTarget(self, action: #selector(switchFunc), for: .touchUpInside)
        btn.backgroundColor = .green
        btn.frame = CGRect(x: Screen_Width - 88, y: self.view.center.y + 90, width: 88, height: 25)
        #endif
        
        
    }
    @objc func switchFunc(b : UIButton){
        let t = b.titleLabel!.text

        let alertVC = UIAlertController(title: "切换服务器", message: "切换后需要重启APP", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in
            
        }
        let doneAction = UIAlertAction(title: "确认", style: .destructive) { _ in
            if t!.elementsEqual("当前：正式环境") {
                TRTool.saveData(value: "http://yunen.test.brjkj.cn:30001/auth-service", key: "BASIC_Login_URL")
                TRTool.saveData(value: "http://yunen.test.brjkj.cn:30001/rider-backend-api-service", key: "BASIC_URL")
                TRTool.saveData(value: "http://yunen.test.brjkj.cn:8000/gamma-h5/pages/DisH5Item", key: "Web_Basic_URL")
                TRTool.saveData(value: "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIPYrEGRt50AlytqwWgTOJFpJUw07t71Mss4ZCqA72W0G0ZmvwwPOTXrU2cUyGWQOoXNAJ23nMk4uNWKMNkRqUcCAwEAAQ==", key: "rsa_pu_key")
                TRTool.saveData(value: "192.168.1.29", key: "Chat_IP")
                TRTool.saveData(value: 7214, key: "Chat_Port")
                TRTool.saveData(value: "http://yunen.test.brjkj.cn:30001/minio-service", key: "BASIC_UpPic_URL")

            } else {
                /*
                 let BASIC_Login_URL = "https://api.fmyunwei.com/auth-service"
                 let BASIC_URL = "https://api.fmyunwei.com/rider-backend-api-service"
                 let Web_Basic_URL = "https://fmyunwei.com/gamma-h5/pages/DisH5Item"
                 let rsa_pu_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAHNqFodMvt1xUSWdfYPa8UO643QvWt6O5e24jfeUbpbjW4lIHZ1WgtaCREnPno7SO4Ic62f53Tzp5bDV6P0lMz/p6+ybwTz8SJFpiE3UE6jBdnqGgcyRN+ZdTLxLEbaomHAqjA5zAyzukuyMrQp0R8HmA+HvKKT/xsV7trOFRZwIDAQAB"
                 let Chat_IP = "139.9.101.147"
                 let Chat_Port = 30214
                 */
                TRTool.saveData(value: "https://api.fmyunwei.com/auth-service", key: "BASIC_Login_URL")
                TRTool.saveData(value: "https://api.fmyunwei.com/rider-backend-api-service", key: "BASIC_URL")
                TRTool.saveData(value: "https://fmyunwei.com/gamma-h5/pages/DisH5Item", key: "Web_Basic_URL")
                TRTool.saveData(value: "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAHNqFodMvt1xUSWdfYPa8UO643QvWt6O5e24jfeUbpbjW4lIHZ1WgtaCREnPno7SO4Ic62f53Tzp5bDV6P0lMz/p6+ybwTz8SJFpiE3UE6jBdnqGgcyRN+ZdTLxLEbaomHAqjA5zAyzukuyMrQp0R8HmA+HvKKT/xsV7trOFRZwIDAQAB", key: "rsa_pu_key")
                TRTool.saveData(value: "139.9.101.147", key: "Chat_IP")
                TRTool.saveData(value: 30214, key: "Chat_Port")
                
                TRTool.saveData(value: "https://api.fmyunwei.com/minio-service", key: "BASIC_UpPic_URL")

            }
            exit(1)
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(doneAction)
        self.present(alertVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAgree = TRTool.getData(key: Save_IS_Agree) as? Bool ?? false
        if (self.isAgree) {
            self.agreeBtn?.setImage(UIImage(named: "select"), for: .normal)
        } else{
            self.agreeBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
        }
        showPrivacyView()
    }
    private func showPrivacyView(){
        
        if !isAgree {
            let privyTipView = TRPriVacyTipView(frame: .zero)
            privyTipView.addToWindow()
            privyTipView.block = {[weak self] index in
                guard let self = self else { return }
                if index == 1 {
                    TRTool.saveData(value: true, key: Save_IS_Agree)
                    self.isAgree = true
                    self.agreeBtn?.setImage(UIImage(named: "select"), for: .normal)
                } else if index == 2 {
                    
                    let webVC = TRWebViewController()
                    webVC.type = .txt_service
                    webVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(webVC, animated: true)
                } else if index == 3 {
                    let webVC = TRWebViewController()
                    webVC.type = .txt_privacy
                    webVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(webVC, animated: true)
                }
            }
            
        }
      
    }
    private func setActions(){
        registerBtn!.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self else { return }
            //暂没做
            print("注册")
        }).disposed(by: bag)
        phoneTextField!.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            guard let self  = self  else { return }
            phoneLine!.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        phoneTextField!.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            guard let self  = self  else { return }
            self.phoneLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        codeTextField!.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            guard let self  = self  else { return }
            self.codeLine!.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        codeTextField!.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            guard let self  = self  else { return }
            self.codeLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        sendCodeBtn!.rx.tap.subscribe(onNext:{[weak self] in
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
                    TRGCDTimer.share.destoryTimer(withName: "sendLoginCode")
                    self.sendCodeBtn!.isUserInteractionEnabled = false
                    
                    SVProgressHUD.showSuccess(withStatus: "验证码发送成功")
                    var time = Time_Send_Code
                    TRGCDTimer.share.createTimer(withName: "sendLoginCode", timeInterval: 1, queue: .main, repeats: true) {
                        time -= 1
                        if time <= 0 {
                            self.sendCodeBtn!.isUserInteractionEnabled = true
                            self.sendCodeBtn!.setTitle("重新发送", for: .normal)
                            TRGCDTimer.share.destoryTimer(withName: "sendLoginCode")
                        } else {
                            self.sendCodeBtn!.setTitle("\(time)" + "s", for: .normal)
                        }
                    }
                } else {
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                }
            }
  
            
        }).disposed(by: bag)

        agreeBtn!.rx.tap.subscribe(onNext : {[weak self] in
            guard let self = self else { return }
            self.isAgree = !self.isAgree
            if (self.isAgree) {
                TRTool.saveData(value: true, key: Save_IS_Agree)

                self.agreeBtn?.setImage(UIImage(named: "select"), for: .normal)
            } else{
                TRTool.saveData(value: false, key: Save_IS_Agree)

                self.agreeBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
        }).disposed(by: bag)
        
        let xyGes = UITapGestureRecognizer()
        let zcGes = UITapGestureRecognizer()
        xyLab.addGestureRecognizer(xyGes)
        zcLab.addGestureRecognizer(zcGes)
        xyGes.rx.event.debug("Tap").subscribe(onNext : {[weak self] _ in
            guard let self  = self  else { return }
            let vc = TRWebViewController()
            vc.type = .txt_service
            self.navigationController?.pushViewController(vc , animated: true)
        }).disposed(by: bag)
        zcGes.rx.event.debug("Tap").subscribe(onNext : {[weak self] _ in
            guard let self  = self  else { return }
            let vc = TRWebViewController()
            vc.type = .txt_privacy
            self.navigationController?.pushViewController(vc , animated: true)
        }).disposed(by: bag)
        loginBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self = self else { return }
            let account = phoneTextField.text
            let code = codeTextField.text
            if !isAgree {
                showPrivacyView()

                return
            }
            if TRTool.isNullOrEmplty(s: account) {
                SVProgressHUD.showInfo(withStatus: "请输入手机号")
                return
            }
            if TRTool.isNullOrEmplty(s: code) {
                SVProgressHUD.showInfo(withStatus: "请输入验证码")
                return
            }
            if code!.count != 6 {
                SVProgressHUD.showInfo(withStatus: "请输入6位验证码")
                return
            }
            if account!.count != 11 {
                SVProgressHUD.showInfo(withStatus: "请输入11位手机号")
                return
            }
            TRTool.saveData(value: phoneTextField!.text!, key: "phone")

            let channelEnum = "RIDER_SYS"
            let clientEnum = "IOS"
            let subPars = [
                "code" : code,
                "phone" : account,
                "clientEnum" : clientEnum,
                "channelEnum" : channelEnum,
                /*"deviceId" : TRTool.getUUID(),
                "mac" : TRTool.getMacInfo()*/
            ]
            SVProgressHUD.show()
            TRNetManager.shared.userAuthService(url: URL_User_Login_Code, method: .post, pars: subPars) {[weak self] dict in
                guard let self = self else {return}
                guard let model = TRCodeModel.deserialize(from: dict) else {return}
                if model.code == 1 {
//                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    TRTool.saveData(value: model.data as! String, key: Save_Key_Token)
                    NotificationCenter.default.post(name: .init("loginSuccess"), object: nil)
//                    let tabBar = TRTabBarViewController()
//                    UIApplication.shared.keyWindow!.rootViewController = tabBar
                } else if model.exceptionCode == Net_Code_User_Not_Exist{
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                    let vc = TRSetPasswordViewController()
                    vc.phone = phoneTextField.text!
                    vc.code = codeTextField.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                }
            }
          
        }).disposed(by: bag)
        codeTextField!.rx.text.subscribe(onNext: {[weak self] (t) in
            guard let self  = self  else { return }
            if !TRTool.isNullOrEmplty(s: t) {
                if t!.count > 6 {
                    let tempT = t! as NSString
                    codeTextField!.text = tempT.substring(to: 6)
                }
            }
        }).disposed(by: bag)
        passwrodLoginBtn.rx.tap.subscribe(onNext : {[weak self]  in
            guard let self  = self  else { return }

            
            TRTool.saveData(value: phoneTextField!.text!, key: "phone")
            self.navigationController?.popToViewController(self.navigationController!.viewControllers[0], animated: false)
        }).disposed(by: bag)
        
        noCodeBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
        }).disposed(by: bag)
        wxLoginBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self = self  else { return }
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
        
        let methodLab = UILabel()
        methodLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        methodLab.text = "验证码登录"
        methodLab.font = .boldSystemFont(ofSize: 26)
        view.addSubview(methodLab)
        
        phoneTipLab = UILabel()
        phoneTipLab.text = "请输入正确的手机号"
        phoneTipLab.isHidden = true
        phoneTipLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        phoneTipLab.font = .systemFont(ofSize: 12)
        phoneTipLab.isHidden = true
        
        view.addSubview(phoneTipLab!)
        
        registerBtn = UIButton()
        registerBtn.setTitle("立即前往注册", for: .normal)
        registerBtn.setTitleColor(UIColor.hexColor(hexValue: 0x23B1F5), for: .normal)
        registerBtn.titleLabel!.font = .systemFont(ofSize: 12)
        
        registerImg = UIImageView(image: UIImage(named: "advance"))
        view.addSubview(registerImg!)
        view.addSubview(registerBtn!)
        registerBtn.isHidden = true
        registerImg.isHidden = true
        
        phoneTextField = LimitedInputTextFiled()
        phoneTextField.m_limitType = .init(2)
        phoneTextField.clearButtonMode = .whileEditing
        phoneTextField.textColor = UIColor.hexColor(hexValue: 0x141414)
        phoneTextField.font = .systemFont(ofSize: 16)
        phoneTextField.placeholder = "请输入手机号"
        phoneTextField.keyboardType = .phonePad

        view.addSubview(phoneTextField!)
        
        phoneLine = UIView();
        phoneLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
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
        codeLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        view.addSubview(codeLine!)
        
        sendCodeBtn = UIButton();
        sendCodeBtn.setTitle("发送验证码", for: .normal)
        sendCodeBtn.setTitleColor(UIColor.hexColor(hexValue: 0x13D066), for: .normal)
        sendCodeBtn.backgroundColor = UIColor.hexColor(hexValue: 0xE4FBEE)
        sendCodeBtn.layer.masksToBounds = true
        sendCodeBtn.layer.cornerRadius = 15;
        sendCodeBtn.titleLabel!.font = .systemFont(ofSize: 13)
        view.addSubview(sendCodeBtn!)
        
        agreeBtn = UIButton()
        agreeBtn.setImage(UIImage(named: "uncheck"), for: .normal)
        view.addSubview(agreeBtn!)
        agreeLab = UILabel()
        agreeLab.textColor = UIColor.hexColor(hexValue: 0xc6c8cb)
        agreeLab.font = .systemFont(ofSize: 14)
        agreeLab.text = "我已阅并同意";
        
        agreeLab1 = UILabel()
        agreeLab1.textColor = UIColor.hexColor(hexValue: 0xc6c8cb)
        agreeLab1.font = .systemFont(ofSize: 14)
        agreeLab1.text = "和";
        view.addSubview(agreeLab1!)
        
        xyLab = UILabel()
        xyLab.textColor = UIColor.hexColor(hexValue: 0x3596FB)
        xyLab.font = .systemFont(ofSize: 14)
        xyLab.text = "《用户协议》";
        xyLab.isUserInteractionEnabled = true
        view.addSubview(xyLab!)
        
        zcLab = UILabel()
        zcLab.textColor = UIColor.hexColor(hexValue: 0x3596FB)
        zcLab.isUserInteractionEnabled = true
        zcLab.font = .systemFont(ofSize: 14)
        zcLab.text = "《隐私政策》";
        view.addSubview(zcLab!)
        
        agreeLab = UILabel()
        agreeLab.textColor = UIColor.hexColor(hexValue: 0xc6c8cb)
        agreeLab.font = .systemFont(ofSize: 14)
        agreeLab.text = "我已阅并同意";
        
        view.addSubview(agreeLab!)
        
        loginBtn = UIButton()
        loginBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.titleLabel!.font = .systemFont(ofSize: 18)
        loginBtn.setTitleColor(.white, for: .normal)
        let bgLayer = CALayer()
        bgLayer.frame = layerView.bounds
        bgLayer.backgroundColor = UIColor(red: 0.07, green: 0.82, blue: 0.4, alpha: 1).cgColor
        loginBtn.layer.addSublayer(bgLayer1)
        // shadowCode
        loginBtn.layer.shadowColor = UIColor(red: 0.36, green: 1, blue: 0.55, alpha: 0.25).cgColor
        loginBtn.layer.shadowOffset = CGSize(width: 0, height: 7)
        loginBtn.layer.shadowOpacity = 1
        loginBtn.layer.shadowRadius = 17
        
        view.addSubview(loginBtn!)
        
        passwrodLoginBtn = UIButton();
        passwrodLoginBtn.setImage(UIImage(named: "password"), for: .normal)
        passwrodLoginBtn.setTitle("密码登录", for: .normal)
        passwrodLoginBtn.titleLabel!.font = .systemFont(ofSize: 16)
        passwrodLoginBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        view.addSubview(passwrodLoginBtn!)
        
        noCodeBtn = UIButton()
        noCodeBtn.isHidden = true
        noCodeBtn.setTitle("收不到验证码？", for: .normal)
        noCodeBtn.titleLabel!.font = .systemFont(ofSize: 13)
        noCodeBtn.setTitleColor(UIColor.hexColor(hexValue: 0x868788), for: .normal)
        view.addSubview(noCodeBtn!)
        
        wxLoginBtn = UIButton();
        wxLoginBtn.isHidden = true
        wxLoginBtn.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f3)
        wxLoginBtn.setImage(UIImage(named: "weixin"), for: .normal)
        wxLoginBtn.layer.masksToBounds = true;
        wxLoginBtn.layer.cornerRadius = 28
        view.addSubview(wxLoginBtn!)
        wxLoginBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self  else { return }
           //微信登录
        }).disposed(by: bag)
        
        methodLab.snp.makeConstraints { make in
            make.top.equalTo(view).offset(114)
            make.left.equalTo(view).offset(16)
        }
        
        phoneTipLab!.snp.makeConstraints({ make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(methodLab.snp.bottom).offset(53)
            
        })
        registerBtn!.snp.makeConstraints({ make in
            make.centerY.equalTo(phoneTipLab)
            make.left.equalTo(phoneTipLab.snp.right)
            make.height.equalTo(20)
        })
        registerImg!.snp.makeConstraints({ make in
            make.centerY.equalTo(phoneTipLab)
            make.left.equalTo(registerBtn!.snp.right)
            
        })
        phoneTextField!.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(methodLab.snp_bottomMargin).offset(80)
            make.height.equalTo(25)
            make.right.equalTo(view).inset(16)
        }
        phoneLine!.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(phoneTextField).offset(3)
        }
        
        codeTipLab!.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(phoneLine).offset(16)
            make.right.equalTo(view).inset(16)
        }
        codeTextField!.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(phoneLine).offset(40)
            make.height.equalTo(25)
            make.right.equalTo(view).inset(16)
        }
        sendCodeBtn!.snp.makeConstraints({ make in
            make.bottom.equalTo(codeTextField).inset(3)
            make.right.equalTo(codeTextField)
            make.height.equalTo(30)
            make.width.equalTo(76)
        })
        codeLine!.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(codeTextField).offset(3)
        }
        
        agreeBtn!.snp.makeConstraints({ make in
            make.width.height.equalTo(20)
            make.top.equalTo(codeLine).offset(40)
            make.left.equalTo(view).offset(16)
        })
        agreeLab!.snp.makeConstraints({ make in
            make.top.equalTo(codeLine).offset(42)
            make.left.equalTo(agreeBtn.snp.right).offset(3)
        })
        xyLab!.snp.makeConstraints({ make in
            make.centerY.equalTo(agreeLab)
            make.left.equalTo(agreeLab.snp.right).offset(0)
            make.height.equalTo(15)
        })
        agreeLab1!.snp.makeConstraints({ make in
            make.top.equalTo(codeLine).offset(42)
            make.left.equalTo(xyLab.snp.right).offset(3)
        })
        zcLab!.snp.makeConstraints({ make in
            make.centerY.equalTo(agreeLab)
            make.left.equalTo(agreeLab1.snp.right).offset(0)
            make.height.equalTo(15)
        })
        
        loginBtn!.snp.makeConstraints({ make in
            make.left.right.equalTo(view).inset(16)
            make.top.equalTo(agreeBtn.snp.bottom).offset(20)
            make.height.equalTo(46)
        })
        loginBtn.layer.cornerRadius = 23
        loginBtn.layer.masksToBounds = true
        passwrodLoginBtn.snp.makeConstraints({ make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
        })
        noCodeBtn!.snp.makeConstraints({ make in
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
            make.right.equalTo(view).inset(16)
        })
        
        wxLoginBtn!.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).inset(85)
            make.height.equalTo(56)
            make.width.equalTo(56)
        }
        
    }
}

//
//  TRCodeInputViewController.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/1/25.
//

import UIKit

class TRCodeInputViewController: BasicViewController {
    var phone : String = ""
    var pw : String = ""
    
    var sendCodeBtn : UIButton!
    var codeView : TRCodeInputView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        configNavBar()
        configNavLeftBtn()
        sendCode()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    private func registerAction(){
        let pars = [
            "phone" : phone,
            "password" : pw,
            "smsCode" : codeView.getStr()
        ]
        SVProgressHUD.show()
        TRNetManager.shared.post_no_lodding(url: URL_User_Register, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
//                SVProgressHUD.showSuccess(withStatus: "注册成功")
//                self.navigationController?.popViewController(animated: true)
                loginAction()
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    private func loginAction(){
        let pars = [
            "account" : phone,
            "password" : pw,
            "channelEnum" : APP_Platform,
            "clientEnum" : "IOS",
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
                NotificationCenter.default.post(name: .init("loginSuccess"), object: nil)
//                let tabBar = TRTabBarViewController()
//                UIApplication.shared.keyWindow?.rootViewController = tabBar
            }  else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    @objc private func sendCode(){
 
        let pars = ["phone":phone]
      
        TRNetManager.shared.userAuthService(url: URL_Send_Code, method: .get, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                TRGCDTimer.share.destoryTimer(withName: "sendLoginCode2")
                self.sendCodeBtn!.isUserInteractionEnabled = false
                //phone
                SVProgressHUD.showSuccess(withStatus: "验证码发送成功")
                var time = Time_Send_Code
                TRGCDTimer.share.createTimer(withName: "sendLoginCode2", timeInterval: 1, queue: .main, repeats: true) {
                    time -= 1
                    if time <= 0 {
                        self.sendCodeBtn!.isUserInteractionEnabled = true
                        self.sendCodeBtn!.setTitle("重新发送", for: .normal)
                        TRGCDTimer.share.destoryTimer(withName: "sendLoginCode2")
                    } else {
                        self.sendCodeBtn!.setTitle("重新发送(\(time))" + "s", for: .normal)
                    }
                }
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
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
        methodLab.text = "请输入6位验证码"
        methodLab.font = .boldSystemFont(ofSize: 26)
        view.addSubview(methodLab)
        
        let phoneLab = UILabel()
        phoneLab.attributedText = TRTool.richText(str1: "验证码已发送至 ", font1: .trFont(14), color1: .hexColor(hexValue: 0x97989A), str2: "\(phone)", font2: .trMediumFont(14), color2: .txtColor())
        view.addSubview(phoneLab)
        
        sendCodeBtn = TRFactory.buttonWith(title: "重新发送(56s)", textColor: .hexColor(hexValue: 0x97989A), font: .trFont(14), superView: view)
        sendCodeBtn.addTarget(self, action: #selector(sendCode), for: .touchUpInside)
        codeView = TRCodeInputView(frame: .zero)
        view.addSubview(codeView)
        codeView.doneBlock = {[weak self] in
            guard let self = self else {return}
            registerAction()
            
        }
        methodLab.snp.makeConstraints { make in
            make.top.equalTo(view).offset(114)
            make.left.equalTo(view).offset(16)
        }
        phoneLab.snp.makeConstraints { make in
            make.left.equalTo(methodLab)
            make.top.equalTo(methodLab.snp.bottom).offset(14)
        }
        sendCodeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(phoneLab)
            make.right.equalTo(self.view).inset(16)
            make.height.equalTo(28)
        }
        codeView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(phoneLab.snp.bottom).offset(50)
            
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

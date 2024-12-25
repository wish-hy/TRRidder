//
//  TRChangePhoneNewViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit
import RxSwift
import RxCocoa
class TRChangePhoneNewViewController: BasicViewController {

    var phoneTipLab : UILabel?
    var phoneTextField : LimitedInputTextFiled?
    var phoneLine : UIView?
    
    var codeTipLab : UILabel?
    var codeTextField : UITextField?
    var codeLine : UIView?
    var sendCodeBtn : UIButton?

    var doneBtn : UIButton?

    
    let bag = DisposeBag()
    
 
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        //第二步暂时不要
        setViews()
        setActions()
        configNavLeftBtn()
        let p = TRTool.getData(key: "phone") as? String
        if !TRTool.isNullOrEmplty(s: p) {
            phoneTextField!.text = p
        }
    }
    
    private func setActions(){
        doneBtn?.rx.tap.subscribe(onNext: {[weak self] in
            self?.navigationController?.popToViewController(self!.navigationController!.viewControllers[1], animated: true)
        }).disposed(by: bag)
        
        phoneTextField!.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            self?.phoneLine?.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        phoneTextField!.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            self?.phoneLine?.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        codeTextField!.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            self?.codeLine?.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        codeTextField!.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            self?.codeLine?.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)

        sendCodeBtn?.rx.tap.subscribe(onNext:{[weak self] in
            TRGCDTimer.share.destoryTimer(withName: "sendxxLoginCode")
            guard let self = self else { return }
            if phoneTextField!.text == nil || phoneTextField!.text!.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请输入手机号")
                return
            }
            let pars = ["phone":phoneTextField!.text!]
          
            TRNetManager.shared.userAuthService(url: URL_Send_Code, method: .get, pars: pars) {[weak self] dict in
                guard let self = self else {return}
                guard let model = TRCodeModel.deserialize(from: dict) else {return}
                if model.code == 1 {
                    TRGCDTimer.share.destoryTimer(withName: "sendxxLoginCode")
                    self.sendCodeBtn!.isUserInteractionEnabled = false
                    
                    SVProgressHUD.showSuccess(withStatus: "验证码发送成功")
                    var time = Time_Send_Code
                    TRGCDTimer.share.createTimer(withName: "sendxxLoginCode", timeInterval: 1, queue: .main, repeats: true) {
                        time -= 1
                        if time <= 0 {
                            self.sendCodeBtn!.isUserInteractionEnabled = true
                            self.sendCodeBtn!.setTitle("重新发送", for: .normal)
                            TRGCDTimer.share.destoryTimer(withName: "sendxxLoginCode")
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
        
        let methodLab = UILabel()
        methodLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        methodLab.text = "更改手机号"
        methodLab.font = .boldSystemFont(ofSize: 26)
        view.addSubview(methodLab)
        
        let numLab = UILabel()
        numLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        numLab.text = "2/2"
        numLab.font = .boldSystemFont(ofSize: 20)
        view.addSubview(numLab)
        
        phoneTipLab = UILabel()
        phoneTipLab?.text = "请输入正确的手机号"
        phoneTipLab?.isHidden = true
        phoneTipLab?.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        phoneTipLab?.font = .systemFont(ofSize: 12)
        phoneTipLab?.isHidden = true
        
        view.addSubview(phoneTipLab!)

        
        phoneTextField = LimitedInputTextFiled()
        phoneTextField!.m_limitType = .init(2)
        phoneTextField!.clearButtonMode = .whileEditing
        phoneTextField!.textColor = UIColor.hexColor(hexValue: 0x141414)
        phoneTextField!.font = .systemFont(ofSize: 16)
        phoneTextField!.placeholder = "请输入手机号"
        phoneTextField!.keyboardType = .numberPad

        view.addSubview(phoneTextField!)
        
        phoneLine = UIView();
        phoneLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        view.addSubview(phoneLine!)
        
        codeTipLab = UILabel()
        codeTipLab?.isHidden = true
        codeTipLab?.text = "验证码输入错误"
        codeTipLab?.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        codeTipLab?.font = .systemFont(ofSize: 12)
        codeTipLab?.isHidden = true
        view.addSubview(codeTipLab!)
        
        codeTextField = UITextField()
        codeTextField!.textColor = UIColor.hexColor(hexValue: 0x141414)
        codeTextField!.font = .systemFont(ofSize: 16)
        codeTextField!.placeholder = "请输入验证码"
        codeTextField!.keyboardType = .numberPad
        view.addSubview(codeTextField!)
        
        codeLine = UIView();
        codeLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        view.addSubview(codeLine!)
        
        sendCodeBtn = UIButton();
        sendCodeBtn?.setTitle("发送验证码", for: .normal)
        sendCodeBtn?.setTitleColor(UIColor.hexColor(hexValue: 0x13D066), for: .normal)
        sendCodeBtn?.backgroundColor = UIColor.hexColor(hexValue: 0xE4FBEE)
        sendCodeBtn?.layer.masksToBounds = true
        sendCodeBtn?.layer.cornerRadius = 15;
        sendCodeBtn?.titleLabel?.font = .systemFont(ofSize: 13)
        view.addSubview(sendCodeBtn!)
                
        doneBtn = UIButton()
        doneBtn!.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        doneBtn!.setTitle("完成", for: .normal)
        doneBtn?.titleLabel?.font = .systemFont(ofSize: 18)
        doneBtn!.setTitleColor(.white, for: .normal)
        let bgLayer = CALayer()
        bgLayer.frame = layerView.bounds
        bgLayer.backgroundColor = UIColor(red: 0.07, green: 0.82, blue: 0.4, alpha: 1).cgColor
        doneBtn!.layer.addSublayer(bgLayer1)
        // shadowCode
        doneBtn!.layer.shadowColor = UIColor(red: 0.36, green: 1, blue: 0.55, alpha: 0.25).cgColor
        doneBtn!.layer.shadowOffset = CGSize(width: 0, height: 7)
        doneBtn!.layer.shadowOpacity = 1
        doneBtn!.layer.shadowRadius = 17
        
        view.addSubview(doneBtn!)
        
 
        
        methodLab.snp.makeConstraints { make in
            make.top.equalTo(view).offset(114)
            make.left.equalTo(view).offset(16)
        }
        numLab.snp.makeConstraints { make in
            make.centerY.equalTo(methodLab)
            make.right.equalTo(view).inset(16)
        }
        phoneTipLab?.snp.makeConstraints({ make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(methodLab.snp.bottom).offset(53)
            
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
            make.bottom.equalTo(phoneTextField!).offset(3)
        }
        
        codeTipLab!.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(phoneLine!).offset(16)
            make.right.equalTo(view).inset(16)
        }
        codeTextField!.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(phoneLine!).offset(40)
            make.height.equalTo(25)
            make.right.equalTo(view).inset(16)
        }
        sendCodeBtn?.snp.makeConstraints({ make in
            make.bottom.equalTo(codeTextField!).inset(3)
            make.right.equalTo(codeTextField!)
            make.height.equalTo(30)
            make.width.equalTo(76)
        })
        codeLine!.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(codeTextField!).offset(3)
        }

        
        doneBtn?.snp.makeConstraints({ make in
            make.left.right.equalTo(view).inset(16)
            make.top.equalTo(codeLine!.snp.bottom).offset(50)
            make.height.equalTo(46)
        })
        doneBtn?.layer.cornerRadius = 23
        doneBtn?.layer.masksToBounds = true

        

        
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

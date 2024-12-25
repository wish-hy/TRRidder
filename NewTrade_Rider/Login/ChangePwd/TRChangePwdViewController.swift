//
//  TRChangePwdViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit
import RxSwift
import RxCocoa
import MZRSA_Swift
class TRChangePwdViewController: BasicViewController {
    var oldPwdTipLab : UILabel?
    var olpPwdTextField : UITextField?
    var oldPwdLine : UIView?

    var newPwdTextField : UITextField?
    var newPwdLine : UIView?
    var forgetBtn : UIButton!
    var againPwdTextField : UITextField?
    var againPwdLine : UIView?
    var nextBtn : UIButton?
    let bag = DisposeBag()
    var timer : Timer?
    
    var newEyeBtn : UIButton!
    var oldEyeBtn : UIButton!
    var againEyeBtn : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.

        
        setViews()
        configNavBar()
        configNavTitle(title: "修改密码")
        configNavLeftBtn()
        setActions()
        
    }
    
    private func setActions(){
        nextBtn?.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else { return }
            if olpPwdTextField!.text!.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请输入旧密码")
                return
            }

            if newPwdTextField!.text!.isEmpty {
                SVProgressHUD.showInfo(withStatus: "请输入新密码")
                return
            }
            if olpPwdTextField!.text!.count < 6 || olpPwdTextField!.text!.count > 12 {
                SVProgressHUD.showInfo(withStatus: "请输入6~12位旧密码")
                return
            }
            if newPwdTextField!.text!.count < 6 || newPwdTextField!.text!.count > 12 {
                SVProgressHUD.showInfo(withStatus: "请输入6~12位新密码")
                return
            }
            if !againPwdTextField!.text!.elementsEqual(newPwdTextField!.text!) {
                SVProgressHUD.showInfo(withStatus: "两次密码输入不一致")
                return
            }
            var pw = MZRSA.encryptString(olpPwdTextField!.text!, publicKey: rsa_pu_key)
             pw = pw!.replacingOccurrences(of: "\n", with: "")
            pw = pw!.replacingOccurrences(of: "\r", with: "")
            
            var npw = MZRSA.encryptString(newPwdTextField!.text!, publicKey: rsa_pu_key)
             npw = npw!.replacingOccurrences(of: "\n", with: "")
            npw = npw!.replacingOccurrences(of: "\r", with: "")
            
            let pars = [
                "newPassword" : npw!,
                "oldPassword" : pw!
            ]
            TRNetManager.shared.put_no_lodding(url: URL_Me_Update_Pwd, pars: pars) {[weak self] dict in
                guard let self = self else {return}
                guard let model = TRCodeModel.deserialize(from: dict) else {return}
                if model.code == 1 {
                    SVProgressHUD.showSuccess(withStatus: "密码修改成功")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                }
            }
        }).disposed(by: bag)
        olpPwdTextField!.rx.text.subscribe(onNext: {[weak self] (t) in
            guard let self  = self  else { return }
            if !TRTool.isNullOrEmplty(s: t) {
                if t!.count > 12 {
                    let tempT = t as! NSString
                    olpPwdTextField!.text = tempT.substring(to: 12)
                }
            }
        }).disposed(by: bag)
        newPwdTextField!.rx.text.subscribe(onNext: {[weak self] (t) in
            guard let self  = self  else { return }
            if !TRTool.isNullOrEmplty(s: t) {
                if t!.count > 12 {
                    let tempT = t as! NSString
                    newPwdTextField!.text = tempT.substring(to: 12)
                }
            }
        }).disposed(by: bag)
        againPwdTextField!.rx.text.subscribe(onNext: {[weak self] (t) in
            guard let self  = self  else { return }
            if !TRTool.isNullOrEmplty(s: t) {
                if t!.count > 12 {
                    let tempT = t as! NSString
                    againPwdTextField!.text = tempT.substring(to: 12)
                }
            }
        }).disposed(by: bag)
        
        forgetBtn.rx.tap.subscribe(onNext: {[weak self] in
           let vc = TRForgetPasswordViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
        olpPwdTextField!.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            self?.oldPwdLine?.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        olpPwdTextField!.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            self?.oldPwdLine?.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        
        againPwdTextField!.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            self?.againPwdLine?.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        againPwdTextField!.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            self?.againPwdLine?.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        }).disposed(by: bag)
        
        newPwdTextField!.rx.controlEvent(.allTouchEvents).subscribe(onNext: { [weak self] in
            self?.newPwdLine?.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            
        }).disposed(by: bag)
        newPwdTextField!.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] in
            self?.newPwdLine?.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
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

        
        oldPwdTipLab = UILabel()
        oldPwdTipLab?.text = "手机号"
        oldPwdTipLab?.isHidden = true
        oldPwdTipLab?.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        oldPwdTipLab?.font = .systemFont(ofSize: 12)
        view.addSubview(oldPwdTipLab!)

        
        olpPwdTextField = UITextField()
//        olpPwdTextField!.clearButtonMode = .whileEditing
        olpPwdTextField!.textColor = UIColor.hexColor(hexValue: 0x141414)
        olpPwdTextField!.font = .systemFont(ofSize: 16)
        olpPwdTextField!.placeholder = "请输入原密码"
        olpPwdTextField?.isSecureTextEntry = true
        olpPwdTextField!.keyboardType = .asciiCapable
        view.addSubview(olpPwdTextField!)
        
        oldPwdLine = UIView();
        oldPwdLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        view.addSubview(oldPwdLine!)
                
        newPwdTextField = UITextField()
//        newPwdTextField!.clearButtonMode = .whileEditing
        newPwdTextField!.textColor = UIColor.hexColor(hexValue: 0x141414)
        newPwdTextField!.font = .systemFont(ofSize: 16)
        newPwdTextField!.placeholder = "新密码"
        newPwdTextField?.isSecureTextEntry = true
        newPwdTextField!.keyboardType = .asciiCapable
        view.addSubview(newPwdTextField!)
        newPwdLine = UIView();
        newPwdLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        view.addSubview(newPwdLine!)
        
        againPwdTextField = UITextField()
        againPwdTextField!.clearButtonMode = .whileEditing
        againPwdTextField!.textColor = UIColor.hexColor(hexValue: 0x141414)
        againPwdTextField!.font = .systemFont(ofSize: 16)
        againPwdTextField!.placeholder = "确认新密码"
//        againPwdTextField!.keyboardType = .numberPad
        againPwdTextField!.isSecureTextEntry = true
        view.addSubview(againPwdTextField!)
        againPwdLine = UIView();
        againPwdLine!.backgroundColor = UIColor.hexColor(hexValue: 0xf1f3f4)
        view.addSubview(againPwdLine!)
 
        forgetBtn = UIButton()
        forgetBtn.setTitle("忘记旧密码？", for: .normal)
        forgetBtn.titleLabel?.font = .systemFont(ofSize: 13)
        forgetBtn.setTitleColor(UIColor.hexColor(hexValue: 0x868788), for: .normal)
        view.addSubview(forgetBtn)

        
        nextBtn = UIButton()
        nextBtn!.backgroundColor = .lightThemeColor()
        nextBtn!.setTitle("提交", for: .normal)
        nextBtn?.titleLabel?.font = .systemFont(ofSize: 18)
        nextBtn!.setTitleColor(.white, for: .normal)
        let bgLayer = CALayer()
        bgLayer.frame = layerView.bounds
        bgLayer.backgroundColor = UIColor(red: 0.07, green: 0.82, blue: 0.4, alpha: 1).cgColor
        nextBtn!.layer.addSublayer(bgLayer1)
        // shadowCode
        nextBtn!.layer.shadowColor = UIColor(red: 0.36, green: 1, blue: 0.55, alpha: 0.25).cgColor
        nextBtn!.layer.shadowOffset = CGSize(width: 0, height: 7)
        nextBtn!.layer.shadowOpacity = 1
        nextBtn!.layer.shadowRadius = 17
        
        view.addSubview(nextBtn!)
        newEyeBtn = UIButton();
        newEyeBtn!.setImage(UIImage(named: "hidden"), for: .normal)
        view.addSubview(newEyeBtn!)
        
        oldEyeBtn = UIButton();
        oldEyeBtn!.setImage(UIImage(named: "hidden"), for: .normal)
        view.addSubview(oldEyeBtn!)
        
        againEyeBtn = UIButton();
        againEyeBtn!.setImage(UIImage(named: "hidden"), for: .normal)
        view.addSubview(againEyeBtn!)
        
        
        oldEyeBtn?.snp.makeConstraints({ make in
            make.centerY.equalTo(newPwdTextField!)
            make.right.equalTo(newPwdTextField!)
            make.height.equalTo(24)
            make.width.equalTo(24)
        })
        newEyeBtn?.snp.makeConstraints({ make in
            make.centerY.equalTo(againPwdTextField!)
            make.right.equalTo(againPwdTextField!)
            make.height.equalTo(24)
            make.width.equalTo(24)
        })
        oldEyeBtn?.rx.tap.subscribe(onNext:{[weak self] in
            guard let self  = self  else { return }
            newPwdTextField!.isSecureTextEntry = !(newPwdTextField!.isSecureTextEntry ?? false)
            if (newPwdTextField!.isSecureTextEntry) {
                oldEyeBtn?.setImage(UIImage(named: "hidden"), for: .normal)
            } else {
                oldEyeBtn?.setImage(UIImage(named: "view"), for: .normal)
            }
        }).disposed(by: bag)
        newEyeBtn?.rx.tap.subscribe(onNext:{[weak self] in
            self?.againPwdTextField?.isSecureTextEntry = !(self?.againPwdTextField?.isSecureTextEntry ?? false)
            if (self!.againPwdTextField!.isSecureTextEntry) {
                self?.newEyeBtn?.setImage(UIImage(named: "hidden"), for: .normal)
            } else {
                self?.newEyeBtn?.setImage(UIImage(named: "view"), for: .normal)
            }
        }).disposed(by: bag)
        

        oldPwdTipLab?.snp.makeConstraints({ make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(self.view).offset(Nav_Height + 30)
            
        })

        olpPwdTextField!.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(oldPwdTipLab!.snp.bottom).offset(10)
            make.height.equalTo(25)
            make.right.equalTo(view).inset(16)
        }
        oldPwdLine!.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(olpPwdTextField!).offset(3)
        }
        
        
        newPwdTextField!.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(oldPwdLine!).offset(40)
            make.height.equalTo(25)
            make.right.equalTo(view).inset(16)
        }
        newPwdLine!.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(newPwdTextField!).offset(3)
        }
        againPwdTextField!.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(newPwdLine!).offset(40)
            make.height.equalTo(25)
            make.right.equalTo(view).inset(16)
        }
        againPwdLine!.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(againPwdTextField!).offset(3)
        }
        
        nextBtn?.snp.makeConstraints({ make in
            make.left.right.equalTo(view).inset(16)
            make.top.equalTo(againPwdLine!.snp.bottom).offset(50)
            make.height.equalTo(46)
        })
        forgetBtn.snp.makeConstraints { make in
            make.top.equalTo(againPwdLine!).offset(10)
            make.right.equalTo(view).inset(16)
        }
        nextBtn?.layer.cornerRadius = 23
        nextBtn?.layer.masksToBounds = true

        

        
    }

}

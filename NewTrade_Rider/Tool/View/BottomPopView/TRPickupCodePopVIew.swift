//
//  TRPickupCodePopVIew.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit

class TRPickupCodePopVIew: TRBottomPopBasicView {

    var tipView : TRBottomPopTipVIew!
    
    var codeTF : UITextField!
    
    var sureBtn : UIButton!
    
    var block : String_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ : )), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ : )), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    override func removeFromSuperview() {
        super.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }
    private func setupSubView(){
        contentView.backgroundColor = .clear
        tipView = TRBottomPopTipVIew(frame: .zero)
        tipView.tipLab.text = "订单设置了收货码验证，送达后请为顾客提供"
        tipView.subViewToTop()
        contentView.addSubview(tipView)
   
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        whiteView.layer.mask = maskLayer;
        contentView.addSubview(whiteView)
        
        let codeTipLab = UILabel()
        codeTipLab.text = "取货码"
        codeTipLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        codeTipLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(codeTipLab)
        
        codeTF = UITextField(frame: .zero)
        codeTF.placeholder = "请输入取货码"
        codeTF.textColor = UIColor.hexColor(hexValue: 0x141414)
        codeTF.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(codeTF)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.masksToBounds = true
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        sureBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        sureBtn.layer.cornerRadius = 10
        sureBtn.layer.masksToBounds = true
        contentView.addSubview(sureBtn)
        
        
        whiteView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(tipView.snp.bottom).inset(18)
            make.height.equalTo(50)
        }
        tipView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(50)
        }
        
        codeTipLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(whiteView).offset(15)
        }
        codeTF.snp.makeConstraints { make in
            make.left.equalTo(codeTipLab)
            make.right.equalTo(contentView)
            make.top.equalTo(codeTipLab.snp.bottom).offset(30)
            make.height.equalTo(30)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(codeTF.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(26)
            make.top.equalTo(line).offset(35)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(26)
            make.top.equalTo(cancelBtn)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
        
        sureBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return  }
            if TRTool.isNullOrEmplty(s: codeTF.text) {
                SVProgressHUD.showInfo(withStatus: "请输入收货码")
                return
            }
            
            if block != nil {
                block!(codeTF.text!)
            }
            closeView()
            
        }).disposed(by: bag)
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return  }
            
            closeView()
        }).disposed(by: bag)
    }
    
    @objc private func keyboardWillShow(_ notification:NSNotification){
        
        let keyBoardShowTime = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! CGFloat
        // 键盘坐标
        
        let keyBoardFrame = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        let h = keyBoardFrame.size.height
        let y = Screen_Height - h  - 66
        
        UIView.animate(withDuration: TimeInterval(keyBoardShowTime), animations: {
            
            self.contentView.frame = CGRect(x: 0, y: Int(Screen_Height) - self.contentHeight - Int(h), width: Int(Screen_Width), height: self.contentHeight)

        })
    
    }
    @objc private func keyboardWillHide(_ notification:NSNotification){
        
        let keyBoardShowTime = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! CGFloat
        // 键盘坐标
        
        let keyBoardFrame = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        let h = keyBoardFrame.size.height
        let y = Screen_Height + (IS_IphoneX ? -25 : 0) - 66
        
        UIView.animate(withDuration: TimeInterval(keyBoardShowTime), animations: {[self]
            
//            self.sendView.frame = CGRect(x: 0, y: y, width: Screen_Width, height: 66)
            self.contentView.frame = CGRect(x: 0, y: Int(Screen_Height) - self.contentHeight, width: Int(Screen_Width), height: self.contentHeight)

        })
    
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

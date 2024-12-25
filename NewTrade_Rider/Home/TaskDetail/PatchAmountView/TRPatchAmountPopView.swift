//
//  TRPatchAmountPopView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/1.
//

import UIKit
import RxSwift
import RxCocoa
class TRPatchAmountPopView: TRBottomPopBasicView {
    var tipView : TRBottomPopTipVIew!
    
    var volBtn : UIButton!
    var weiBtn : UIButton!
    
    var addBtn : UIButton!
    var minusBtn : UIButton!
    
    var priceLab : UILabel!
    
    var valueTF : LimitedInputTextFiled!
    
    var sureBtn : UIButton!
    
    var block : String_Block?
    
    var model : TROrderModel?
    private var currentCount = 0
    private var needChange : Bool = false

    //正在询价
    private var isCaling : Bool = false
    private var currentCalInfoModel : TROrderSubOrderCalInfoModel?
    //输入类型 1 重量 2 体积
    private var type : Int = 1 {
        didSet {
            UIApplication.shared.keyWindow?.endEditing(true)
            if type == 1 {
                weiBtn.setBackgroundImage(UIImage(named: "patch_left_theme"), for: .normal)
                volBtn.setBackgroundImage(UIImage(named: "pathc_right_gray"), for: .normal)
                weiBtn.setBackgroundImage(UIImage(named: "patch_left_theme"), for: .highlighted)
                volBtn.setBackgroundImage(UIImage(named: "pathc_right_gray"), for: .highlighted)
                weiBtn.setTitleColor(.white, for: .normal)
                volBtn.setTitleColor(.txtColor(), for: .normal)
                weiBtn.setTitleColor(.white, for: .highlighted)
                volBtn.setTitleColor(.txtColor(), for: .highlighted)
                typeLab.text = "补重量（公斤）"

            } else {
                weiBtn.setBackgroundImage(UIImage(named: "patch_left_gray"), for: .normal)
                volBtn.setBackgroundImage(UIImage(named: "pathc_right_theme"), for: .normal)
                weiBtn.setBackgroundImage(UIImage(named: "patch_left_gray"), for: .highlighted)
                volBtn.setBackgroundImage(UIImage(named: "pathc_right_theme"), for: .highlighted)
                
                weiBtn.setTitleColor(.txtColor(), for: .normal)
                volBtn.setTitleColor(.white, for: .normal)
                weiBtn.setTitleColor(.txtColor(), for: .highlighted)
                volBtn.setTitleColor(.white, for: .highlighted)
                typeLab.text = "补体积（立方）"

            }
        }
        
    }
    private var typeLab : UILabel!
    //当前值
    private var currentValue = 0
    
    //临时保存
    private var currentWeight : Int = 0
    private var currentVol : Int = 0
    private var currnetWeightPrice : String = "0"
    private var currentVolPrice : String = "0"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ : )), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ : )), name: UIResponder.keyboardWillHideNotification , object: nil)
        setupSubView()
    }
    
    private func setupSubView(){
        contentView.backgroundColor = .clear
        tipView = TRBottomPopTipVIew(frame: .zero)
        tipView.tipLab.text = "当订单超重或超体积时，请与用户进行沟通，司机现场称重或评估后，对订单补重量或补体积。"
        tipView.subViewToTop()
        contentView.addSubview(tipView)
   
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        whiteView.layer.mask = maskLayer
        contentView.addSubview(whiteView)
        
        let titleLab = UILabel()
        titleLab.text = "订单补差价信息"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        weiBtn = TRFactory.buttonWith(title: "补物品重量", textColor: .white, font: .trMediumFont(18), superView: whiteView)
        weiBtn.setBackgroundImage(UIImage(named: "patch_left_theme"), for: .normal)
        weiBtn.setBackgroundImage(UIImage(named: "patch_left_theme"), for: .highlighted)

        volBtn = TRFactory.buttonWith(title: "补物品体积", textColor: .txtColor(), font: .trMediumFont(18), superView: whiteView)
        volBtn.setBackgroundImage(UIImage(named: "pathc_right_gray"), for: .normal)
        volBtn.setBackgroundImage(UIImage(named: "pathc_right_gray"), for: .highlighted)

        typeLab = TRFactory.labelWith(font: .trMediumFont(14), text: "补重量（公斤）", textColor: .txtColor(), superView: whiteView)
        
        addBtn = UIButton()
        addBtn.setBackgroundImage(UIImage(named: "patch_add"), for: .normal)
        addBtn.setBackgroundImage(UIImage(named: "patch_add"), for: .highlighted)

        whiteView.addSubview(addBtn)
        
        minusBtn = UIButton()
        minusBtn.setBackgroundImage(UIImage(named: "patch_mins"), for: .normal)
        minusBtn.setBackgroundImage(UIImage(named: "patch_mins"), for: .highlighted)
        whiteView.addSubview(minusBtn)
        
        
        let valueBgView = UIView()
        valueBgView.backgroundColor = UIColor.hexColor(hexValue: 0xF4F5F7)
        whiteView.addSubview(valueBgView)
        
        valueTF = LimitedInputTextFiled(frame: .zero)
        valueTF.m_limitType = .init(1)
        valueTF.keyboardType = .numberPad
        valueTF.placeholder = "请输入"
        valueTF.textAlignment = .center
        valueTF.textColor = .txtColor()
        valueTF.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(valueTF)
          
        valueTF.rx.text.subscribe { [weak self] txt in
            guard let self = self else {return}
            if !TRTool.isNullOrEmplty(s: txt) {
                let v = Int.init(txt!)
                currentValue = v ?? 0
                countSpadTime()
            } else {
                currentValue = 0
                countSpadTime()
            }
            //输入类型 1 重量 2 体积
            if type == 2 {
                currentVol = currentValue
            } else {
                currentWeight = currentValue
            }
        }.disposed(by: bag)
        
        addBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self else { return }
            UIApplication.shared.keyWindow?.endEditing(true)
            currentValue += 1
            valueTF.text = "\(currentValue)"
            
            if type == 2 {
                currentVol = currentValue
            } else {
                currentWeight = currentValue
            }
            countSpadTime()
        }).disposed(by: bag)
        
        minusBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self else { return }
            UIApplication.shared.keyWindow?.endEditing(true)

            if currentValue <= 1 {return}
            currentValue -= 1
            valueTF.text = "\(currentValue)"
            
            if needChange {
                if type == 2 {
                    currentVol = currentValue
                } else {
                    currentWeight = currentValue
                }
            }
            countSpadTime()
            needChange = true
        }).disposed(by: bag)
        let priceItemLab = TRFactory.labelWith(font: .trMediumFont(14), text: "补差价金额（元）", textColor: .txtColor(), superView: whiteView)
        
        let priceBgView = UIView()
        priceBgView.backgroundColor = UIColor.hexColor(hexValue: 0xF4F5F7)
        contentView.addSubview(priceBgView)
        
        priceLab = TRFactory.labelWith(font: .trBoldFont(16), text: "0", textColor: .txtColor(), superView: priceBgView)
        let unitLab = TRFactory.labelWith(font: .trFont(16), text: "元", textColor: .txtColor(), superView: priceBgView)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确认补差价", for: .normal)
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.titleLabel?.font = .trBoldFont(18)
        sureBtn.backgroundColor = .themeColor()
        sureBtn.layer.cornerRadius = 23
        sureBtn.layer.masksToBounds = true
        contentView.addSubview(sureBtn)
        
        cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(named: "cancel_gray"), for: .normal)
        contentView.addSubview(cancelBtn)
        
        tipView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(70)
        }
        whiteView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(tipView.snp.bottom).inset(18)
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(whiteView).offset(15)
        }
        weiBtn.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.left.equalTo(whiteView).offset(16)
            make.width.equalTo(134)
            make.top.equalTo(titleLab.snp.bottom).offset(32)
        }
        volBtn.snp.makeConstraints { make in
            make.size.equalTo(weiBtn)
            make.top.equalTo(weiBtn)
            make.left.equalTo(weiBtn.snp.right)
        }
        
        typeLab.snp.makeConstraints { make in
            make.left.equalTo(whiteView).offset(16)
            make.top.equalTo(weiBtn.snp.bottom).offset(24)
        }
        
        minusBtn.snp.makeConstraints { make in
            make.width.height.equalTo(38)
            make.left.equalTo(whiteView).offset(19)
            make.top.equalTo(typeLab.snp.bottom).offset(11)
        }
        addBtn.snp.makeConstraints { make in
            make.size.equalTo(minusBtn)
            make.right.equalTo(whiteView).inset(16)
            make.centerY.equalTo(minusBtn)
        }
        valueBgView.snp.makeConstraints { make in
            make.left.equalTo(minusBtn.snp.right)
            make.right.equalTo(addBtn.snp.left)
            make.top.bottom.equalTo(minusBtn)
        }
        valueTF.snp.makeConstraints { make in
            make.left.equalTo(minusBtn.snp.right)
            make.right.equalTo(addBtn.snp.left)
            make.top.bottom.equalTo(valueBgView)
        }
        
        priceItemLab.snp.makeConstraints { make in
            make.left.equalTo(typeLab)
            make.top.equalTo(addBtn.snp.bottom).offset(20)
        }
        priceBgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(priceItemLab.snp.bottom).offset(8)
            make.height.equalTo(44)
        }
        unitLab.snp.makeConstraints { make in
            make.centerY.equalTo(priceBgView)
            make.right.equalTo(priceBgView).inset(12)
        }
        priceLab.snp.makeConstraints { make in
            make.left.equalTo(priceBgView).offset(12)
            make.centerY.equalTo(priceBgView)
        }
        sureBtn.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(IS_IphoneX ? 35 : 20)
            make.height.equalTo(46)
            make.width.equalTo(152)
        }
        cancelBtn.snp.makeConstraints { make in
            make.right.top.equalTo(whiteView).inset(16)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        //输入类型 1 重量 2 体积
        weiBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self  else { return }
            needChange = false
            if self.type != 1 {
                self.type = 1
                priceLab.text = currnetWeightPrice
                valueTF.text = "\(currentWeight)"
            }
        }).disposed(by: bag)
        volBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self  else { return }
            needChange = false
            if self.type != 2 {
                self.type = 2
                priceLab.text = currentVolPrice
                valueTF.text = "\(currentVol)"
            }
        }).disposed(by: bag)
        
        sureBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            createPatchOrder()
            
        }).disposed(by: bag)
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            
            closeView()
        }).disposed(by: bag)
    }
    private func countSpadTime(){
        currentCount = 0
        TRGCDTimer.share.createTimer(withName: "patchActionTime", timeInterval: 0.05, queue: .main, repeats: true) {[weak self] in
            guard let self = self else {return}
            currentCount += 1
            if currentCount >= 10 {
                calPatchPrice()
                TRGCDTimer.share.destoryTimer(withName: "patchActionTime")
            }
        }
        
        
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
        TRGCDTimer.share.destoryTimer(withName: "patchActionTime")
    }
    private func calPatchPrice(){
        //  //输入类型 1 重量 2 体积
        priceLab.text = "正在询价..."
        let pars = [
            "orderNo" : model!.orderNo,
            "patchWeight" : type == 1 ? currentWeight : 0,
            "patchVolume" : type == 2 ? currentVol : 0,
        ] as [String : Any]
        
        
        TRNetManager.shared.post_no_lodding(url: URL_Order_Patch_Cal, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let infoModel = TROrderSubOrderCalInfoManage.deserialize(from: dict) else {return}
            if infoModel.code == Net_Code_Success {
                currentCalInfoModel = infoModel.data
                priceLab.text = "¥" + currentCalInfoModel!.patchAmount
                if type == 2 {
                    currentVolPrice = currentCalInfoModel!.patchAmount
                } else {
                    currnetWeightPrice = currentCalInfoModel!.patchAmount
                }
            } else {
                SVProgressHUD.showInfo(withStatus: infoModel.exceptionMsg)
                priceLab.text = "询价失败"
            }
        }
        
    }
    
    
    
    
    private func createPatchOrder(){
        let pars = [
            "orderNo" : model!.orderNo,
            "patchWeight" : type == 1 ? currentWeight : 0,
            "patchVolume" : type == 2 ? currentVol : 0,
        ] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Order_Patch_Order, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == Net_Code_Success {
                let successView = TRSimpleTipView()
                successView.addToWindow()
                closeView()
                NotificationCenter.default.post(name: .init(Notification_Name_Patch_Order), object: nil)
            } else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
            }
        }
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

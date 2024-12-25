//
//  TRPaymentPopView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/16.
//

import UIKit

//押金
class TRRiderDepositPaymentPopView: TRBottomPopBasicView {

    var trafficTypeLab : UILabel!
    var valueLab : UILabel!
    
    //卡片里面的金额
    
    var cardValueLab : UILabel!
    
    
    var agrementView : TRAgreementActionView!
    
    //确认充值
    var sureBtn : UIButton!
    //暂不充值
    var noBtn : UIButton!
    
    var model : TRRiderPaymentModel? {
        didSet {
            guard let model = model else { return }
            trafficTypeLab.text = model.vehicleTypeDesc
            valueLab.attributedText = TRTool.richText(str1: "\(model.receiveAmount)", font1: .trBoldFont(20), color1: .hexColor(hexValue: 0xF55555), str2: "元", font2: .trBoldFont(14), color2: .hexColor(hexValue: 0xF55555))
            cardValueLab.attributedText = TRTool.richText(str1: "¥", font1: .trBoldFont(18), color1: .white, str2: "\(model.payAmount)", font2: .trBoldFont(32), color2: .white)
        }
    }
    var block : Void_Block?
    
    var agreementBlock : Void_Block?

    
    //是否同意协议
    private var isAgree : Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        configTitleCancelView()
        let itemLab = TRFactory.labelWith(font: .trFont(14), text: "车辆类型：", textColor: .txtColor(), superView: contentView)
        
        trafficTypeLab = TRFactory.labelWith(font: .trBoldFont(14), text: "电动车", textColor: .txtColor(), superView: contentView)
        
        let valueItemLab = TRFactory.labelWith(font: .trFont(14), text: "接单保证金：", textColor: .txtColor(), superView: contentView)
        
        valueLab = UILabel()
        valueLab.text = "aa"
        contentView.addSubview(valueLab)
        
        
        let cardBgView = UIImageView(image: UIImage(named: "home_payment_bg"))
        cardBgView.trCorner(15)
        contentView.addSubview(cardBgView)
        
        let cardValueItemLab = TRFactory.labelWith(font: .trMediumFont(22), text: "应缴纳接单保证金", textColor: .white, superView: contentView)

        cardValueLab = UILabel()
        cardValueLab.text = "100.00"
        cardValueLab.attributedText = TRTool.richText(str1: "¥", font1: .trBoldFont(18), color1: .white, str2: "--", font2: .trBoldFont(32), color2: .white)
        contentView.addSubview(cardValueLab)
        
        let line = UIView()
        line.backgroundColor = .hexColor(hexValue: 0xF4F5F7)
        contentView.addSubview(line)
        
        agrementView = TRAgreementActionView(frame: .zero)
        agrementView.agreeLab.text = "我已阅读并同意"
        agrementView.agreeLab1.text = "《保证金服务协议》"
        agrementView.agreeBtn.addTarget(self, action: #selector(agreeAction), for: .touchUpInside)

        agrementView.block = {[weak self] in
            guard let self  = self  else { return }
            
            if agreementBlock != nil {
                agreementBlock!()
            }
        }
        
        contentView.addSubview(agrementView)
        
        noBtn = TRFactory.buttonWithCorner(title: "暂不充值", bgColor: .hexColor(hexValue: 0xF1F3F4), font: .trFont(18), corner: 23)
        noBtn.setTitleColor(.txtColor(), for: .normal)
        noBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        contentView.addSubview(noBtn)
        sureBtn = TRFactory.buttonWithCorner(title: "确定充值", bgColor: .themeColor(), font: .trBoldFont(18), corner: 23)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        contentView.addSubview(sureBtn)

        
        itemLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(32)
            make.left.equalTo(contentView).offset(16)
        }
        trafficTypeLab.snp.makeConstraints { make in
            make.centerY.equalTo(itemLab)
            make.left.equalTo(itemLab.snp.right).offset(0)
        }
        
        valueItemLab.snp.makeConstraints { make in
            make.left.equalTo(itemLab)
            make.top.equalTo(itemLab.snp.bottom).offset(18)
        }
        valueLab.snp.makeConstraints { make in
            make.bottom.equalTo(valueItemLab)
            make.left.equalTo(valueItemLab.snp.right).offset(5)
        }
        
        cardBgView.snp.makeConstraints { make in
            make.top.equalTo(valueItemLab.snp.bottom).offset(14)
            make.left.right.equalTo(contentView).inset(16)
            make.height.equalTo(108)
        }
        cardValueItemLab.snp.makeConstraints { make in
            make.left.equalTo(cardBgView).offset(12)
            make.top.equalTo(cardBgView).offset(20)
        }
        cardValueLab.snp.makeConstraints { make in
            make.left.equalTo(cardValueItemLab)
            make.top.equalTo(cardValueItemLab.snp.bottom).offset(8)
        }
        
        agrementView.snp.makeConstraints { make in
            make.top.equalTo(cardBgView.snp.bottom).offset(36)
            make.left.right.equalTo(contentView).inset(0)
            make.height.equalTo(36)
        }
        noBtn.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView.snp.centerX).offset(-5)
            make.top.equalTo(agrementView.snp.bottom).offset(15)
        }
        sureBtn.snp.makeConstraints { make in
            make.top.bottom.width.equalTo(noBtn)
            make.right.equalTo(contentView).inset(16)
            make.left.equalTo(contentView.snp.centerX).offset(5)
        }
        
    }
    @objc func sureAction(){
        if isAgree == false {
            SVProgressHUD.showInfo(withStatus: "请阅读并同意《保证金服务协议》")
            return
        }
        if block != nil {
            block!()
        }
    }
    @objc func agreeAction(){
        isAgree = !isAgree
        if isAgree {
            agrementView.agreeBtn.setImage(UIImage(named: "select"), for: .normal)
        } else {
            agrementView.agreeBtn.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

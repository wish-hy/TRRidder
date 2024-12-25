//
//  TRRiderCreditPaymentView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/17.
//

import UIKit
//授信余额不足
class TRRiderCreditPaymentView: TRBottomPopBasicView {

    var cardValueItemLab : UILabel!
    
    var valueLab : UILabel!
    
    //卡片里面的金额
    
    var cardValueLab : UILabel!
    
    var tipLab : UILabel!
    
    var agrementView : TRAgreementActionView!
    
    //确认充值
    var sureBtn : UIButton!
    //暂不充值
    var noBtn : UIButton!
    
    var block : Void_Block?
    
    var model : TRRiderPaymentModel? {
        didSet {
            guard let model = model else { return }
            valueLab.text = "\(model.receiveAmount)元"
            cardValueItemLab.text = "为不影响正常接单，本次充值金额\(model.payAmount)"
            cardValueLab.text = "\(model.payAmount)"
        }
    }
    private var isAgree : Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        configTitleCancelView()

        
        
        
        let itemLab = TRFactory.labelWith(font: .trFont(16), text: "我的接单授信额度：", textColor: .txtColor(), superView: contentView)
        
        valueLab = TRFactory.labelWith(font: .trBoldFont(16), text: "50.00元", textColor: .txtColor(), superView: contentView)
        
        
        let cardBgView = UIImageView(image: UIImage(named: "home_credit_bg"))
        cardBgView.trCorner(15)
        contentView.addSubview(cardBgView)
        
        cardValueItemLab = TRFactory.labelWith(font: .trMediumFont(16), text: "为不影响正常接单，本次充值金额51.50", textColor: .white, superView: contentView)

        let valueBgView = UIView()
        valueBgView.trCorner(10)
        valueBgView.backgroundColor = .white
        cardBgView.addSubview(valueBgView)
        cardValueLab = TRFactory.labelWith(font: .trBoldFont(28), text: "50.00", textColor: .txtColor(), superView: valueBgView)
        let unitLab = TRFactory.labelWithUnit(font: .trMediumFont(18), text: "元", textColor: .txtColor(), superView: valueBgView)
        
        tipLab = UILabel()
        tipLab.numberOfLines = 0
        tipLab.attributedText = TRTool.richText(str1: "提示：\n", font1: .trBoldFont(14), color1: .hexColor(hexValue: 0xF55555), str2: "因骑手接单过程中造成赔付，系统会在您的授信额度中进行扣款；惩罚扣款在我的钱包待扣金额明细可查询，对扣款有疑问，请在违规申诉进行申诉处理。", font2: .trFont(13), color2: .hexColor(hexValue: 0x67686A))
        contentView.addSubview(tipLab)
        
        let line = UIView()
        line.backgroundColor = .hexColor(hexValue: 0xF4F5F7)
        contentView.addSubview(line)
        
        noBtn = TRFactory.buttonWithCorner(title: "暂不充值", bgColor: .hexColor(hexValue: 0xF1F3F4), font: .trFont(18), corner: 23)
        noBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        noBtn.setTitleColor(.txtColor(), for: .normal)
        contentView.addSubview(noBtn)
        sureBtn = TRFactory.buttonWithCorner(title: "确定充值", bgColor: .themeColor(), font: .trBoldFont(18), corner: 23)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        contentView.addSubview(sureBtn)

        
        itemLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(32)
            make.left.equalTo(contentView).offset(16)
        }
        valueLab.snp.makeConstraints { make in
            make.bottom.equalTo(itemLab)
            make.left.equalTo(itemLab.snp.right).offset(5)
        }
        tipLab.snp.makeConstraints { make in
            make.top.equalTo(cardBgView.snp.bottom).offset(14)
            make.left.equalTo(itemLab)
            make.right.equalTo(contentView).inset(15)
        }
        
       
        cardBgView.snp.makeConstraints { make in
            make.top.equalTo(itemLab.snp.bottom).offset(14)
            make.left.right.equalTo(contentView).inset(16)
            make.height.equalTo(114)
        }
        cardValueItemLab.snp.makeConstraints { make in
            make.left.equalTo(cardBgView).offset(15)
            make.top.equalTo(cardBgView).offset(16)
        }
        valueBgView.snp.makeConstraints { make in
            make.left.right.equalTo(cardBgView).inset(8)
            make.bottom.equalTo(cardBgView).offset(-8)
            make.height.equalTo(56)
        }
        cardValueLab.snp.makeConstraints { make in
            make.left.equalTo(cardValueItemLab)
            make.centerY.equalTo(valueBgView)
        }
        unitLab.snp.makeConstraints { make in
            make.centerY.equalTo(valueBgView)
            make.right.equalTo(valueBgView).inset(15)
        }
        
        noBtn.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView.snp.centerX).offset(-5)
            make.bottom.equalTo(contentView).offset(IS_IphoneX ? -35 : -20)
        }
        sureBtn.snp.makeConstraints { make in
            make.top.bottom.width.equalTo(noBtn)
            make.right.equalTo(contentView).inset(16)
            make.left.equalTo(contentView.snp.centerX).offset(5)
        }
        
    }
    
    @objc func sureAction(){
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

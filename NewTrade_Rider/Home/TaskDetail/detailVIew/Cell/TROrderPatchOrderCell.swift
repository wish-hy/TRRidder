//
//  TROrderPatchOrderCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/3.
//

import UIKit

class TROrderPatchOrderCell: UITableViewCell {
    //补差价的订单
    var stateLab : UILabel!
    var itemLab : UILabel!
    var valueLab : UILabel!
    var payLab : UILabel!
    var bgView : UIView!

    var model : TRDelSubOrder? {
        didSet {
            guard let model  = model  else { return }
            if model.measureMethod.elementsEqual("VOLUME") {
                itemLab.text = "补物品体积"
                valueLab.text = model.totalVolume + "立方"
            } else {
                itemLab.text = "补物品重量"
                valueLab.text = model.totalWeight + "公斤"
            }
            if model.payStatus.elementsEqual("PAY_WAIT") ||
                model.payStatus.elementsEqual("PAYING") {
                stateLab.text = "待支付"
                stateLab.textColor = .hexColor(hexValue: 0xF54444)
                payLab.attributedText = TRTool.richText(str1: "¥", font1: .trBoldFont(14), color1: .hexColor(hexValue: 0xf54444), str2: model.payAmount, font2: .trBoldFont(18), color2: .hexColor(hexValue: 0xf54444))

            } else if model.payStatus.elementsEqual("COMPLETE"){
                stateLab.text = "已支付差价"
                stateLab.textColor = .txtColor()
                payLab.attributedText = TRTool.richText(str1: "¥", font1: .trBoldFont(14), color1: .hexColor(hexValue: 0xf54444), str2: model.payAmount, font2: .trBoldFont(18), color2: .hexColor(hexValue: 0xf54444))
            } else {
                stateLab.text = "订单被取消"
                stateLab.textColor = .txtColor()
                payLab.attributedText = TRTool.richText(str1: "¥", font1: .trBoldFont(14), color1: .hexColor(hexValue: 0xf54444), str2: model.payAmount, font2: .trBoldFont(18), color2: .hexColor(hexValue: 0xf54444))
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    
    
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        let infoLab = TRFactory.labelWith(font: .trBoldFont(18), text: "订单补差价信息", textColor: .txtColor(), superView: bgView)
        stateLab = TRFactory.labelWith(font: .trBoldFont(18), text: "待支付", textColor: .hexColor(hexValue: 0xF54444), superView: bgView)
        
        itemLab = TRFactory.labelWith(font: .trBoldFont(16), text: "补物品重量", textColor: .txtColor(), superView: bgView)
        
        valueLab = TRFactory.labelWith(font: .trFont(16), text: "--", textColor: .txtColor(), superView: bgView)
        
        let line = UIView()
        line.backgroundColor = .bgColor()
        bgView.addSubview(line)
        
        let payItemLab = TRFactory.labelWith(font: .trMediumFont(16), text: "用户实付补差价金额：", textColor: .txtColor(), superView: bgView)
        payLab = UILabel()
        payLab.text = "--"
        bgView.addSubview(payLab)
        
        bgView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(10)
            make.top.equalTo(contentView).offset(0)
            make.left.right.equalTo(contentView)
        }
        
        infoLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(16)
            make.top.equalTo(bgView).offset(15)
        }
        stateLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(16)
            make.centerY.equalTo(infoLab)
        }
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(infoLab)
            make.top.equalTo(infoLab.snp.bottom).offset(20)
        }
        valueLab.snp.makeConstraints { make in
            make.centerY.equalTo(itemLab)
            make.left.equalTo(itemLab.snp.right).offset(24)
        }
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.right.left.equalTo(bgView).inset(16)
            make.top.equalTo(itemLab.snp.bottom).offset(15)
            make.bottom.equalTo(bgView).inset(54)
        }
      
        payLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(16)
            make.top.equalTo(line.snp.bottom).offset(15)
        
        }
        payItemLab.snp.makeConstraints { make in
            make.centerY.equalTo(payLab)
            make.right.equalTo(payLab.snp.left)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

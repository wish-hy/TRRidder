//
//  TRRiderApplyRecordCel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit

class TRRiderApplyRecordCel: UITableViewCell {
    var colorIndexView : UIView!
    
    var itemLab : UILabel!
    var timeLab : UILabel!
    var stateLab : UILabel!
    
    var areaLab : UILabel!
    
    var model : TRRiderApplyRecordModel? {
        didSet {
            guard let model = model else { return }
            stateLab.text = model.authStatusDesc
            timeLab.text = model.time
            areaLab.text = model.areaAddress
            itemLab.text = model.serviceCodeDesc
            if model.serviceCode.elementsEqual("MALL") {
                colorIndexView.backgroundColor = .hexColor(hexValue: 0x13D066)
            } else if model.serviceCode.elementsEqual("LOCAL_FAST_DEL") {
                colorIndexView.backgroundColor = .hexColor(hexValue: 0x2044C9)
            } else if model.serviceCode.elementsEqual("LOCAL_DEL_GOODS") {
                colorIndexView.backgroundColor = .hexColor(hexValue: 0xFAA80D)
            } else {
                colorIndexView.backgroundColor = .hexColor(hexValue: 0x13D066)
            }
            /*
             当前认证状态: 待审核=UNAUDITED，审核不通过=REJECTED，审核通过=APPROVE，待签约=UNSIGNED，待培训=UNTRAINED，已培训=TRAINED,可用值:UNAUDITED,REJECTED,UNSIGNED,UNTRAINED,TRAINED
             */
            if model.authStatus.elementsEqual("UNAUDITED") {
                stateLab.textColor = .hexColor(hexValue: 0x198FFF)
            } else if model.authStatus.elementsEqual("REJECTED") {
                stateLab.textColor = .hexColor(hexValue: 0xF54444)
            } else if model.authStatus.elementsEqual("APPROVE") {
                stateLab.textColor = .hexColor(hexValue: 0x13D066)
            } else if model.authStatus.elementsEqual("UNSIGNED") {
                stateLab.textColor = .hexColor(hexValue: 0x198FFF)
            } else if model.authStatus.elementsEqual("UNTRAINED") {
                stateLab.textColor = .hexColor(hexValue: 0x198FFF)
            } else if model.authStatus.elementsEqual("TRAINED") {
                stateLab.textColor = .hexColor(hexValue: 0x13D066)
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        
        let bgView = UIView()
        bgView.trCorner(12)
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        colorIndexView = UIView()
        colorIndexView.trCorner(3)
        colorIndexView.backgroundColor = .red
        contentView.addSubview(colorIndexView)
        
        itemLab = TRFactory.labelWith(font: .trBoldFont(18), text: "同城配搜狗", textColor: .txtColor(), superView: bgView)
        timeLab = TRFactory.labelWith(font: .trMediumFont(14), text: "同城配搜狗", textColor: .txtColor(), superView: bgView)
        
        stateLab = TRFactory.labelWith(font: .trMediumFont(16), text: "同城配搜狗", textColor: .txtColor(), superView: bgView)
        
        let areaBgView = UIView()
        areaBgView.trCorner(8)
        areaBgView.backgroundColor = .hexColor(hexValue: 0xF9FAFB)
        bgView.addSubview(areaBgView)
        
        let areaItemImgV = TRFactory.imageViewWith(image: UIImage(named: "record_location"), mode: .scaleAspectFit, superView: areaBgView)
        let areaItemLab = TRFactory.labelWith(font: .trFont(13), text: "申请区域", textColor: .hexColor(hexValue: 0x67686A), superView: areaBgView)
        areaLab = TRFactory.labelWith(font: .trMediumFont(14), text: "申广东省 深圳市 宝安区 新安街道域", textColor: .txtColor(), superView: areaBgView)
        let line = UIView()
        line.backgroundColor = .hexColor(hexValue: 0xE5E6E7)
        bgView.addSubview(line)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(5)
        }
        colorIndexView.snp.makeConstraints { make in
            make.width.height.equalTo(6)
            make.left.equalTo(bgView).inset(12)
            make.top.equalTo(bgView).offset(24)
        }
        itemLab.snp.makeConstraints { make in
            make.centerY.equalTo(colorIndexView)
            make.left.equalTo(colorIndexView.snp.right).offset(9)
        }
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(itemLab.snp.right).offset(21)
            make.centerY.equalTo(colorIndexView)
        }
        stateLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(12)
            make.centerY.equalTo(colorIndexView)
        }
        line.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(10)
            make.centerY.equalTo(itemLab)
            make.left.equalTo(itemLab.snp.right).offset(10)
        }
        areaBgView.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(12)
            make.top.equalTo(itemLab.snp.bottom).offset(10)
            make.height.equalTo(56)
            make.bottom.equalTo(bgView).inset(10)
        }
        
        areaItemImgV.snp.makeConstraints { make in
            make.centerY.equalTo(areaBgView)
            make.left.equalTo(areaBgView).offset(8)
            make.width.height.equalTo(22)
        }
        
        areaItemLab.snp.makeConstraints { make in
            make.left.equalTo(areaItemImgV.snp.right).offset(8)
            make.top.equalTo(areaBgView).offset(8)
        }
        areaLab.snp.makeConstraints { make in
            make.left.equalTo(areaItemLab)
            make.bottom.equalTo(areaBgView).inset(8)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

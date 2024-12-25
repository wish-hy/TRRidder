//
//  TRRidderApplyTrafficInputCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/26.
//

import UIKit

class TRRidderApplyTrafficInputCell: UITableViewCell {
    var itemLab : UILabel!
    
    var numberLab : UILabel!
    var typeLab : UILabel!
    
    var placeHolderLab : UILabel!
    
    var arrowImgV : UIImageView!
    
    
    private var bgView : UIView!
    var model : TRRidderApplyVehicleSelModel? {
        didSet {
            if model == nil {
                placeHolderLab.isHidden = false
                numberLab.isHidden = true
                typeLab.isHidden = true
                
                bgView.snp.remakeConstraints { make in
                    make.left.right.equalTo(contentView).inset(16)
                    make.top.bottom.equalTo(contentView)
                    make.height.equalTo(50)
                }
            } else {
                placeHolderLab.isHidden = true
                numberLab.isHidden = false
                typeLab.isHidden = false
                
                typeLab.text = model!.codeName
                numberLab.text = model!.numberplate
                
                bgView.snp.remakeConstraints { make in
                    make.left.right.equalTo(contentView).inset(16)
                    make.top.bottom.equalTo(contentView)
                    make.height.equalTo(60)
                }
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
        let whiteTopView = UIView()
        whiteTopView.backgroundColor = .white
        contentView.addSubview(whiteTopView)
        
        bgView = UIView()
        bgView.backgroundColor = .white
        bgView.trCorner(10)
        contentView.addSubview(bgView)
        
        
        
        itemLab = UILabel()
        itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(16), color1: .hexColor(hexValue: 0xFF3141), str2: "车辆信息", font2: .trFont(16), color2: .txtColor())
        bgView.addSubview(itemLab)
        typeLab = TRFactory.labelWith(font: .trFont(13), text: "--", textColor: .hexColor(hexValue: 0x67686A), superView: bgView)
        typeLab.isHidden = true
        
        numberLab = TRFactory.labelWith(font: .trMediumFont(16), text: "--", textColor: .txtColor(), superView: bgView)

        
        placeHolderLab = TRFactory.labelWith(font: .trFont(16), text: "请选择车辆", textColor: .hexColor(hexValue: 0x9B9C9C), superView: bgView)
        
        
        arrowImgV = TRFactory.imageViewWith(image: UIImage(named: "blance_arrow"), mode: .scaleAspectFit, superView: bgView)
        whiteTopView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView)
            make.height.equalTo(10)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
            make.height.equalTo(50)
        }
        placeHolderLab.snp.makeConstraints { make in
            make.top.equalTo(itemLab)
            make.left.equalTo(numberLab)
        }
        arrowImgV.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.right.equalTo(bgView).inset(10)
            make.width.height.equalTo(18)
        }
        itemLab.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(13)
            make.left.equalTo(bgView).offset(12)
        }

        numberLab.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(8)
            make.left.equalTo(bgView).offset(132)
        }
        typeLab.snp.makeConstraints { make in
            make.top.equalTo(numberLab.snp.bottom).offset(5)
            make.left.equalTo(bgView).offset(132)
        }
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

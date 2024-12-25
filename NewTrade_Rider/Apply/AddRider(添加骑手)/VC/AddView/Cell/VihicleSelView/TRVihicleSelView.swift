//
//  TRVihicleSelView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRVihicleSelView: UIButton {
    var titleLab : UILabel!
    var infoLab : UILabel!
    
    var imgV : UIImageView!
    
    var selImgV : UIImageView!
    
    var normalTitleColor : UIColor  = .txtColor()
    var selTitleColor : UIColor = .themeColor()
    
    var normalInfoColor : UIColor  = .hexColor(hexValue: 0x6A6A6B)
    var selInfoColor : UIColor = .hexColor(hexValue: 0x6C9CF5)
    var normalBackColor : UIColor = .white
    var selBackColor : UIColor = .white
    var normalBorderColor : UIColor = .hexColor(hexValue: 0xD1D4D5)
    var selBorderColor : UIColor = .hexColor(hexValue: 0x10D46D)
    
    var isSel = false {
        didSet {
            if isSel {
                titleLab.textColor = selTitleColor
                infoLab.textColor = selInfoColor
                selImgV.isHidden = false
                self.layer.borderColor = selBorderColor.cgColor
                self.backgroundColor = selBackColor
            } else {
                titleLab.textColor = normalTitleColor
                infoLab.textColor = normalInfoColor
                selImgV.isHidden = true
                self.layer.borderColor = normalBorderColor.cgColor
                self.backgroundColor = normalBackColor
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        titleLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 15), text: "普通骑手", textColor: normalTitleColor, superView: self)
        
        infoLab = TRFactory.labelWith(font: .trFont(fontSize: 12), text: "自由接单\n多跑多赚", textColor: normalInfoColor, superView: self)
        infoLab.numberOfLines = 0
        imgV = UIImageView(image: UIImage(named: "vihicle_common"))
        self.addSubview(imgV)
        
        selImgV = UIImageView(image: UIImage(named: "vihicle_special_sel"))
        self.addSubview(selImgV)
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(15)
        }
        infoLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.equalTo(self).inset(10)
        }
        
        imgV.snp.makeConstraints { make in
            make.bottom.right.equalTo(self).inset(5)
            make.height.width.equalTo(62)
        }
        
        selImgV.snp.makeConstraints { make in
            make.top.right.equalTo(self)
        }
        selImgV.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

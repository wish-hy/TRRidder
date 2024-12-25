//
//  TRAddStepItemView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRAddStepItemView: UIView {
    
    var idContentView : UIView!
    var idLab : UILabel!
    
    var itemLab : UILabel!
    
    var idImgV : UIImageView!
    
    var state : Int = 0 {
        didSet {
            if state == 0 {
                idContentView.backgroundColor = .clear
                idLab.backgroundColor = .hexColor(hexValue: 0xC6C9CB)
                idLab.textColor = .white
                itemLab.textColor = .hexColor(hexValue: 0x9B9C9C)
                
               
            } else if state == 1{//当前选中
                idContentView.backgroundColor = .clear
                idLab.backgroundColor = .hexColor(hexValue: 0x13D066)
                idLab.textColor = .white
                itemLab.textColor = .applyColor()
            } else if state == 2{
                idContentView.backgroundColor = .clear
                idLab.backgroundColor = .hexColor(hexValue: 0x485F52)
                idLab.textColor = .white
                itemLab.textColor = .txtColor()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        idContentView = UIView()
        idContentView.backgroundColor = .hexColor(hexValue: 0xD5DFFF)
        idContentView.layer.cornerRadius = 17
        idContentView.layer.masksToBounds = true
        self.addSubview(idContentView)
        
        idLab = TRFactory.labelWith(font: .trMediumFont(fontSize: 13), text: "2", textColor: .white, superView: idContentView)
        idLab.layer.cornerRadius = 12
        idLab.layer.masksToBounds = true
        idLab.textAlignment = .center
        
        idLab.backgroundColor = .themeColor()
        
        itemLab = TRFactory.labelWith(font: .trMediumFont(fontSize: 14), text: "2", textColor: .themeColor(), superView: self)
        itemLab.textAlignment = .center
        idContentView.snp.makeConstraints { make in
            make.centerX.top.equalTo(self)
            make.height.width.equalTo(34)
        }
        idLab.snp.makeConstraints { make in
            make.center.equalTo(idContentView)
            make.height.width.equalTo(24)
        }
        itemLab.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.left.right.equalTo(self).inset(5)
            make.width.greaterThanOrEqualTo(34)
            make.top.equalTo(idContentView.snp.bottom).offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

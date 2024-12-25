//
//  TRVaildDateSubView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/29.
//

import UIKit

class TRVaildDateSubView: UIButton {
    var editState : Int = 0{
        didSet {
            if editState == 0 {
                self.layer.borderColor = UIColor.hexColor(hexValue: 0xD1D4D5).cgColor
                timeLab.textColor = .hexColor(hexValue: 0xD1D4D5)
                imgV.image = UIImage(named: "calendar_gray")
            } else if editState == 1 {
                self.layer.borderColor = UIColor.lightThemeColor().cgColor
                timeLab.textColor = .lightThemeColor()
                imgV.image = UIImage(named: "calendar_theme")
            } else if editState == 2 {
                self.layer.borderColor = UIColor.txtColor().cgColor
                timeLab.textColor = .txtColor()
                imgV.image = UIImage(named: "calendar_gray")

            }
        }
        
    }// 0 未选择未填充 1 正在选择 2 已填充
    var timeLab : UILabel!
    var imgV : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        self.layer.borderWidth = 1
        timeLab = TRFactory.labelWith(font: .trFont(14), text: "未选择", textColor: .hexColor(hexValue: 0xD1D4D5), superView: self)
        imgV = TRFactory.imageViewWith(image: UIImage(named: "calendar_gray"), mode: .scaleAspectFit, superView: self)
        
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(self).offset(8)
            make.centerY.equalTo(self)
        }
        imgV.snp.makeConstraints { make in
            make.right.equalTo(self).inset(8)
            make.width.height.equalTo(16)
            make.centerY.equalTo(self)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRCommonFunBtn.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineCommonFunBtn: UIButton {

    var bgImgV : UIImageView!
    var titleLab : UILabel!
    var valueLab : UILabel!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        bgImgV = UIImageView(image: UIImage(named: "func_money_bg"))
         self.addSubview(bgImgV)
         
         titleLab = UILabel()
         titleLab.text = "我的钱包(元)"
         titleLab.textColor = UIColor.hexColor(hexValue: 0xF3AA68)
        titleLab.font = .trMediumFont(13)
        self.addSubview(titleLab)
         
         valueLab = UILabel()
        valueLab.text = "200"
        valueLab.textColor = UIColor.hexColor(hexValue: 0xFA651F)
        valueLab.font = UIFont.trBoldFont(fontSize: 23)
        self.addSubview(valueLab)
         
         bgImgV.snp.makeConstraints { make in
             make.left.right.bottom.top.equalTo(self).inset(0)
         }
         
         titleLab.snp.makeConstraints { make in
             make.left.equalTo(bgImgV).offset(10)
             make.top.equalTo(bgImgV).offset(15)
         }
        valueLab.snp.makeConstraints { make in
             make.left.equalTo(titleLab)
             make.bottom.equalTo(bgImgV).inset(15)
         }
    }
}

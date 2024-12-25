//
//  TRMineButton.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineHeaderButton: UIButton {
    var numLab : UILabel!
    var iconImgV : UIImageView!
    var tipLab : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        numLab = UILabel()
        numLab.text = "0"
        numLab.textAlignment = .center
        numLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        numLab.font = UIFont.trBoldFont(fontSize: 26)
        self.addSubview(numLab)
        
        tipLab = UILabel()
        tipLab.text = "今日完成订单(单)"
        tipLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        tipLab.font = UIFont.trFont(fontSize: 13)
        self.addSubview(tipLab)
        
        iconImgV = UIImageView()
        iconImgV.image = UIImage(named: "func_todayOrder")
        self.addSubview(iconImgV)
        
        numLab.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(self)
        }
        iconImgV.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.top.equalTo(numLab.snp.bottom).offset(6)
        }
        
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(iconImgV.snp.right).offset(2)
            make.centerY.equalTo(iconImgV)
            make.right.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

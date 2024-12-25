//
//  TRButton.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRButton: UIButton {

    var lab : UILabel!
    var imgV : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgV = UIImageView()
        imgV.image = UIImage(named: "home_phone")
        self.addSubview(imgV)
        
        lab = UILabel()
        lab.text = "联系"
        lab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        lab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(lab)
        
        imgV.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
            make.width.height.equalTo(24)
        }
        lab.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(imgV.snp.bottom).offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

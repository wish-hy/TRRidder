//
//  TRRightButton.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRRightButton: UIButton {

    var lab : UILabel!
    var imgV : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgV = UIImageView()
        imgV.image = UIImage(named: "arrow_gray")
        self.addSubview(imgV)
        
        lab = UILabel()
        lab.text = "联系"
        lab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        lab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(lab)
        
        imgV.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.height.equalTo(14)
            make.right.equalTo(self).offset(-14)
            make.left.equalTo(lab.snp.right).offset(1)
        }
        lab.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            
            make.left.equalTo(self).offset(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

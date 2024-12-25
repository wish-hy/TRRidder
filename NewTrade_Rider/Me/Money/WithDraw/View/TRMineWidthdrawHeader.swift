//
//  TRMineWidthdrawHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRMineWidthdrawHeader: UICollectionReusableView {
    var titleLab : UILabel!
    
    var desLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "提现金额"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 15)
        self.addSubview(titleLab)
        
        desLab = UILabel()
        desLab.text = "支持移动、联通、电信手机卡充值"
        desLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        desLab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(desLab)
        
        titleLab.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(5)
            make.left.equalTo(self).offset(16)
        }
        
        desLab.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalTo(self).inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

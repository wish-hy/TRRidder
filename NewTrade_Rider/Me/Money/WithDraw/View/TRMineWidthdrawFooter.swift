//
//  TRMineWidthdrawFooter.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRMineWidthdrawFooter: UICollectionReusableView {
    var actionBtn : UIButton!
    var tipLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        actionBtn = UIButton()
        actionBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        actionBtn.setTitle("立即提现", for: .normal)
        actionBtn.layer.cornerRadius = 23
        actionBtn.layer.masksToBounds = true
        actionBtn.setTitleColor(.white, for: .normal)
        actionBtn.setTitleColor(.white, for: .highlighted)
        actionBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        
        self.addSubview(actionBtn)
        
        tipLab = UILabel()
        tipLab.text = "提现金额不足，快去接单赚钱"
        tipLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        tipLab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(tipLab)
        
        actionBtn.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(self).offset(48)
            make.height.equalTo(46)
        }
        tipLab.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(actionBtn.snp.bottom).offset(3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

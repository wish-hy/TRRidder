//
//  TRStatisticInfoTipView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStatisticInfoTipView: UIView {

    var tipView : UIView!
    var titleLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        tipView = UIView()
        tipView.layer.cornerRadius = 2
        tipView.backgroundColor = UIColor.hexColor(hexValue: 0x23B1F5)
        tipView.layer.masksToBounds = true
        self.addSubview(tipView)
        
        titleLab = UILabel()
        titleLab.text = "配送时长"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 15)
        self.addSubview(titleLab)
        tipView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(0)
            make.height.equalTo(15)
            make.width.equalTo(3)
            make.top.equalTo(self)
        }
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(tipView)
            make.left.equalTo(tipView.snp.right).offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

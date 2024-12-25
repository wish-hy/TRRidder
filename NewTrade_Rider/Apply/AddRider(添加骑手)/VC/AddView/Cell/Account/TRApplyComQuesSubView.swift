//
//  TRApplyComQuesSubView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/25.
//

import UIKit

class TRApplyComQuesSubView: UIView {
    var titleLab : UILabel!
    var detailLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        titleLab = TRFactory.labelWith(font: .trBoldFont(14), text: "上课豆腐脑", textColor: .txtColor(), superView: self)
        titleLab.numberOfLines = 0
        detailLab = TRFactory.labelWith(font: .trFont(13), text: "就是砥砺奋进", textColor: .hexColor(hexValue: 0x67686A), superView: self)
        detailLab.numberOfLines = 0
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self).offset(12)
            make.right.equalTo(self).inset(12)
            make.top.equalTo(self).offset(20)
        }
        detailLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.right.equalTo(self).inset(12)
            make.top.equalTo(titleLab.snp.bottom).offset(7)
            make.bottom.equalTo(self)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

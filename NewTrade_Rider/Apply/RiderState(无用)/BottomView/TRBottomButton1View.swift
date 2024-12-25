//
//  TRBottomButton1View.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRBottomButton1View: UIView {

    var saveBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        saveBtn = TRFactory.buttonWithCorner(title: "保存", bgColor: .lightThemeColor(), font: .trBoldFont(fontSize: 18), corner: 23)
        self.addSubview(saveBtn)
        // 
        saveBtn.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(IS_IphoneX ? -20 - 15 : -20)
            make.height.equalTo(46)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

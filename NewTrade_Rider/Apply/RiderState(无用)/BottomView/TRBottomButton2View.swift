//
//  TRBottomButton2View.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRBottomButton2View: UIView {

    var leftBtn : UIButton!
    var rightBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        leftBtn = TRFactory.buttonWithCorner(title: "编辑骑手信息", bgColor: .bgColor(), font: .trFont(fontSize: 18), corner: 23)
        leftBtn.setTitleColor(.white, for: .normal)
        self.addSubview(leftBtn)
        rightBtn = TRFactory.buttonWithCorner(title: "提交审核结果", bgColor: .lightThemeColor(), font: .trBoldFont(fontSize: 18), corner: 23)
        self.addSubview(rightBtn)
        
        rightBtn.snp.makeConstraints { make in
            make.right.equalTo(self).inset(16)
            make.left.equalTo(self.snp.centerX).offset(6.5)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(IS_IphoneX ? -20 - 15 : -20)
            make.height.equalTo(46)
        }
        
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self.snp.centerX).offset(-6.5)
            make.top.bottom.equalTo(rightBtn)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

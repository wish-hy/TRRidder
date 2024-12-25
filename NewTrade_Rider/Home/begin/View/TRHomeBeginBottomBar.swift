//
//  TRHomeBeginBottomBar.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/16.
//

import UIKit

class TRHomeBeginBottomBar: UIView {

    var beginBtn : UIButton!
    
    var setBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        
        beginBtn = TRFactory.buttonWithCorner(title: "开工接单", bgColor: .themeColor(), font: .trBoldFont(18), corner: 0)
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 46), byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 23, height: 23))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        beginBtn.layer.mask = maskLayer;
    
        self.addSubview(beginBtn)
        
//        setBtn = TRFactory.buttonWith(image: UIImage(named: "setting"), superView: self)
//        setBtn = TRFactory.buttonWithCorner(title: "选车", bgColor: .themeColor(), font: .trBoldFont(18), corner: 23)
        setBtn = TRFactory.buttonWith(title: "选车", textColor: .hexColor(hexValue: 0xF1F3F4), font: .trBoldFont(18), superView: self)
        
//        setBtn.trCorner(23)
        let setMaskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 88, height: 46), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 23, height: 23))
        let setmaskLayer = CAShapeLayer()
        setmaskLayer.path = setMaskPath.cgPath
        setBtn.layer.mask = setmaskLayer;
        setBtn.backgroundColor = .hexColor(hexValue: 0x7ED200)
        
        
        beginBtn.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.centerY.equalTo(setBtn)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(setBtn.snp.left).offset(0)
        }
        setBtn.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.width.equalTo(88)
            make.right.equalTo(self).inset(16)
            make.top.equalTo(self).offset(8)
            make.bottom.equalTo(self).inset(IS_IphoneX ? 35 + 8 : 8)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

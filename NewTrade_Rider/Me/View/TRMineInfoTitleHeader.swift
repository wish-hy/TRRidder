//
//  TRMineInfoTitleHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineInfoTitleHeader: UICollectionReusableView {
    var titleLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    

    
    private func setupView(){
        self.backgroundColor = .bgColor()
        let whiteBgView  = UIView()
        whiteBgView.backgroundColor = .white
        self.addSubview(whiteBgView)
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 13, height: 13))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        whiteBgView.layer.mask = maskLayer;
        
        titleLab = UILabel()
        titleLab.text = "昨日收入(元)"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 18)
        whiteBgView.addSubview(titleLab)
        
        whiteBgView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(self)
            make.height.equalTo(55)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(whiteBgView).offset(15)
            make.top.equalTo(whiteBgView).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

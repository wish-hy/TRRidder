//
//  TRMineInfoFooter.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineInfoFooter: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    

    
    private func setupView(){
        self.backgroundColor = .bgColor()
        let whiteBgView  = UIView()
        whiteBgView.backgroundColor = .white
        self.addSubview(whiteBgView)
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 20), byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: 13, height: 13))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        whiteBgView.layer.mask = maskLayer;
        

        whiteBgView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(self)
            make.height.equalTo(20)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

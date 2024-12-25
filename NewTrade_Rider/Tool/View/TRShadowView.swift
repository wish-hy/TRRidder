//
//  TRShadowView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit

class TRShadowView: UIView {
    
    var shadowView : UIView!
    var cornerView : UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        shadowView = UIView()
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        shadowView.layer.shadowOpacity = 0.15
        shadowView.layer.shadowRadius = 4.0
        self.addSubview(shadowView)
        
        cornerView = UIView()

        self.addSubview(cornerView)
        
        
        shadowView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self).inset(5)
        }
        cornerView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self).inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

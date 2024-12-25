//
//  TRNavigationBottomView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit

class TRNavigationBottomView: UIView {

    var contentView : UIView!
    var pickupBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        


        pickupBtn = UIButton(frame: .zero)
        pickupBtn.setTitle("按推荐导航路线", for: .normal)
        pickupBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        pickupBtn.setTitleColor(.white, for: .normal)
        pickupBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        pickupBtn.layer.cornerRadius = 23;
        pickupBtn.layer.masksToBounds = true
        self.addSubview(pickupBtn)
        
        contentView.snp.makeConstraints { make in
            make.right.top.bottom.left.equalTo(self)
        }
              
        pickupBtn.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(31)
            make.height.equalTo(46)
            make.top.equalTo(contentView).offset(15)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

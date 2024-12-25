//
//  TRCommentMenuCollectionViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRCommentMenuCollectionViewCell: UICollectionViewCell {
    var menuLab1 : UILabel!
    var line : UIView!
    
    var isSel = false {
        didSet {
            if isSel {
                menuLab1.textColor = UIColor.hexColor(hexValue: 0x141414)
                line.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
            } else {
                menuLab1.textColor = UIColor.hexColor(hexValue: 0x97989A)
                line.backgroundColor = .white
            }
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        menuLab1 = UILabel()
        menuLab1.text = "配送中(3)"
        menuLab1.textColor = UIColor.hexColor(hexValue: 0x97989A)
        menuLab1.font = UIFont.trFont(fontSize: 16)
        self.addSubview(menuLab1)
        
        line = UIView()
        line.backgroundColor = .white
        self.addSubview(line)
        
        let w = 90
        let h = 30
        menuLab1.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
//            make.width.equalTo(w)
            make.height.equalTo(h)
        }
      
        line.snp.makeConstraints { make in
            make.left.right.equalTo(menuLab1)
            make.bottom.equalTo(self)
            make.height.equalTo(3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TRMineWidthDrawNumCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRMineWidthDrawNumCell: UICollectionViewCell {
    var lab : UILabel!
    var isSel = false {
        didSet{
            if isSel {
                lab.textColor = UIColor.hexColor(hexValue: 0x3D066)
                lab.layer.borderColor = UIColor.hexColor(hexValue: 0x3D066).cgColor
                lab.backgroundColor = UIColor.hexColor(hexValue: 0xEFFFF6)
            } else {
                lab.textColor = UIColor.hexColor(hexValue: 0x41414)
                lab.layer.borderColor = UIColor.hexColor(hexValue: 0xEAECED).cgColor
                lab.backgroundColor = .white
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        lab = UILabel()
        lab.text = "100"
        lab.textAlignment = .center
        lab.layer.borderWidth = 1
        lab.layer.cornerRadius = 8
        lab.layer.masksToBounds = true
        lab.textColor = UIColor.hexColor(hexValue: 0x41414)
        lab.layer.borderColor = UIColor.hexColor(hexValue: 0xEAECED).cgColor
        lab.backgroundColor = .white
        lab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(lab)
        
        lab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(6.5)
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

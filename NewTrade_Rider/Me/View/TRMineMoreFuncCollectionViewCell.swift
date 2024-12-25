//
//  TRMineMoreFuncCollectionViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineMoreFuncCollectionViewCell: UICollectionViewCell {
    var btn : TRButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    

    private func setupView(){
        contentView.backgroundColor = .white
        btn = TRButton(frame: .zero)
        btn.lab.textAlignment = .center
        btn.imgV.snp.remakeConstraints { make in
            make.width.height.equalTo(30)
            make.top.equalTo(btn)
            make.centerX.equalTo(btn)
        }
        btn.lab.snp.remakeConstraints { make in
            make.left.right.equalTo(btn)
            make.top.equalTo(btn.imgV.snp.bottom).offset(2)
        }
        btn.lab.font = UIFont.trFont(fontSize: 13)
        btn.lab.textColor = UIColor.hexColor(hexValue: 0x141414)
        contentView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.right.bottom.equalTo(contentView)
        }
        
        btn.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

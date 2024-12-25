//
//  TRProvinceKeyBoardItem.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRProvinceKeyBoardItem: UICollectionViewCell {
    let w = (Screen_Width - 16 - 6 * 7) / 10
    var itemLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        itemLab = UILabel()
        itemLab.text = "甘"
        itemLab.layer.cornerRadius = 6
        itemLab.layer.masksToBounds = true
        itemLab.backgroundColor = .white
        itemLab.textAlignment = .center
        itemLab.textColor = .txtColor()
        itemLab.font = UIFont.trMediumFont(fontSize: 18)
        contentView.addSubview(itemLab)
        itemLab.snp.makeConstraints { make in
            make.height.equalTo(w + 8)
            make.width.equalTo(w)
            make.top.bottom.left.right.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

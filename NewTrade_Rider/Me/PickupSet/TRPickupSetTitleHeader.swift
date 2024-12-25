//
//  TRPickupSetTitleHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRPickupSetTitleHeader: UITableViewHeaderFooterView {

    var titleLab : UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "派单"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(titleLab)
        contentView.backgroundColor = UIColor.white
        let topView = UIView()
        topView.backgroundColor = .bgColor()
        contentView.addSubview(topView)
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(topView.snp.bottom).offset(15)
        }
  
        topView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

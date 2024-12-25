//
//  TRTaskDetailTableViewHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit

class TRTaskDetailTableViewHeader: UITableViewHeaderFooterView {
    var nameLab : UILabel!
    var numLab : UILabel!
    var priceLab : UILabel!
    var unitLab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        nameLab = UILabel()
        nameLab.text = "商品清单"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(nameLab)
        
        numLab = UILabel()
        numLab.text = "3份"
        numLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        numLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(numLab)
        
        unitLab = UILabel()
        unitLab.text = "¥"
        unitLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        unitLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(unitLab)
        
        priceLab = UILabel()
        priceLab.text = "99999.99"
        priceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        priceLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(priceLab)
        
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(16)
        }
        numLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.centerX.equalTo(contentView).offset(50)
        }
        priceLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(16)
        }
        unitLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(priceLab.snp.left).offset(-2)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

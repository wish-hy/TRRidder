//
//  TROrderDetailTableViewHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TROrderDetailTableViewHeader: UITableViewHeaderFooterView {
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
        nameLab.text = "罚单"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(nameLab)
        
        numLab = UILabel()
        numLab.text = "3份"
        numLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        numLab.font = UIFont.trBoldFont(fontSize: 15)
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
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
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
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(0)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

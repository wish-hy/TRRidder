//
//  TRRiderApplyCerInfoBasicCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit

class TRRiderApplyCerInfoBasicCell: UITableViewCell {

    var itemLab : UILabel!
    var valueLab : UILabel!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        itemLab = TRFactory.labelWith(font: .trFont(16), text: "姓名", textColor: .txtColor(), superView: bgView)
        valueLab = TRFactory.labelWith(font: .trFont(16), text: "姓名", textColor: .txtColor(), superView: bgView)
        valueLab.numberOfLines = 0
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
        valueLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(107)
            make.right.equalTo(bgView).inset(10)
            make.height.greaterThanOrEqualTo(15)
            make.top.bottom.equalTo(bgView).inset(10)
        }
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(15)
            make.top.equalTo(valueLab)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

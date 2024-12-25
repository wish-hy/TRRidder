//
//  TRTaskDetailItemFooter.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/1.
//

import UIKit

class TRTaskDetailItemFooter: UITableViewHeaderFooterView {
    var itemLab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    

    
    
    private func setUI(){
        contentView.backgroundColor = .bgColor()
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        let lab = TRFactory.labelWith(font: .trMediumFont(14), text: "合计数量：X", textColor: .txtColor(), superView: contentView)
        
        itemLab = TRFactory.labelWith(font: .trBoldFont(20), text: "1", textColor: .txtColor(), superView: contentView)
        
        itemLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(16)
            make.top.bottom.equalTo(bgView).inset(15)
            
        }
        lab.snp.makeConstraints { make in
            make.centerY.equalTo(itemLab)
            make.right.equalTo(itemLab.snp.left).offset(-2)
        }
        bgView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(10)
            make.left.right.top.equalTo(contentView)
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

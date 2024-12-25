//
//  TRTaskDetailRemarkHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/1.
//

import UIKit

class TRTaskDetailRemarkHeader: UITableViewHeaderFooterView {

    var remarkLab : UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    func setUI(){
        contentView.backgroundColor = .white
        let bgView = UIView()
        bgView.trCorner(2)
        bgView.backgroundColor = .hexColor(hexValue: 0xFFF8E9)
        contentView.addSubview(bgView)
        
        let lab = TRFactory.labelWith(font: .trMediumFont(12), text: "备注", textColor: .white, superView: bgView)
        lab.textAlignment = .center
        lab.backgroundColor = .hexColor(hexValue: 0xFFAC60)
        lab.trCorner(5)
        remarkLab = TRFactory.labelWith(font: .trBoldFont(17), text: "--", textColor: .txtColor(), superView: bgView)
        remarkLab.numberOfLines = 0
        
        lab.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.top.left.equalTo(bgView).inset(8)
        }
        remarkLab.snp.makeConstraints { make in
            make.left.equalTo(lab.snp.right).offset(8)
            make.top.equalTo(lab)
            make.right.equalTo(bgView).inset(8)
            make.bottom.equalTo(bgView).inset(8)
        }
        
        
        
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(4)
            make.height.greaterThanOrEqualTo(37)
        }
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

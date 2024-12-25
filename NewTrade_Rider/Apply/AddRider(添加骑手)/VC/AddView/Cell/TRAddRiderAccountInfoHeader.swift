//
//  TRAddRiderAccountInfoHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/25.
//

import UIKit

class TRAddRiderAccountInfoHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 200), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer;
        contentView.addSubview(bgView)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
        let itemLab = TRFactory.labelWith(font: .trBoldFont(20), text: "填写报名信息", textColor: .txtColor(), superView: contentView)
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView).offset(15)
            make.bottom.equalTo(bgView).inset(15)
        }
    }

    
}

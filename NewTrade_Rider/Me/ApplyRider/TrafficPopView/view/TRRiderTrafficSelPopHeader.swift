//
//  TRRiderTrafficSelPopHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/26.
//

import UIKit

class TRRiderTrafficSelPopHeader: UITableViewHeaderFooterView {
    var itemLab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    

    private func setupUI(){
        contentView.backgroundColor = .bgColor()
        let bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 100), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer;
        
        itemLab = TRFactory.labelWith(font: .trBoldFont(16), text: "可用车辆", textColor: .txtColor(), superView: bgView)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(0)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView).offset(12)
            make.bottom.equalTo(bgView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

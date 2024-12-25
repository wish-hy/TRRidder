//
//  TRAddInfoTItleHeader.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRAddInfoTItleHeader: UITableViewHeaderFooterView {

    var lab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    

    private func setupView(){
        contentView.backgroundColor = .clear
        let bgView = UIView()
        bgView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer;
        contentView.addSubview(bgView)
        
        lab = UILabel()
        lab.text = "骑手账号信息"
        lab.textColor = .txtColor()
        lab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(lab)
        
        lab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView).offset(15)
            make.bottom.equalTo(bgView).offset(-5)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.left.right.equalTo(contentView).inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

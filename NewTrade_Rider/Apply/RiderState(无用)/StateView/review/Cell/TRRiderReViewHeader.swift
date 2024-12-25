//
//  TRRiderReViewHeader.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderReViewHeader: UITableViewHeaderFooterView {
    var titleLab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    

    
    
    private func setupUI(){
        contentView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer
        titleLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 20), text: "骑手证件信息", textColor: .txtColor(), superView: contentView)
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(12)
            make.top.bottom.equalTo(contentView).inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

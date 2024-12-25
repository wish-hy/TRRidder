//
//  TRCancelAcountTitleCell.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/4/26.
//

import UIKit

class TRCancelAcountTitleCell: UITableViewCell {
    var warnIcon : UIImageView!
    var titleLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        warnIcon = TRFactory.imageViewWith(image: UIImage(named: "warning"), mode: .scaleAspectFit, superView: contentView)
        titleLab = TRFactory.labelWith(font: .trBoldFont(16), text: "注销账号操作不可恢复，且账号内的资料以及权益资产将自动视为放弃", textColor: .txtColor(), superView: contentView)
        titleLab.numberOfLines = 0
        titleLab.textAlignment = .center
        
        let line = UIView()
        line.backgroundColor = .lineColor()
        contentView.addSubview(line)
        
        warnIcon.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(15)
            make.height.width.equalTo(50 * TRWidthScale)
        }
        titleLab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(warnIcon.snp.bottom).offset(25)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

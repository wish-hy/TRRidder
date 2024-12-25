//
//  TRAreaStreetSelCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/19.
//

import UIKit

class TRAreaStreetSelCell: UITableViewCell {
    var itemLab : UILabel!
    var arrowImgV : UIImageView!
    
    var isSel = false{
        didSet {
            if isSel {
                itemLab.textColor = .themeColor()
                itemLab.font = .trMediumFont(16)
                arrowImgV.isHidden = false
            } else {
                itemLab.font = .trFont(16)
                itemLab.textColor = .txtColor()
                arrowImgV.isHidden = true
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        itemLab = TRFactory.labelWith(font: .trMediumFont(16), text: "兴东街道", textColor: .txtColor(), superView: contentView)
        arrowImgV = TRFactory.imageViewWith(image: UIImage(named: "address_sel"), mode: .scaleAspectFit, superView: contentView)
        
        
        itemLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        arrowImgV.snp.makeConstraints { make in
            make.height.width.equalTo(22)
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(12)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRSearchLocCell.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/12.
//

import UIKit

class TRSearchLocCell: UITableViewCell {

    var itemLab : UILabel!
    var desLab : UILabel!
    var selImgV : UIImageView!
    
    var isSel : Bool = true {
        didSet{
            selImgV.isHidden = !isSel
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        itemLab = TRFactory.labelWith(font: .trMediumFont(15), text: "兴东南天辉创研中心", textColor: .txtColor(), superView: contentView)
        itemLab.numberOfLines = 0
        desLab = TRFactory.labelWith(font: .trFont(13), text: "宝安区留仙二路1巷16号", textColor: .hexColor(hexValue: 0x9B9C9C), superView: contentView)
        desLab.numberOfLines = 0
        selImgV = UIImageView(image: UIImage(named: "loc_sel"))
        contentView.addSubview(selImgV)
        let line  = UIView()
        line.backgroundColor = .bgColor()
        contentView.addSubview(line)
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(selImgV.snp.left).offset(-8)
            make.top.equalTo(contentView).inset(10)
        }
        desLab.snp.makeConstraints { make in
            make.left.right.equalTo(itemLab)
            make.top.equalTo(itemLab.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).inset(10)
        }
        selImgV.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(16)
            make.width.height.equalTo(22)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRTaskDetailItemCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/1.
//

import UIKit

class TRTaskDetailItemCell: UITableViewCell {

    var itemImgV : UIImageView!
    var titleLab : UILabel!
    var snsLab : UILabel!
    var numLab : UILabel!
    var priceLab : UILabel!
    var picDidBlock : Int_Block?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        itemImgV = TRFactory.imageViewWith(image: UIImage(named: "chat_func_camera"), mode: .scaleAspectFill, superView: bgView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgAction))
        itemImgV.addGestureRecognizer(tap)
        itemImgV.isUserInteractionEnabled = true
        itemImgV.trCorner(4)
        titleLab = TRFactory.labelWith(font: .trFont(14), text: "", textColor: .txtColor(), superView: bgView)
        titleLab.numberOfLines = 2
        snsLab = TRFactory.labelWith(font: .trFont(12), text: "", textColor: .hexColor(hexValue: 0x9B9C9C), superView: bgView)
        snsLab.numberOfLines = 2
        
        numLab = TRFactory.labelWith(font: .trFont(14), text: "", textColor: .txtColor(), superView: bgView)
        numLab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
//        priceLab = TRFactory.labelWith(font: .trFont(<#T##fontSize: CGFloat##CGFloat#>), text: <#T##String#>, textColor: <#T##UIColor#>, superView: <#T##UIView#>)
        numLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab)
            make.right.equalTo(contentView).inset(15)
        }
        itemImgV.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.top.equalTo(bgView).offset(16)
            make.left.equalTo(bgView).offset(16)
            make.bottom.equalTo(bgView).inset(16)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(itemImgV.snp.right).offset(8)
            make.right.equalTo(numLab.snp.right).offset(-16)
            make.top.equalTo(itemImgV.snp.top).offset(10)
        }
        snsLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.bottom.equalTo(itemImgV.snp.bottom).inset(10)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
            make.bottom.greaterThanOrEqualTo(snsLab.snp.bottom).offset(15)
            make.height.greaterThanOrEqualTo(91)
        }
    }
    @objc func imgAction(){
        if picDidBlock != nil {
            picDidBlock!(0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRBottomPopTipHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRBottomPopTipHeader: UITableViewHeaderFooterView {

    var tipView : TRBottomPopTipVIew!
    
    var quLab : UILabel!
    var nameLab : UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews(){
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        tipView = TRBottomPopTipVIew(frame: .zero)
//        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 54, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = maskPath.cgPath
//        self.layer.mask = maskLayer;
        contentView.addSubview(tipView)
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        whiteView.layer.mask = maskLayer;
        contentView.addSubview(whiteView)
        
        quLab = UILabel()
        quLab.backgroundColor = UIColor.hexColor(hexValue: 0xFA651F)
        quLab.text = "取"
        quLab.textAlignment = .center
        quLab.layer.cornerRadius = 3
        quLab.layer.masksToBounds = true
        quLab.textColor = .white
        quLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(quLab)
        
        nameLab = UILabel()
        nameLab.text = "#01 7Elevent便利店"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x97989A )
        nameLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(nameLab)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        whiteView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(tipView.snp.bottom).inset(22)
        }
        tipView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(80)
        }
        quLab.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(whiteView).offset(18)
            make.left.equalTo(contentView).offset(16)
        }
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(quLab)
            make.left.equalTo(quLab.snp.right).offset(5)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

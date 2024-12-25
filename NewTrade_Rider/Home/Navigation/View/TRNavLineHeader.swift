//
//  TRNavLineHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit

class TRNavLineHeader: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUII()
    }
    

    
    private func setupUII(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 13, height: 13))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer;
        contentView.addSubview(bgView)
        
        let upView = UIView()
        upView.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        upView.layer.cornerRadius = 3
        upView.layer.masksToBounds = true
        bgView.addSubview(upView)
        
        let startImgV = UIImageView(image: UIImage(named: "nav_start"))
        bgView.addSubview(startImgV)
        
        let startLab = UILabel()
        startLab.text = "开始出发"
        startLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        startLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(startLab)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xD2D5D7)
        contentView.addSubview(line)
        
        bgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
        upView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(bgView).offset(10)
            make.height.equalTo(5)
            make.width.equalTo(38)
        }
        
        startImgV.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(15)
            make.top.equalTo(upView.snp.bottom).offset(19)
            make.width.height.equalTo(36)
        }
        startLab.snp.makeConstraints { make in
            make.centerY.equalTo(startImgV)
            make.left.equalTo(startImgV.snp.right).offset(9)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(33)
            make.top.equalTo(startImgV.snp.bottom).offset(2)
            make.width.equalTo(1)
            make.bottom.equalTo(contentView)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

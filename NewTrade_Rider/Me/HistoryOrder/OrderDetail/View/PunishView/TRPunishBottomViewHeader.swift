//
//  TRPunishBottomViewHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRPunishBottomViewHeader: UITableViewHeaderFooterView {

    var stateLab : UILabel!
    
    var nameLab : UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews(){
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        stateLab = UILabel()
        stateLab.text = "未执行"
        stateLab.layer.cornerRadius = 4
        stateLab.layer.masksToBounds = true
        contentView.addSubview(stateLab)
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        whiteView.layer.mask = maskLayer;
        contentView.addSubview(whiteView)
        
        nameLab = UILabel()
        nameLab.text = "罚单"
        
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414 )
        nameLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(nameLab)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        whiteView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(contentView.snp.top).offset(0)
        }
        stateLab.snp.makeConstraints { make in
            make.centerY.equalTo(nameLab)
            make.right.equalTo(contentView).offset(-16)
            make.height.equalTo(25)
            make.width.equalTo(50)
        }

        nameLab.snp.makeConstraints { make in
            make.top.equalTo(whiteView).offset(20)
            make.left.equalTo(contentView).offset(15)
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

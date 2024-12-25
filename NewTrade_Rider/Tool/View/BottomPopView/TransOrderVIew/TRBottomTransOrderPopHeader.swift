//
//  TRBottomTransOrderPopHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit

class TRBottomTransOrderPopHeader: UITableViewHeaderFooterView {

    var tipView : TRBottomPopTipVIew!
    
    
    var reasonLab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews(){
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        tipView = TRBottomPopTipVIew(frame: .zero)
        tipView.tipLab.text = "为不影响配送时间，遇到问题及时转单\n转单打赏最低 1 元"
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
        
        let pointLab = UILabel()
        pointLab.text = "*"
        pointLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        pointLab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(pointLab)
        
        let nameLab = UILabel()
        nameLab.text = "转单原因"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(nameLab)
        
        reasonLab = UILabel()
        reasonLab.text = "车子故障"
        reasonLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        reasonLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(reasonLab)
        
        let arrowImgV = UIImageView()
        arrowImgV.image = UIImage(named: "advance_gray")
        contentView.addSubview(arrowImgV)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        pointLab.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(16)
        }
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(pointLab)
            make.left.equalTo(pointLab.snp.right).offset(0)
        }
        
        whiteView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(tipView.snp.bottom).inset(22)
        }
        tipView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(80)
        }

        nameLab.snp.makeConstraints { make in
            make.top.equalTo(whiteView).offset(15)
            make.left.equalTo(contentView).offset(15)
        }

        reasonLab.snp.makeConstraints { make in
            make.centerY.equalTo(nameLab)
            make.right.equalTo(contentView).offset(-32)
        }
        arrowImgV.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.right.equalTo(contentView).offset(-16)
            make.centerY.equalTo(nameLab)
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

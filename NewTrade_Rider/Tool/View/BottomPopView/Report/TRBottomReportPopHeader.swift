//
//  TRBottomReportPopHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRBottomReportPopHeader: UITableViewHeaderFooterView {

    var tipView : TRBottomPopTipVIew!
    
    var nameLab : UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews(){
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        tipView = TRBottomPopTipVIew(frame: .zero)
        tipView.tipLab.text = "遇到恶劣天气、车辆故障等问题，请及时上报异常\n上报后将获得额外补充时间，最长 30 分钟"
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
        
        nameLab = UILabel()
        nameLab.text = "异常上报"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414 )
        nameLab.font = UIFont.trBoldFont(fontSize: 18)
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

        nameLab.snp.makeConstraints { make in
            make.top.equalTo(whiteView).offset(15)
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

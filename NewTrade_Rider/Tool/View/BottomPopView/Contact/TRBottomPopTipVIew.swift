//
//  TRBottomPopTipVIew.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRBottomPopTipVIew: UIView {
    var tipLab : UILabel!
    var tipIcon : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = UIColor.hexColor(hexValue: 0xFCF6DB)
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer;
//        self.layer.cornerRadius = 20
//        self.layer.masksToBounds = true
        
        tipIcon = UIImageView()
        tipIcon.image = UIImage(named: "pop_tip")
        self.addSubview(tipIcon)
        
        tipLab = UILabel()
        tipLab.numberOfLines = 0
        tipLab.text = "为保证服务体验，您在拨打或者接听隐私号电话时，可能会\n被录音"
        tipLab.textColor = UIColor.hexColor(hexValue: 0xFA651F)
        tipLab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(tipLab)
        
        tipIcon.snp.makeConstraints { make in
            make.left.equalTo(self).offset(14)
            make.top.equalTo(self).offset(16)
            make.width.height.equalTo(16)
        }
        tipLab.snp.makeConstraints { make in
            make.right.equalTo(self).inset(16)
            make.top.equalTo(tipIcon)
            make.left.equalTo(tipIcon.snp.right).offset(5)
        }
    }
    func subViewToTop(){
        tipIcon.snp.remakeConstraints { make in
            make.left.equalTo(self).offset(14)
            make.top.equalTo(self).offset(10)
            make.width.height.equalTo(16)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

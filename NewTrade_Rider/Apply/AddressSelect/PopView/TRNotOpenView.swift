//
//  TRNotOpenView.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/13.
//

import UIKit

class TRNotOpenView: TRPopBaseView {

    var nameLab : UILabel!
    var addressLab : UILabel!
    
    var tipLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        bgView.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(tapAction))
        bgView.addGestureRecognizer(tapGes)
        nameLab = TRFactory.labelWith(font: .trFont(14), text: "定位地址未在开通区域：", textColor: .hexColor(hexValue: 0x67686A), superView: contentView)
        addressLab = TRFactory.labelWith(font: .trMediumFont(14), text: "广东省深圳市宝安区留仙二路1巷16号", textColor: .txtColor(), superView: contentView)
        addressLab.textAlignment = .center
        tipLab = TRFactory.labelWith(font: .trBoldFont(14), text: "当前区域暂未开通\n请重新定位详细地址", textColor: .hexColor(hexValue: 0xF54444), superView: contentView)
        addressLab.numberOfLines = 0
        tipLab.numberOfLines = 0
        let closeBtn = TRFactory.buttonWith(image: UIImage(named: "nav_cancel"), superView: contentView)
        closeBtn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        contentView.snp.remakeConstraints { make in
            make.centerY.equalTo(self)
            make.left.right.equalTo(self).inset(37 * TRWidthScale)
        }
        nameLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(20)
        }
        addressLab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(25)
            make.top.equalTo(nameLab.snp.bottom).offset(8)
        }
        tipLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(addressLab.snp.bottom).offset(23)
            make.bottom.equalTo(contentView).inset(25)
        }
        closeBtn.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.top.right.equalTo(contentView).inset(15)
        }
    }
    @objc func tapAction(){
        self.removeFromSuperview()
    }
    @objc func dismissView(){
        self.removeFromSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

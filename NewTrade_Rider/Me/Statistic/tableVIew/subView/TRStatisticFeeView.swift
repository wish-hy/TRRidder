//
//  TRStatisticFeeView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStatisticFeeView: UIView {
    var iconImgV : UIImageView!
    var titleLab : UILabel!
    
    var valueLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        iconImgV = UIImageView(image: UIImage(named: "statistic_rank"))
        self.addSubview(iconImgV)
        
        titleLab = UILabel()
        titleLab.text = "昨日收入(元)"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        titleLab.font = UIFont.trFont(fontSize: 14)
        self.addSubview(titleLab)
        
        valueLab = UILabel()
        valueLab.text = "0"
        valueLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        valueLab.font = UIFont.trBoldFont(fontSize: 23)
        self.addSubview(valueLab)
        
        iconImgV.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(self)
            make.left.equalTo(self)
        }
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgV)
            make.left.equalTo(iconImgV.snp.right).offset(2)
        }
        
        valueLab.snp.makeConstraints { make in
            make.left.equalTo(iconImgV)
            make.top.equalTo(iconImgV.snp.bottom).offset(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

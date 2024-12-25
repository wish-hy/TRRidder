//
//  TRStatisticInfoView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStatisticInfoView: UIView {
    var titleLab : UILabel!
    var valueLab : UILabel!
    
    var iconImgV : UIImageView!
    var rankLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "总收入(元)"
        titleLab.textColor = .white
        titleLab.font = UIFont.trFont(fontSize: 15)
        self.addSubview(titleLab)
        
        valueLab = UILabel()
        valueLab.text = "0"
        valueLab.textColor = .white
        valueLab.font = UIFont.trBoldFont(fontSize: 28)
        self.addSubview(valueLab)
        
        rankLab = UILabel()
        rankLab.text = "排名--"
        rankLab.textColor = UIColor.hexColor(hexValue: 0xDBF3E6)
        rankLab.font = UIFont.trFont(fontSize: 14)
        self.addSubview(rankLab)
        
        iconImgV = UIImageView(image: UIImage(named: "statistic_rank"))
        self.addSubview(iconImgV)
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.top.equalTo(self)
        }
        valueLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
        }
        iconImgV.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(valueLab.snp.bottom).offset(8)
            make.width.height.equalTo(20)
        }
        rankLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgV)
            make.left.equalTo(iconImgV.snp.right).offset(2)
        }
        
    }
    func subTheme1(){
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        valueLab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        valueLab.font = UIFont.trBoldFont(fontSize: 23)
        rankLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        rankLab.font = UIFont.trFont(fontSize: 13)
        iconImgV.image = UIImage(named: "statistic_rank_gray")

        valueLab.snp.remakeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
        }
        iconImgV.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(valueLab.snp.bottom).offset(5)
            make.width.height.equalTo(15)
        }
        rankLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgV)
            make.left.equalTo(iconImgV.snp.right).offset(2)
        }
    }
    
    func subTheme2(){
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        valueLab.textColor = UIColor.hexColor(hexValue: 0xFA651F)
        valueLab.font = UIFont.trBoldFont(fontSize: 18)
        rankLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        rankLab.font = UIFont.trFont(fontSize: 13)
        iconImgV.image = UIImage(named: "statistic_rank_gray")
        
        valueLab.snp.remakeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
        }
        iconImgV.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(valueLab.snp.bottom).offset(5)
            make.width.height.equalTo(15)
        }
        rankLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgV)
            make.left.equalTo(iconImgV.snp.right).offset(2)
        }
    }
    
    func subTheme3(){
        titleLab.textColor = UIColor.hexColor(hexValue: 0x686A6A )
        titleLab.font = UIFont.trFont(fontSize: 13)
        valueLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        valueLab.font = UIFont.trBoldFont(fontSize: 20)
        rankLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        rankLab.font = UIFont.trFont(fontSize: 13)
    
        iconImgV.image = UIImage(named: "statistic_rank_gray")
        
        valueLab.snp.remakeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        iconImgV.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(valueLab.snp.bottom).offset(5)
            make.width.height.equalTo(15)
        }
        rankLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgV)
            make.left.equalTo(iconImgV.snp.right).offset(2)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

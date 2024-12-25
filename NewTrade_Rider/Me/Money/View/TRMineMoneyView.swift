//
//  TRMineMoneyView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineMoneyView: UIView {
    
    var contentView : UIView!
    
    var titleLab : UILabel!
    
    var valueLab : UILabel!
    
    var detailLab : UILabel!
    
    var actionBtn : UIButton!
    
    var bgImgV : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        
        contentView = UIView()
        contentView.layer.cornerRadius = 13
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .bgColor()
        self.addSubview(contentView)
        
        bgImgV = UIImageView(image: UIImage(named: "yq_bg"))
        contentView.addSubview(bgImgV)
        
        titleLab = UILabel()
        titleLab.text = "邀请骑手"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(titleLab)
        
        valueLab = UILabel()
        valueLab.text = "100"
        valueLab.textColor = UIColor.hexColor(hexValue: 0xDF6241 )
        valueLab.font = UIFont.trBoldFont(fontSize: 32)
        contentView.addSubview(valueLab)
        
        
        detailLab = UILabel()
        detailLab.text = "赚 30.00 元已到钱包余额"
        detailLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        detailLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(detailLab)
        
        actionBtn = UIButton(frame: .zero)
        actionBtn.setTitle("去邀请", for: .normal)
        actionBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        actionBtn.setTitleColor(UIColor.hexColor(hexValue: 0xDF6241), for: .normal)
        contentView.addSubview(actionBtn)
        
 
        
        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
            
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgImgV).offset(15)
            make.top.equalTo(bgImgV).offset(15)
        }
        valueLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(8)
        }
        
        detailLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(valueLab.snp.bottom).offset(3)
        }
        
        actionBtn.snp.makeConstraints { make in
            make.bottom.equalTo(detailLab)
            make.right.equalTo(contentView).offset(-30)
            make.width.equalTo(78)
            make.height.equalTo(34)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

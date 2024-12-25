//
//  TRMineMoneyBalanceView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineMoneyBalanceView: UIView {
    
    var contentView : UIView!
    
    var titleLab : UILabel!
    
    var priceLab : UILabel!
    
    var actionBtn : TRRightButton!
    
    var bgImgV : UIImageView!
    
    var bzjBtn : TRRightButton!
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
        
        bgImgV = UIImageView(image: UIImage(named: "yue_bg"))
        contentView.addSubview(bgImgV)
        
        titleLab = UILabel()
        titleLab.text = "钱包余额"
        titleLab.textColor = .white
        titleLab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(titleLab)
        
        priceLab = UILabel()
        priceLab.text = "100"
        priceLab.textColor = .white
        priceLab.font = UIFont.trBoldFont(fontSize: 32)
        contentView.addSubview(priceLab)
        
        actionBtn = TRRightButton(frame: .zero)
        actionBtn.lab.text = "提现"
        actionBtn.lab.textColor = .red
        actionBtn.lab.font = UIFont.trFont(fontSize: 16)
        actionBtn.imgV.image = UIImage(named: "tx_arrow")
        actionBtn.backgroundColor = UIColor.hexColor(hexValue: 0xFFFEF1)
        actionBtn.layer.cornerRadius = 17
        actionBtn.layer.masksToBounds = true
        contentView.addSubview(actionBtn)
        
        bzjBtn = TRRightButton(frame: .zero)
        bzjBtn.lab.text = "接单保证金:"
        bzjBtn.lab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        bzjBtn.lab.font = UIFont.trFont(fontSize: 16)
        bzjBtn.imgV.image = UIImage(named: "blance_arrow")
        contentView.addSubview(bzjBtn)
        
        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-35)
        }
        
        bzjBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView)
            make.height.equalTo(34)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgImgV).offset(15)
            make.top.equalTo(bgImgV).offset(35)
        }
        priceLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
        }
        
        actionBtn.snp.makeConstraints { make in
            make.centerY.equalTo(priceLab)
            make.right.equalTo(contentView).offset(-15)
//            make.width.equalTo(78)
            make.height.equalTo(34)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

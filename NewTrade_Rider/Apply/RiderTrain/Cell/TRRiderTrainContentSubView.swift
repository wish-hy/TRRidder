//
//  TRRiderTrainContentSubView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/26.
//

import UIKit

class TRRiderTrainContentSubView: UIView {
    var bgView : UIView!
    
    var itemImgV : UIImageView!
    var itemLab : UILabel!
    
    var stateLab : UILabel!
    var stateImgV : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        bgView = UIView()
        bgView.trCorner(8)
        bgView.backgroundColor = .hexColor(hexValue: 0xF4F6F8)
        self.addSubview(bgView)
        
        itemImgV = TRFactory.imageViewWith(image: UIImage(named: ""), mode: .scaleToFill, superView: bgView)
        itemLab = TRFactory.labelWith(font: .trMediumFont(16), text: "", textColor: .txtColor(), superView: bgView)
        
        stateImgV = TRFactory.imageViewWith(image: UIImage(named: "rider_train_done"), mode: .scaleAspectFit, superView: bgView)
        stateLab = TRFactory.labelWith(font: .trFont(14), text: "尚未参加培训", textColor: .hexColor(hexValue: 0x97989A), superView: bgView)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(0)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        itemImgV.snp.makeConstraints { make in
            make.height.width.equalTo(34)
            make.left.equalTo(bgView).offset(12)
            make.top.bottom.equalTo(bgView).inset(10)
        }
        itemLab.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.left.equalTo(itemImgV.snp.right).offset(10)
        }
        stateImgV.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(10)
            make.centerY.equalTo(bgView)
            make.width.height.equalTo(54)
            
        }
        stateLab.snp.makeConstraints { make in
            make.centerY.right.equalTo(stateImgV)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

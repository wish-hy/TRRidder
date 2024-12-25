//
//  TROrderPayMethodSubView.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/10/9.
//

import UIKit

class TROrderPayMethodSubView: UIButton {
    var imgV : UIImageView!
    var titleLab : UILabel!
    
    var priceLab : UILabel!
    var selImgV : UIImageView!
    var bgView : UIView!
    var line : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        bgView = UIView()
        self.addSubview(bgView)
        
        imgV = UIImageView(image: UIImage(named: "loaction_nor"))
        bgView.addSubview(imgV)
        
        titleLab = UILabel()
        titleLab.text = "微信支付"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        titleLab.font = UIFont.trFont(fontSize: 17)
        self.addSubview(titleLab)
        
        selImgV = UIImageView(image: UIImage(named: "loaction_nor"))
        bgView.addSubview(selImgV)
      
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.bottom.equalTo(self)
        }
        
        imgV.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(20)
            make.left.equalTo(bgView).offset(13)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(imgV)
            make.left.equalTo(imgV.snp.right).offset(5)
        }
  
        selImgV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 22, height: 22))
            make.centerY.equalTo(titleLab)
            make.right.equalTo(bgView).inset(10)
        }
        for v in self.subviews {
            v.isUserInteractionEnabled = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

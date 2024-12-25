//
//  TRMessageNotiTipView.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/25.
//

import UIKit

class TRMessageNotiTipView: UIView {
    var tipLab : UILabel!
    
    var openBtn : UIButton!
    
    var cancelBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
//        let bgImgV = UIImageView(image: UIImage(named: "message_topbg"))
//        bgImgV.contentMode = .scaleAspectFill
//        self.addSubview(bgImgV)
        tipLab = UILabel()
        tipLab.text = "开启消息通知，订单配送消息不错过"
        tipLab.textColor = UIColor.hexColor(hexValue: 0x0DBC70)
        tipLab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(tipLab)
        // message_close
        openBtn = UIButton()
        openBtn.setTitle("去开启", for: .normal)
        openBtn.setTitleColor(.white, for: .normal)
        openBtn.titleLabel?.font = UIFont.trFont(fontSize: 13)
        openBtn.layer.cornerRadius = 12
        openBtn.backgroundColor = UIColor.lightThemeColor()
        openBtn.layer.masksToBounds = true
        self.addSubview(openBtn)
        
        cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(named: "message_close"), for: .normal)
        self.addSubview(cancelBtn)
        
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(self).offset(27)
            make.top.equalTo(self)
        }
        
        openBtn.snp.makeConstraints { make in
            make.centerY.equalTo(tipLab)
            make.right.equalTo(cancelBtn.snp.left).offset(-10)
            make.height.equalTo(24)
            make.width.equalTo(51)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.centerY.equalTo(tipLab)
            make.right.equalTo(self).offset(-23)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRRiderStateHeader.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderStateHeader: UIView {
    var userImgV : UIImageView!
    var nameLab : UILabel!
    var phoneLab : UILabel!
    var typeLab : UILabel!
    
    var progressView : TRStepProgressView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        let bgImgV = UIImageView(image: UIImage(named: "rider_state_top_bg"))
        self.addSubview(bgImgV)
        
        let infoBgView = UIView()
        infoBgView.backgroundColor = .white
        infoBgView.layer.cornerRadius = 12
        infoBgView.layer.masksToBounds = true
        self.addSubview(infoBgView)
        
        userImgV = TRFactory.imageViewWith(image: UIImage(named: "content"), mode: .scaleAspectFill, superView: infoBgView)
        
        nameLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 20), text: "阿龙", textColor: .txtColor(), superView: infoBgView)

        
        phoneLab = UILabel()
        phoneLab.attributedText = TRTool.richText(str1: "手机号码：", font1: .trFont(fontSize: 14), color1: .txtColor(), str2: "12321235698", font2: .trMediumFont(fontSize: 14), color2:  .txtColor())
        infoBgView.addSubview(phoneLab)

        
        let typeTipLab = UILabel()
        typeTipLab.text = "骑手类型："
        typeTipLab.font = .trFont(fontSize: 14)
        typeTipLab.textColor = .txtColor()
        infoBgView.addSubview(typeTipLab)
        
        typeLab = UILabel()
        typeLab.text = "普通骑手"
        typeLab.textAlignment = .center
        typeLab.font = .trFont(fontSize: 14)
        typeLab.textColor = .themeColor()
        typeLab.backgroundColor = .hexColor(hexValue: 0xEEF2FF)
        typeLab.layer.cornerRadius = 4
        typeLab.layer.masksToBounds = true
        infoBgView.addSubview(typeLab)
        
        progressView = TRStepProgressView(frame: .zero)
        progressView.titles = ["待审核","待签约","待培训","待上岗"]
        progressView.progress = 1
        self.addSubview(progressView)
        
        userImgV.snp.makeConstraints { make in
            make.left.equalTo(infoBgView).offset(15)
            make.top.equalTo(infoBgView).offset(15)
            make.width.equalTo(82)
            make.height.equalTo(92)
        }
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(userImgV).offset(3)
            make.left.equalTo(userImgV.snp.right).offset(10)
        }
       
       
        phoneLab.snp.makeConstraints { make in
            make.centerY.equalTo(userImgV)
            make.left.equalTo(nameLab).offset(0)
        }
       
        typeTipLab.snp.makeConstraints { make in
            make.bottom.equalTo(userImgV).offset(-3)
            make.left.equalTo(nameLab).offset(0)
        }
        
        typeLab.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.width.equalTo(82)
            make.centerY.equalTo(typeTipLab)
            make.left.equalTo(typeTipLab.snp.right).offset(3)
        }
        bgImgV.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(-StatusBar_Height - 44)
            make.height.equalTo(182)
        }
        
        infoBgView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(122)
            make.top.equalTo(self).offset(15)
        }
        
        progressView.snp.makeConstraints { make in
            make.left.right.equalTo(infoBgView)
            make.top.equalTo(infoBgView.snp.bottom).offset(18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

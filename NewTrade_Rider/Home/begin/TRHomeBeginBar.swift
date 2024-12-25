//
//  TRHomeBeginBar.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/2.
//

import UIKit

class TRHomeBeginBar: UIView {
    var headImgV : UIImageView!
    var helloLab : UILabel!
    var tipLab : UILabel!
    
    var mesBtn : UIButton!
    
    var block : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        headImgV.sd_setImage(with: URL.init(string: TRDataManage.shared.applyModel.riderInfo.profilePicUrl), placeholderImage: UIImage(named: "rider_head_def"))
        headImgV.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(headAction))
        headImgV.addGestureRecognizer(tapGes)
        
        helloLab.text = "Hi！\(TRDataManage.shared.applyModel.riderInfo.name)"
    }
    
    private func setupView(){
        headImgV = TRFactory.imageViewWith(image: UIImage(named: "traffic_ele"), mode: .scaleAspectFill, superView: self)
        headImgV.trCorner(20)
        
        helloLab = TRFactory.labelWith(font: .trBoldFont(18), text: "Hi！", textColor: .txtColor(), superView: self)
        tipLab = TRFactory.labelWith(font: .trFont(12), text: "一份耕耘，一份收获！美好的一天即将开始", textColor: .hexColor(hexValue: 0x54735A), superView: self)
        mesBtn = TRFactory.buttonWith(image: UIImage(named: "message"), superView: self)
        mesBtn.addTarget(self, action: #selector(msgAction), for: .touchUpInside)
        headImgV.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.top.equalTo(self).inset(StatusBar_Height + 8)
            make.height.width.equalTo(40)
        }
        
        helloLab.snp.makeConstraints { make in
            make.left.equalTo(headImgV.snp.right).offset(9)
            make.top.equalTo(headImgV)
        }
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(helloLab)
            make.bottom.equalTo(headImgV)
        }
        mesBtn.snp.makeConstraints { make in
            make.centerY.equalTo(headImgV)
            make.right.equalTo(self).inset(15)
            make.height.width.equalTo(28)
        }

    }
    @objc func headAction(){
        if block != nil {
            block!(0)
        }
    }
    @objc func msgAction(){
        if block != nil {
            block!(1)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

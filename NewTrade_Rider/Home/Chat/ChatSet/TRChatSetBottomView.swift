//
//  TRChatSetBottomView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

import RxCocoa
import RxSwift
class TRChatSetBottomView: TRBottomPopBasicView {
    
    var mesTF : UITextView!
    
    var sureBtn : UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer;
        
        titleLab = UILabel()
        titleLab.text = "编辑自动发送送达消息内容"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        mesTF = UITextView()
        mesTF.text = "亲爱的顾客，您的订单已送达，感谢给我五星"
        mesTF.textColor = UIColor.hexColor(hexValue: 0x141414)
        mesTF.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(mesTF)
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.masksToBounds = true
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        sureBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        sureBtn.layer.cornerRadius = 10
        sureBtn.layer.masksToBounds = true
        contentView.addSubview(sureBtn)
        titleLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(20)
        }
        mesTF.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(titleLab.snp.bottom).offset(40)
            make.height.equalTo(80)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(26)
            make.top.equalTo(mesTF.snp.bottom).offset(15)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(26)
            make.top.equalTo(cancelBtn)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
        
        cancelBtn.rx.tap.subscribe(onNext: {[weak self] in
            self?.closeView()
        }).disposed(by: bag)
        
        sureBtn.rx.tap.subscribe(onNext: {[weak self] in
            self?.closeView()
        }).disposed(by: bag)
    }
}

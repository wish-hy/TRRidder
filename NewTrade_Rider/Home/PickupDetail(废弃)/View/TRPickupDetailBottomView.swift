//
//  TRPickupDetailBottomView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRPickupDetailBottomView: UIView {
    var contentView : UIView!
    var contactBtn : TRButton!
    var questionBtn : TRButton!
    var traOrderBtn : TRButton!
    var patchAmountBtn : TRButton!
    
    var pickupBtn : UIButton!
    /*
     /*
      0:可以补差价
      1:不可以补差价
      2:补差价待支付

      */
     */
    var model : TROrderModel? {
        didSet {
            guard let model = model else { return }
            if model.subType == 0 {
                pickupBtn.backgroundColor = UIColor.hexColor(hexValue: 0xFA651F)
                pickupBtn.setTitleColor(.white, for: .normal)
                pickupBtn.setTitle("我已取货", for: .normal)
                
                patchAmountBtn.isHidden = false
                pickupBtn.snp.remakeConstraints { make in
                    make.centerY.equalTo(contactBtn)
                    make.right.equalTo(contentView).offset(-30)
                    make.left.equalTo(patchAmountBtn.snp.right).offset(30)
                    make.height.equalTo(46)
                }
            } else if model.subType == 1 {
                pickupBtn.backgroundColor = UIColor.hexColor(hexValue: 0xFA651F)
                pickupBtn.setTitleColor(.white, for: .normal)
                pickupBtn.setTitle("我已取货", for: .normal)

                patchAmountBtn.isHidden = true
                pickupBtn.snp.remakeConstraints { make in
                    make.centerY.equalTo(contactBtn)
                    make.right.equalTo(contentView).offset(-30)
                    make.left.equalTo(questionBtn.snp.right).offset(30)
                    make.height.equalTo(46)
                }
            } else if model.subType == 2 {
                pickupBtn.setTitle("等待用户支付差价", for: .normal)
                pickupBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
                pickupBtn.setTitleColor(.hexColor(hexValue: 0xF54444), for: .normal)
                patchAmountBtn.isHidden = true
                pickupBtn.snp.remakeConstraints { make in
                    make.centerY.equalTo(contactBtn)
                    make.right.equalTo(contentView).offset(-30)
                    make.left.equalTo(questionBtn.snp.right).offset(30)
                    make.height.equalTo(46)
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        
        contactBtn = TRButton.init(frame: .zero)
        contactBtn.imgV.image = UIImage(named: "pop_phone")
        contactBtn.lab.text = "联系"
        self.addSubview(contactBtn)
        
        questionBtn = TRButton.init(frame: .zero)
        questionBtn.imgV.image = UIImage(named: "pop_question")
        questionBtn.lab.text = "遇到问题"
        self.addSubview(questionBtn)

        traOrderBtn = TRButton(frame: .zero)
        // MARK: - /暂不做转单
        traOrderBtn.isHidden = true
        traOrderBtn.imgV.image = UIImage(named: "zhuandan")
        traOrderBtn.lab.text = "转单"
        self.addSubview(traOrderBtn)
        
        patchAmountBtn = TRButton(frame: .zero)
        patchAmountBtn.imgV.image = UIImage(named: "patchAmount")
        patchAmountBtn.lab.text = "差价"
        self.addSubview(patchAmountBtn)

        pickupBtn = UIButton(frame: .zero)
        pickupBtn.setTitle("我已取货", for: .normal)
        pickupBtn.backgroundColor = UIColor.hexColor(hexValue: 0xFA651F)
        pickupBtn.setTitleColor(.white, for: .normal)
        pickupBtn.titleLabel?.font = .trBoldFont(18)
        pickupBtn.layer.cornerRadius = 23;
        pickupBtn.layer.masksToBounds = true
        self.addSubview(pickupBtn)
        
        contentView.snp.makeConstraints { make in
            make.right.top.bottom.left.equalTo(self)
        }
        
        contactBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(14)
            make.width.equalTo(30)
            make.height.equalTo(50)
            
        }
        
        questionBtn.snp.makeConstraints { make in
            make.left.equalTo(contactBtn.snp.right).offset(16)
            make.top.equalTo(contactBtn)
            make.width.equalTo(42)
            make.height.equalTo(50)
            
        }
        
        patchAmountBtn.snp.makeConstraints { make in
            make.left.equalTo(questionBtn.snp.right).offset(16)
            make.top.equalTo(contactBtn)
            make.width.equalTo(30)
            make.height.equalTo(50)
            
        }
        
        pickupBtn.snp.makeConstraints { make in
            make.centerY.equalTo(contactBtn)
            make.right.equalTo(contentView).offset(-30)
            make.left.equalTo(patchAmountBtn.snp.right).offset(30)
            make.height.equalTo(46)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

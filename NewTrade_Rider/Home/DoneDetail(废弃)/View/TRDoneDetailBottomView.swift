//
//  TRDoneDetailBottomView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRDoneDetailBottomView: UIView {
    var contentView : UIView!
    var contactBtn : TRButton!
    var questionBtn : TRButton!
    
    var doneBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        
        contactBtn = TRButton.init(frame: .zero)
        
        self.addSubview(contactBtn)
        
        questionBtn = TRButton.init(frame: .zero)
        questionBtn.imgV.image = UIImage(named: "question")
        questionBtn.lab.text = "遇到问题"
        self.addSubview(questionBtn)

        doneBtn = UIButton(frame: .zero)
        doneBtn.setTitle("我已送达", for: .normal)
        doneBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        doneBtn.layer.cornerRadius = 23;
        doneBtn.layer.masksToBounds = true
        self.addSubview(doneBtn)
        
        contentView.snp.makeConstraints { make in
            make.right.top.bottom.left.equalTo(self)
        }
        
        contactBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(30)
            make.top.equalTo(contentView).offset(14)
            make.width.equalTo(30)
            make.height.equalTo(50)
            
        }
        
        questionBtn.snp.makeConstraints { make in
            make.left.equalTo(contactBtn.snp.right).offset(27)
            make.top.equalTo(contactBtn)
            make.width.equalTo(42)
            make.height.equalTo(50)
            
        }
    
        
        doneBtn.snp.makeConstraints { make in
            make.centerY.equalTo(contactBtn)
            make.right.equalTo(contentView).offset(-30)
            make.left.equalTo(questionBtn.snp.right).offset(30)
            make.height.equalTo(46)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

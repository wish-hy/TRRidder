//
//  TRAgreementActionView.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/4/26.
//

import UIKit

class TRAgreementActionView: UIView {
    var agreeBtn : UIButton!
    var name : String = "" {
        didSet {
            agreeLab1.text = name
        }
    }
    var agreeLab : UILabel!
    var agreeLab1 : UILabel!
    
    var block : Void_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        agreeBtn = UIButton()
        // loaction_nor
        agreeBtn.setImage(UIImage(named: "uncheck"), for: .normal)
        self.addSubview(agreeBtn)
        agreeLab = UILabel()
        agreeLab.textColor = UIColor.hexColor(hexValue: 0xc6c8cb)
        agreeLab.font = .systemFont(ofSize: 14)
        agreeLab.text = "我已阅读并同意以上";
        self.addSubview(agreeLab)
        
        agreeLab1 = UILabel()
        agreeLab1.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapAction))
        agreeLab1.addGestureRecognizer(tap)
        agreeLab1.textColor = UIColor.hexColor(hexValue: 0xc6c8cb)
        agreeLab1.textColor = .hexColor(hexValue: 0x217DFF)
        agreeLab1.font = .systemFont(ofSize: 14)
        agreeLab1.text = "《注销账号重要提醒》";
        self.addSubview(agreeLab1)
        
        agreeBtn.snp.makeConstraints({ make in
            make.width.height.equalTo(25)
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(14)
        })
        agreeLab.snp.makeConstraints({ make in
            make.centerY.equalTo(agreeBtn)
            make.left.equalTo(agreeBtn.snp.right).offset(3)
        })

        agreeLab1.snp.makeConstraints({ make in
            make.centerY.equalTo(agreeBtn)
            make.left.equalTo(agreeLab.snp.right).offset(3)
            make.height.equalTo(28)
        })
    }
    @objc func tapAction(){
        if block != nil {
            block!()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

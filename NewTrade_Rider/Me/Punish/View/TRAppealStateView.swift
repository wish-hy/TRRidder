//
//  TRAppealStateView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRAppealStateView: UIView {
    
    var stateIcon : UIImageView!
    var stateLab : UILabel!
    var contentView : UIView!
    
    var type : Int = 1{// 1取消 2不通过 3通过 4超时
        didSet{
            if type == 1 {
                contentView.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
                stateLab.text = "违规已取消"
                stateIcon.image = UIImage(named: "appeal_state_cancel")
            } else if type == 2 {
                contentView.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)

                stateLab.text = "申诉不通过"
                stateIcon.image = UIImage(named: "appeal_state_fail")

            } else if type == 3 {
                contentView.backgroundColor = UIColor.hexColor(hexValue: 0xE7FAF0)

                stateLab.text = "申诉通过"
                stateIcon.image = UIImage(named: "appeal_state_pass")

            } else if type == 4 {
                contentView.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)

                stateLab.text = "已过申请时效"
                stateIcon.image = UIImage(named: "appeal_state_timeout")

            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true
        self.addSubview(contentView)
        
        stateIcon = UIImageView(image: UIImage(named: "test"))
        contentView.addSubview(stateIcon)
        
        stateLab = UILabel()
        stateLab.textAlignment = .center
        stateLab.text = "违规已取消"
        stateLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        stateLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(stateLab)
        
        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        stateIcon.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(4)
            make.width.height.equalTo(20)
        }
        stateLab.snp.makeConstraints { make in
            make.centerY.equalTo(stateIcon)
            make.left.equalTo(stateIcon.snp.right).offset(10)
            make.right.equalTo(contentView).inset(10)
        }
                    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRChatAutoSendTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRChatAutoSendTableViewCell: UITableViewCell {

    var titleLab : UILabel!
    
    var mySwitch : UISwitch!
    
    var messageLab : UILabel!
    
    var actionBtn : UIButton!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
        
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "订单送达后自动发送消息"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(titleLab)
        
        let mesBgView = UIView()
        mesBgView.layer.cornerRadius = 8
        mesBgView.layer.masksToBounds = true
        mesBgView.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        contentView.addSubview(mesBgView)
        
        messageLab = UILabel()
        messageLab.numberOfLines = 0
        messageLab.text = "亲爱的顾客，您的订单已送达，感谢给我五星"
        messageLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        messageLab.font = UIFont.trBoldFont(fontSize: 14)
        contentView.addSubview(messageLab)
        
        mySwitch = UISwitch()
        contentView.addSubview(mySwitch)
        
        actionBtn = UIButton()
        actionBtn.setImage(UIImage(named: "chat_edit"), for: .normal)
        contentView.addSubview(actionBtn)
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(20)
            
        }
        
        mySwitch.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalTo(contentView).inset(18)
        }
        
        mesBgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(titleLab.snp.bottom).offset(14)
            make.bottom.equalTo(contentView).inset(20)
        }
        
        messageLab.snp.makeConstraints { make in
            make.left.right.top.equalTo(mesBgView).offset(10)
        }
        
        actionBtn.snp.makeConstraints { make in
            make.right.bottom.equalTo(mesBgView).inset(12)
            make.width.height.equalTo(25)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

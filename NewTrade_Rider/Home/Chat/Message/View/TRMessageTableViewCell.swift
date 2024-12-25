//
//  TRMessageTableViewCell.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/25.
//

import UIKit

class TRMessageTableViewCell: UITableViewCell {

    var userImgV : UIImageView!
    var nameLab : UILabel!
    var desLab : UILabel!
    var timeLab : UILabel!
    var unreadView : UILabel!
    var redDotView : UIView!
    var unreadCountLabel : UILabel!
    var sessionModel : ChatSessionModel? {
        didSet {
            guard let sessionModel = sessionModel else { return }
            userImgV.sd_setImage(with: URL.init(string: sessionModel.receivePicUrl), placeholderImage: Net_Default_Head)
            nameLab.text = sessionModel.receiveName
            desLab.text = sessionModel.lastMessage
            timeLab.text = TRTool.longTimeToShowTime(sessionModel.lastMessageTime / 1000)
            if sessionModel.unread <= 0 {
                unreadView.isHidden = true
                redDotView.isHidden = true
                unreadCountLabel.isHidden = true
            } else {
                unreadView.isHidden = true
                redDotView.isHidden = false
                unreadCountLabel.isHidden = false
                if sessionModel.unread  > 99 {
                    unreadCountLabel.text = "99+"
                } else {
                    unreadCountLabel.text = String(sessionModel.unread)
                }
            }
            
            if sessionModel.lastMessageType == MsgType.image.rawValue {
                desLab.text = "[图片]"
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        userImgV = UIImageView(image: UIImage(named: "test_head"))
        userImgV.contentMode = .scaleAspectFill
        userImgV.layer.cornerRadius = 26
        userImgV.clipsToBounds = true
        userImgV.layer.masksToBounds = true
        userImgV.clipsToBounds = true
        contentView.addSubview(userImgV)
        
        unreadView = TRFactory.labelWith(font: .trFont(12), text: "", textColor: .white, alignment: .center, lines: 1, superView: contentView)
        unreadView.backgroundColor = .hexColor(hexValue: 0xF93F3F )
        unreadView.trCorner(6)
        
        nameLab = UILabel()
        nameLab.text = "阿龙海鲜批发市场(兴东店)"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        nameLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(nameLab)
        
        desLab = UILabel()
        desLab.text = "阿龙海鲜批发市场(兴东店)"
        desLab.textColor = UIColor.hexColor(hexValue: 0x9B9C9C)
        desLab.font = UIFont.trBoldFont(fontSize: 13)
        contentView.addSubview(desLab)
        
        timeLab = UILabel()
        timeLab.text = "12:23"
        timeLab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        timeLab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        timeLab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        timeLab.font = UIFont.trBoldFont(fontSize: 13)
        contentView.addSubview(timeLab)
        
        // 创建小红点视图
        redDotView = UIView()
        redDotView.backgroundColor = .red
        redDotView.layer.cornerRadius = 10
        redDotView.layer.masksToBounds = true
        contentView.addSubview(redDotView)
       
        // 创建未读消息数量标签
        unreadCountLabel = UILabel()
        unreadCountLabel.textColor = .white
        unreadCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        unreadCountLabel.textAlignment = .center
        unreadCountLabel.text = "99+"
        unreadCountLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(unreadCountLabel)
        
        userImgV.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-15)
            make.height.width.equalTo(52)
        }
        unreadView.snp.makeConstraints { make in
            make.top.right.equalTo(userImgV)
            make.height.width.equalTo(12)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(userImgV.snp.right).offset(10)
            make.top.equalTo(userImgV).offset(6)
            make.right.equalTo(timeLab.snp.left).inset(5)
        }
        desLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.bottom.equalTo(userImgV).offset(-4)
//            make.right.equalTo(contentView).inset(16)
            make.right.equalTo(contentView).offset(-25)
        }
        
        timeLab.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(16)
            make.centerY.equalTo(nameLab)
        }
        redDotView.snp.makeConstraints { make in
            make.left.equalTo(userImgV.snp.right).offset(-5)
            make.top.equalTo(userImgV.snp.top).offset(-5)
            make.width.height.equalTo(20)
        }
        
        unreadCountLabel.snp.makeConstraints { make in
            make.left.equalTo(userImgV.snp.right).offset(-5)
            make.top.equalTo(userImgV.snp.top).offset(-5)
            make.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

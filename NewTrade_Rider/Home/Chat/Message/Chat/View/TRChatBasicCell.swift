//
//  TRChatLeftBasicCell.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/26.
//

import UIKit

class TRChatBasicCell: UITableViewCell {
    var userNameLab : UILabel!
    
    var roleLab : UILabel!
    
    var userImgV : UIImageView!
    
    var contentBgView : UIView!
   
    var msgModel : ChatMsgModel? {
        didSet {
            guard let msgModel = msgModel else { return }
            
            if "\(msgModel.sender)".elementsEqual(TRDataManage.shared.userModel.scUserId) {
                userImgV.sd_setImage(with: URL.init(string: TRDataManage.shared.userModel.scPictureUrl), placeholderImage: Net_Default_Img, context: nil)

                userNameLab.isHidden = true
                roleLab.isHidden = true
                contentBgView.backgroundColor = .lightThemeColor()
                userImgV.snp.remakeConstraints { make in
                    make.right.equalTo(contentView).inset(16)
                    make.top.equalTo(contentView).offset(15)
                    make.size.equalTo(CGSize(width: 44, height: 44))
                }
                
                userNameLab.snp.remakeConstraints { make in
                    make.centerY.equalTo(userImgV)
                    make.right.equalTo(userImgV.snp.left).offset(-10)
                }
                
                contentBgView.snp.remakeConstraints { make in
                    make.bottom.equalTo(contentView).inset(5)
                    make.top.equalTo(userImgV)
                    make.left.greaterThanOrEqualTo(contentView.snp.left).offset(33)
                    make.right.equalTo(userImgV.snp.left).offset(-10)
                    
                }
            } else{
                if msgModel.sendInfo != nil{
                    userImgV.sd_setImage(with: URL.init(string: msgModel.sendInfo!.pictureUrl), placeholderImage: Net_Default_Img, context: nil)
                    userNameLab.text = msgModel.sendInfo!.nickName
                    
                    if msgModel.sendInfo!.roleName.elementsEqual("店铺") {
                        roleLab.text = "@商家"
                        roleLab.textColor = .hexColor(hexValue: 0x23B1F5)
                    } else if msgModel.sendInfo!.roleName.elementsEqual("用户") {
                        roleLab.text = "@用户"
                        roleLab.textColor = .hexColor(hexValue: 0xFA651F)
                    } else if msgModel.sendInfo!.roleName.elementsEqual("骑手") {
                        roleLab.text = "@骑手"
                        roleLab.textColor = .hexColor(hexValue: 0x13D066)
                    }
                }

                userNameLab.isHidden = false
                roleLab.isHidden = false
                contentBgView.backgroundColor = .white
                userImgV.snp.remakeConstraints { make in
                    make.left.equalTo(contentView).offset(16)
                    make.top.equalTo(contentView).offset(15)
                    make.size.equalTo(CGSize(width: 44, height: 44))
                }
                
                userNameLab.snp.remakeConstraints { make in
                    make.top.equalTo(userImgV)
                    make.left.equalTo(userImgV.snp.right).offset(10)
                    make.width.lessThanOrEqualTo(Screen_Width - 80)
                }
                
                contentBgView.snp.remakeConstraints { make in
                    make.bottom.equalTo(contentView).inset(5)
                    make.left.equalTo(userImgV.snp.right).offset(10)
                    make.right.lessThanOrEqualTo(contentView).inset(33)
                    make.top.equalTo(userNameLab.snp.bottom).offset(5)
                }
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
        contentBgView = UIView()
        contentBgView.backgroundColor = UIColor.themeColor()
        contentBgView.layer.cornerRadius = 8
        contentView.addSubview(contentBgView)
        
        userImgV = UIImageView(image: UIImage(named: "test_head"))
        userImgV.layer.cornerRadius = 22
        userImgV.layer.masksToBounds = true
        contentView.addSubview(userImgV)
        
        userNameLab = UILabel()
        userNameLab.text = "username"
        userNameLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        userNameLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(userNameLab)
        
        roleLab = UILabel()
        roleLab.text = "username"
        roleLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        roleLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(roleLab)
        
        userImgV.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        userNameLab.snp.makeConstraints { make in
            make.centerY.equalTo(userImgV)
            make.left.equalTo(userImgV.snp.right).offset(10)
        }
        roleLab.snp.makeConstraints { make in
            make.centerY.equalTo(userNameLab)
            make.left.equalTo(userNameLab.snp.right).offset(1)
        }
        contentBgView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
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

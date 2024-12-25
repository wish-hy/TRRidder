//
//  TRChatTextCell.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/26.
//

import UIKit

class TRChatTextCell: TRChatBasicCell {
    override var msgModel : ChatMsgModel? {
        didSet {
            
            guard let msgModel  = msgModel  else { return }
            chatTextLab.text = msgModel.msgContent
            if "\(msgModel.sender)".elementsEqual(TRDataManage.shared.userModel.scUserId) {
                chatTextLab.textColor = .white
            } else {
                chatTextLab.textColor = UIColor.hexColor(hexValue: 0x333333)
            }
            

        }
        
    }
    var chatTextLab : UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        configTextView()
    }
    
    private func configTextView(){
        chatTextLab = UILabel()
        chatTextLab.text = "昨日收入(元)"
        chatTextLab.numberOfLines = 0
        chatTextLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        chatTextLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(chatTextLab)
        chatTextLab.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentBgView).inset(10)
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

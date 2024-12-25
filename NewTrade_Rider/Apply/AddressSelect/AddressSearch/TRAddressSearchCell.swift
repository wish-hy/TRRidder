//
//  TRAddressSearchCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/22.
//

import UIKit

class TRAddressSearchCell: UITableViewCell {
    
    var itemLab : UILabel!
    var desLab : UILabel!
    var line : UIView!
    var type : Int = 0 {
        didSet {
            if type == 0 {
                desLab.isHidden = false
                itemLab.snp.remakeConstraints { make in
                    make.left.equalTo(contentView).offset(16)
                    make.top.equalTo(contentView).offset(16)
                }
                
                desLab.snp.remakeConstraints { make in
                    make.bottom.equalTo(contentView).inset(15)
                    make.right.equalTo(contentView).inset(16)
                    make.left.equalTo(itemLab)
                    make.top.equalTo(itemLab.snp.bottom).offset(2)
                }

            } else {
                desLab.isHidden = true
                itemLab.snp.remakeConstraints { make in
                    make.left.equalTo(contentView).offset(16)
                    make.top.equalTo(contentView).offset(16)
                    make.bottom.equalTo(contentView).inset(16)
                }
                
                desLab.snp.remakeConstraints { make in
//                    make.bottom.equalTo(contentView).inset(15)
//                    make.right.equalTo(contentView).inset(16)
//                    make.left.equalTo(itemLab)
//                    make.top.equalTo(itemLab.snp.bottom).offset(2)
                }

            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        itemLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 18), text: "东门街道", textColor: .txtColor(), superView: contentView)
        
        desLab = TRFactory.labelWith(font: .trFont(fontSize: 13), text: "东门街道", textColor: .hexColor(hexValue: 0x9B9C9C), superView: contentView)
        
        line = UIView()
        line.backgroundColor = .lineColor()
        contentView.addSubview(line)
        
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(16)
        }
        
        desLab.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(15)
            make.right.equalTo(contentView).inset(16)
            make.left.equalTo(itemLab)
            make.top.equalTo(itemLab.snp.bottom).offset(2)
        }

        
        desLab.attributedText = TRTool.richText(str1: " 广东省深圳市罗湖区", font1: .trFont(fontSize: 13), color1: .hexColor(hexValue: 0x9B9C9C), str2: "东门街道", font2: .trFont(fontSize: 13), color2: .themeColor())
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView).inset(0)
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

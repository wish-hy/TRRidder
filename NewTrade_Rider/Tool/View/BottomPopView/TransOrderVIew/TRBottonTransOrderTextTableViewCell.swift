//
//  TRBottonTransOrderTextTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit

class TRBottonTransOrderTextTableViewCell: UITableViewCell {

    var limitView : TRLimitTextView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        
//        let pointLab = UILabel()
//        pointLab.text = "*"
//        pointLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
//        pointLab.font = UIFont.trFont(fontSize: 16)
//        contentView.addSubview(pointLab)
        
        let nameLab = UILabel()
        nameLab.text = "备注"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(nameLab)

        limitView = TRLimitTextView(frame: .zero)
        contentView.addSubview(limitView)
        
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
//        pointLab.snp.makeConstraints { make in
//            make.top.equalTo(contentView).offset(15)
//            make.left.equalTo(contentView).offset(16)
//        }
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(16)
        }
        limitView.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp.right).offset(5)
            make.top.equalTo(nameLab)
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(85)
        }

        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
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

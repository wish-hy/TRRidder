//
//  TRMineDetailAddressCell.swift
//  NewTrade_Seller
//
//  Created by xph on 2024/1/11.
//

import UIKit

class TRMineDetailAddressCell: UITableViewCell {
    var titleLab : UILabel!
    var valeLab : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "头像"
        titleLab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleLab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(titleLab)
        
        valeLab = UILabel(frame: .zero)
        valeLab.font = UIFont.trFont(fontSize: 14)
        valeLab.text = "刘华健"
        valeLab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        valeLab.numberOfLines = 0
        valeLab.textAlignment = .right
        valeLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        contentView.addSubview(valeLab)
        
        let arrow = UIImageView(image: UIImage(named: "advance_gray"))
        contentView.addSubview(arrow)
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.width.equalTo(70)
        }
        
        valeLab.snp.makeConstraints { make in
           
            make.right.equalTo(contentView).offset(-32)
            make.left.equalTo(titleLab.snp.right).offset(40)
            make.top.equalTo(titleLab)
            make.bottom.equalTo(contentView).inset(16)
        }
        arrow.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-16)
            make.width.height.equalTo(18)
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

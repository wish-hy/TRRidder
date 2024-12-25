//
//  TRAddressLetterCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/21.
//

import UIKit

class TRAddressLetterCell: UITableViewCell {
    var letterLab : UILabel!
    var lab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        letterLab = TRFactory.labelWith(font: .trMediumFont(fontSize: 13), text: "A", textColor: .hexColor(hexValue: 0x9B9C9C), superView: contentView)
        contentView.addSubview(letterLab)
        
        lab = UILabel()
        lab.text = "深圳"
        lab.textColor = .txtColor()
        lab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(lab)
        
        letterLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        lab.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(14)
            make.left.equalTo(letterLab.snp.right).offset(15)
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

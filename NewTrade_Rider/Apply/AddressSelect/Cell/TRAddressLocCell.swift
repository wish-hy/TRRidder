//
//  TRAddressLocCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/21.
//

import UIKit

class TRAddressLocCell: UITableViewCell {
    var locImgV : UIImageView!
    var lab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        locImgV = UIImageView(image: UIImage(named: "location"))
        contentView.addSubview(locImgV)
        
        lab = UILabel()
        lab.text = "深圳"
        lab.textColor = .txtColor()
        lab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(lab)
        
        locImgV.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(12)
            make.height.width.equalTo(18)
        }
        lab.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(14)
            make.left.equalTo(locImgV.snp.right).offset(10)
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

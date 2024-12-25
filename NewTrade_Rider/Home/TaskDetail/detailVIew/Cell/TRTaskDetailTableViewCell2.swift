//
//  TRTaskDetailTableViewCell2.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit

class TRTaskDetailTableViewCell2: UITableViewCell {

    var nameLab : UILabel!
    var numLab : UILabel!
    var priceLab : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        nameLab = UILabel()
        nameLab.text = "商品1"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(nameLab)
        
        numLab = UILabel()
        numLab.text = "x1"
        numLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        numLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(numLab)
        
        let unitLab = UILabel()
        unitLab.text = "¥"
        unitLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        unitLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(unitLab)
        
        priceLab = UILabel()
        priceLab.text = "99999.99"
        priceLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        priceLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(priceLab)
        
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        numLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.centerX.equalTo(contentView).offset(50)
        }
        priceLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(16)
        }
        unitLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(priceLab.snp.left).offset(-2)
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

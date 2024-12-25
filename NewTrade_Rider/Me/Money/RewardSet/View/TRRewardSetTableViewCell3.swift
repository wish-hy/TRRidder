//
//  TRRewardSetTableViewCell3.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRRewardSetTableViewCell3: UITableViewCell {
    
    var numLab : UILabel!
    var priceTF : UITextField!
    var unitLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        numLab = UILabel()
        numLab.text = "1"
        numLab.textColor = .white
        numLab.layer.cornerRadius = 13
        numLab.layer.masksToBounds = true

        numLab.textAlignment = .center
        numLab.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        numLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(numLab)
        
  
        
        let bgView = UIView()
        bgView.layer.cornerRadius = 8
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        contentView.addSubview(bgView)

        priceTF = UITextField()
        priceTF.placeholder = "请输入打赏金额"

        priceTF.font = UIFont.trBoldFont(fontSize: 15)
        contentView.addSubview(priceTF)
        
        unitLab = UILabel()
        unitLab.text = "元"
        unitLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        unitLab.font = UIFont.trBoldFont(fontSize: 14)
        contentView.addSubview(unitLab)
        
        numLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
            make.width.height.equalTo(26)
        }
        
        bgView.snp.makeConstraints { make in
            make.centerY.equalTo(numLab)
            make.height.equalTo(44)
            make.left.equalTo(numLab.snp.right).offset(9)
            make.right.equalTo(contentView).inset(16)
        }
        priceTF.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.height.equalTo(bgView)
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(unitLab.snp.left).offset(-8)
        }
        unitLab.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.right.equalTo(bgView).offset(-10)
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

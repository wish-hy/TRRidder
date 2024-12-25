//
//  TRBottomTransOrderMoneyCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit

class TRBottomTransOrderMoneyCell: UITableViewCell {

    var moneyTF : UITextField!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        
        let pointLab = UILabel()
        
        
        let nameLab = UILabel()
        nameLab.text = "打赏金(元)"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(nameLab)

        
        moneyTF = UITextField()
        moneyTF.keyboardType = .numberPad
        moneyTF.text = "1"
        moneyTF.textAlignment = .right
        moneyTF.textColor = UIColor.hexColor(hexValue: 0x97989A)
        moneyTF.font = UIFont.trBoldFont(fontSize: 16)
        moneyTF.clearButtonMode = .whileEditing
        contentView.addSubview(moneyTF)
        
        let arrowImgV = UIImageView()
        arrowImgV.image = UIImage(named: "advance_gray")
        contentView.addSubview(arrowImgV)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
       
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        
        moneyTF.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-32)
            make.width.equalTo(200)
            make.height.equalTo(35)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
        arrowImgV.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.right.equalTo(contentView).offset(-16)
            make.centerY.equalTo(contentView)
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

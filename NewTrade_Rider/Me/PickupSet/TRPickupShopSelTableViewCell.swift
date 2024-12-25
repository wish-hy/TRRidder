//
//  TRPickupShopSelTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRPickupShopSelTableViewCell: UITableViewCell {
    var titleLab : UILabel!
    var valeLab : UILabel!
    var valeSwitch : UISwitch!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        let tipLab = UILabel()
        tipLab.text = "签"
        tipLab.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        tipLab.layer.cornerRadius = 3
        tipLab.layer.masksToBounds = true
        tipLab.textColor = .white
        tipLab.textAlignment = .center
        tipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(tipLab)
        
        titleLab = UILabel()
        titleLab.text = "常驻送货区域"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(titleLab)
        
        valeLab = UILabel()
        valeLab.text = "兴东一路二单元十二号"
        valeLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        valeLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(valeLab)
        
        valeSwitch = UISwitch()
 
        contentView.addSubview(valeSwitch)
        
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        tipLab.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(tipLab)
            make.left.equalTo(tipLab.snp.right).offset(7)
        }
        
        valeLab.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-32)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.left.equalTo(titleLab)
        }
        valeSwitch.snp.makeConstraints { make in
            
            make.right.equalTo(contentView).offset(-32)
           
            make.centerY.equalTo(contentView)
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

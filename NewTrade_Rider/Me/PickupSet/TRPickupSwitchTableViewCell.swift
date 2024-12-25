//
//  TRPickupSwitchTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRPickupSwitchTableViewCell: UITableViewCell {
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
        titleLab = UILabel()
        titleLab.text = "常驻送货区域"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        titleLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(titleLab)
        
        valeSwitch = UISwitch()
 
        contentView.addSubview(valeSwitch)
        
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)

        valeLab = UILabel()
        valeLab.text = "开启后，在派单倒计时结束后为你自动接单"
        valeLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        valeLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(valeLab)
        
        
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(17)
            make.left.equalTo(contentView).offset(16)
        }
        
        valeLab.snp.makeConstraints { make in
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

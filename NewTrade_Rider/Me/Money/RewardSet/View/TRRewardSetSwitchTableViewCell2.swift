//
//  TRRewardSetTableViewCell2.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRRewardSetSwitchTableViewCell2: UITableViewCell {
    var titleLab : UILabel!
    
    var mySwitch : UISwitch!
    
    var line : UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    

    
    
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "开启打赏功能"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        mySwitch = UISwitch()
        contentView.addSubview(mySwitch)
        
        line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        mySwitch.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalTo(contentView).inset(16)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

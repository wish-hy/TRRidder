//
//  TRHomeStateSelTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/6.
//

import UIKit

class TRHomeStateSelTableViewCell: UITableViewCell {

    var stateImgV : UIImageView!
    var stateLab : UILabel!
    var arrowImgV : UIImageView!
    var line : UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        stateImgV = UIImageView()
        stateImgV.image = UIImage(named: "home_state_kg")
        contentView.addSubview(stateImgV)
        
        stateLab = UILabel()
        stateLab.text = "开工"
        stateLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        stateLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(stateLab)
        
        arrowImgV = UIImageView()
        arrowImgV.image = UIImage(named: "home_state_sel")
        contentView.addSubview(arrowImgV)
        
        line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        stateImgV.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(22)
            make.left.equalTo(contentView).offset(10)
        }
        stateLab.snp.makeConstraints { make in
            make.left.equalTo(stateImgV.snp.right).offset(10)
            make.centerY.equalTo(contentView)
        }
        arrowImgV.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(22)
            make.right.equalTo(contentView).inset(10)
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

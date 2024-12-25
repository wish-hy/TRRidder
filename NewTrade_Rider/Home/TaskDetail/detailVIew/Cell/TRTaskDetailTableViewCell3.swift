//
//  TRTaskDetailTableViewCell3.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit

class TRTaskDetailTableViewCell3: UITableViewCell {
    
    var type = 0 {
        didSet{
            if type == 1 {
                detailLab.textColor = UIColor.hexColor(hexValue: 0xFF652F)
                detailLab.layer.borderColor = UIColor.hexColor(hexValue: 0xFF652F).cgColor
                detailLab.layer.borderWidth = 1
                detailLab.layer.cornerRadius = 3
                detailLab.layer.masksToBounds = true
            } else if type == 2 {
                detailLab.textColor = UIColor.hexColor(hexValue: 0x23B1F5)
                detailLab.layer.borderColor = UIColor.hexColor(hexValue: 0x23B1F5).cgColor
                detailLab.layer.borderWidth = 1
                detailLab.layer.cornerRadius = 3
                detailLab.layer.masksToBounds = true
            } else {
                detailLab.textColor = .txtColor()
                
                detailLab.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    var nameLab : UILabel!
    var detailLab : UILabel!
    
    var yuyueLab : UILabel!//订单详情有用
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        nameLab = UILabel()
        nameLab.text = "商品1"
        nameLab.textColor = .txtColor()
        nameLab.font = .trFont(16)
        contentView.addSubview(nameLab)
        
        detailLab = UILabel()
        detailLab.text = "x1"
        detailLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        detailLab.font = .trMediumFont(16)
        contentView.addSubview(detailLab)
       
        yuyueLab = UILabel()
        yuyueLab.text = " 预约 "
        yuyueLab.textColor = UIColor.hexColor(hexValue: 0x23B1F5)
        yuyueLab.font = UIFont.trFont(fontSize: 15)
        yuyueLab.layer.borderColor = UIColor.hexColor(hexValue: 0x23B1F5).cgColor
        yuyueLab.layer.borderWidth = 1
        yuyueLab.layer.cornerRadius = 3
        yuyueLab.isHidden = true
        yuyueLab.layer.masksToBounds = true
        contentView.addSubview(yuyueLab)
        
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        detailLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
//            make.right.equalTo(contentView).inset(16)
            make.left.equalTo(contentView).inset(110)
            make.height.equalTo(24)
        }

        yuyueLab.snp.makeConstraints { make in
            make.centerY.equalTo(nameLab)
            make.left.equalTo(nameLab.snp.right).offset(10)
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

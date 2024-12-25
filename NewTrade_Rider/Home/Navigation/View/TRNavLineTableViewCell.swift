//
//  TRNavBeginTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit

class TRNavLineTableViewCell: UITableViewCell {

    var tipLab : UILabel!
    
    var distanceLab : UILabel!
    var doneLab : UILabel!

    var nameLab : UILabel!
    var locLab : UILabel!
    
    var numLab : UILabel!
    
    var locBtn : UIButton!
    
    var type : Int = 1 {
        didSet{
            if type == 0 {
                tipLab.text = "取"
                tipLab.backgroundColor = UIColor.hexColor(hexValue: 0xFF652F)
            } else {
                tipLab.text = "送"
                tipLab.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        
        let line1 = UIView()
        line1.backgroundColor = UIColor.hexColor(hexValue: 0xD2D5D7)
        contentView.addSubview(line1)
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.hexColor(hexValue: 0xD2D5D7)
        contentView.addSubview(line2)
        
        distanceLab = UILabel()
        distanceLab.text = "3.0\nkm"
        distanceLab.numberOfLines = 0
        distanceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        distanceLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(distanceLab)
        
        doneLab = UILabel()
        contentView.addSubview(doneLab)
        
        numLab = UILabel()
        numLab.text = "#02"
        numLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        numLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(numLab)
        
        tipLab = UILabel()
        tipLab.text = "取"
        tipLab.layer.cornerRadius = 3
        tipLab.layer.masksToBounds = true
        tipLab.textAlignment = .center
        tipLab.numberOfLines = 0
        tipLab.textColor = .white
        tipLab.backgroundColor = UIColor.hexColor(hexValue: 0xFF652F)
        tipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(tipLab)
        
        nameLab = UILabel()
        nameLab.text = "农批市场"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(nameLab)
        
        locLab = UILabel()
        locLab.text = "宝安区新安街道新安二路十单元"
        locLab.numberOfLines = 0
        locLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        locLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(locLab)
        
        locBtn = UIButton()
        locBtn.setImage(UIImage(named: "navigation_green"), for: .normal)
        locBtn.backgroundColor = UIColor.hexColor(hexValue: 0xDFFDEC)
        locBtn.layer.cornerRadius = 17
        locBtn.layer.masksToBounds = true
        contentView.addSubview(locBtn)
        
        line1.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(33)
            make.width.equalTo(1)
            make.top.equalTo(distanceLab.snp.bottom).offset(2)
            make.height.equalTo(26)
        }
        tipLab.snp.makeConstraints { make in
            make.height.width.equalTo(18)
            make.centerX.equalTo(line1)
            make.top.equalTo(line1.snp.bottom).offset(2)
        }
        doneLab.snp.makeConstraints { make in
            make.centerY.equalTo(distanceLab)
            make.left.equalTo(distanceLab.snp.right).offset(10)
        }
        numLab.snp.makeConstraints { make in
            make.centerY.equalTo(doneLab)
            make.right.equalTo(contentView).offset(-21)
        }
        distanceLab.snp.makeConstraints { make in
            make.centerX.equalTo(line1)
            make.top.equalTo(contentView)
            
        }
        line2.snp.makeConstraints { make in
            make.left.width.height.equalTo(line1)
            make.top.equalTo(tipLab.snp.bottom).offset(2)
//            make.bottom.equalTo(contentView)
            
        }
        
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(doneLab)
            make.top.equalTo(tipLab).offset(-8)
        }
        locLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom).offset(5)
            make.right.equalTo(contentView).offset(90)
            make.bottom.equalTo(contentView).inset(13)
        }
        locBtn.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.centerY.equalTo(tipLab)
            make.right.equalTo(contentView).inset(16)
        }
        let font = UIFont.trFont(fontSize: 13)
        doneLab.attributedText = TRTool.richText3(str1: "预计", font1: font, color1: UIColor.hexColor(hexValue: 0x97989A), str2: "10:00", font2: font, color2: UIColor.hexColor(hexValue: 0xFF652F),str3 : "送达", font3: font, color3: UIColor.hexColor(hexValue: 0x97989A))
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

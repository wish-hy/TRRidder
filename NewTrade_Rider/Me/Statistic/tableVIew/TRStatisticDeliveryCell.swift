//
//  TRStatisticDeliveryCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStatisticDeliveryCell: UITableViewCell {

    var tipView : TRStatisticInfoTipView!
    
    var numView : TRStatisticInfoView!

    var timelyLab : UILabel!
    var lateLab : UILabel!
    var preBookLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
        configValue()
    }
    

    
    
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 13
        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
        
        tipView = TRStatisticInfoTipView(frame: .zero)
        tipView.tipView.backgroundColor = UIColor.hexColor(hexValue: 0x23B1F5)
        tipView.titleLab.text = "配送时长"
        bgView.addSubview(tipView)
        
        numView = TRStatisticInfoView(frame: .zero)
        numView.titleLab.text = "配送单量"
        numView.valueLab.text = "--单"
        numView.subTheme3()
        bgView.addSubview(numView)
        
        timelyLab = UILabel()
        timelyLab.numberOfLines = 0
        contentView.addSubview(timelyLab)
        
        lateLab = UILabel()
        lateLab.numberOfLines = 0
        contentView.addSubview(lateLab)
        
        preBookLab = UILabel()
        preBookLab.numberOfLines = 0
        contentView.addSubview(preBookLab)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(10)
        }
        tipView.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(5)
            make.top.equalTo(bgView).offset(18)
            make.height.equalTo(25)
        }
        numView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(tipView.snp.bottom).offset(15)
            make.width.equalTo(120)
            make.height.equalTo(70)
            
        }
        
        timelyLab.snp.makeConstraints { make in
            make.top.equalTo(numView.snp.bottom).offset(10)
            make.left.equalTo(bgView).offset(30)
            make.width.equalTo(80)
            make.height.equalTo(70)
        }
        
        lateLab.snp.makeConstraints { make in
            make.top.equalTo(timelyLab)
            make.centerX.equalTo(bgView)
            make.width.height.equalTo(timelyLab)
        }
        
        preBookLab.snp.makeConstraints { make in
            make.top.equalTo(timelyLab)
            make.right.equalTo(bgView).inset(30)
            make.width.height.equalTo(timelyLab)
        }
      
    }
    
    func configValue(){
        let timelyStr =  TRTool.richText(str1: "即时单\n", font1: UIFont.trFont(fontSize: 13), color1: UIColor.hexColor(hexValue: 0x686A6A), str2: "0", font2: UIFont.trBoldFont(fontSize: 20), color2: UIColor.hexColor(hexValue: 0x141414))
        
        let lateStr =  TRTool.richText(str1: "迟到单\n", font1: UIFont.trFont(fontSize: 13), color1: UIColor.hexColor(hexValue: 0x686A6A), str2: "0", font2: UIFont.trBoldFont(fontSize: 20), color2: UIColor.hexColor(hexValue: 0x141414))
        
        let preBookStr =  TRTool.richText(str1: "预约单\n", font1: UIFont.trFont(fontSize: 13), color1: UIColor.hexColor(hexValue: 0x686A6A), str2: "0", font2: UIFont.trBoldFont(fontSize: 20), color2: UIColor.hexColor(hexValue: 0x141414))
        
        timelyLab.attributedText = timelyStr
        lateLab.attributedText = lateStr
        preBookLab.attributedText = preBookStr
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

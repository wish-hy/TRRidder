//
//  TRMessageNotifyViewCell.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/26.
//

import UIKit

class TRMessageNotifyViewCell: UITableViewCell {

    var notiIconV : UIImageView!
    var typeLab : UILabel!
    
    var titleLab : UILabel!
    var timeLab : UILabel!
    
    var desLab : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = UIColor.bgColor()
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        notiIconV = UIImageView(image: UIImage(named: "notification"))
        bgView.addSubview(notiIconV)
        
        typeLab = UILabel()
        typeLab.text = "系统消息"
        typeLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        typeLab.font = UIFont.trFont(fontSize: 14)
        bgView.addSubview(typeLab)
        
        titleLab = UILabel()
        titleLab.text = "做发动机，不要作飞轮"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        titleLab.font = UIFont.trMediumFont(fontSize: 15)
        bgView.addSubview(titleLab)
        
        timeLab = UILabel()
        timeLab.text = "韩剧乐视"
        timeLab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        timeLab.textAlignment = .right
        timeLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(timeLab)
        
        desLab = UILabel()
        desLab.numberOfLines = 0
        desLab.text = "才结张育她按门需当你话下术称维史选参面备须存整律年才必中存约光将因观改支道着按每研专提划整商..."
        desLab.textColor = UIColor.hexColor(hexValue: 0x67686A )
        desLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(desLab)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView)
        }
        
        notiIconV.snp.makeConstraints { make in
            make.height.width.equalTo(26)
            make.left.equalTo(bgView).offset(10)
            make.top.equalTo(bgView).offset(15)
        }
        typeLab.snp.makeConstraints { make in
            make.centerY.equalTo(notiIconV)
            make.left.equalTo(notiIconV.snp.right).offset(5)
        }
        timeLab.snp.makeConstraints { make in
            make.centerY.equalTo(notiIconV)
            make.right.equalTo(bgView).offset(-10)
            make.width.equalTo(120)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(notiIconV.snp.bottom).offset(10)
            make.left.equalTo(notiIconV)
        }
//
        desLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.right.equalTo(timeLab.snp.right).offset(-5)
            make.top.equalTo(titleLab.snp.bottom).offset(7)
            make.bottom.equalTo(bgView).inset(20)
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

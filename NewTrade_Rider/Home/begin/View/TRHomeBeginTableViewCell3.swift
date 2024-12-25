//
//  TRHomeBeginTableViewCell3.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit

class TRHomeBeginTableViewCell3: UITableViewCell {

    
     var iconImgV : UIImageView!
     var titleLab : UILabel!
     var detailLab : UILabel!
     var timeLab : UILabel!
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.selectionStyle = .none
         contentView.backgroundColor = .bgColor()
         setupView()
     }
     
     
     
    
     private func setupView(){
         let bgView = UIView()
         bgView.backgroundColor = .white;
         
         contentView.addSubview(bgView)
         let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 30, height: 96), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 13, height: 13))
         let maskLayer = CAShapeLayer()
         maskLayer.path = maskPath.cgPath
         bgView.layer.mask = maskLayer;
         contentView.addSubview(bgView)
        
         iconImgV = UIImageView()
         iconImgV.image = UIImage(named: "notice")
         contentView.addSubview(iconImgV)
         
         titleLab = UILabel()
         titleLab.text = "注意事项"
         titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
         titleLab.font = UIFont.trBoldFont(fontSize: 17)
         contentView.addSubview(titleLab)
         
         detailLab = UILabel()
         detailLab.text = "不要事情找你，而要你找事情标题内容"
         detailLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
         detailLab.font = UIFont.trFont(fontSize: 13)
         contentView.addSubview(detailLab)
         
         timeLab = UILabel()
         timeLab.text = "12:00"
         timeLab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
         timeLab.font = UIFont.trFont(fontSize: 12)
         contentView.addSubview(timeLab)
         
         bgView.snp.makeConstraints { make in
             make.left.right.top.bottom.equalTo(contentView)
         }
         
         iconImgV.snp.makeConstraints { make in
             make.left.top.bottom.equalTo(contentView).inset(15)
             make.width.equalTo(62)
             
         }
         titleLab.snp.makeConstraints { make in
             make.left.equalTo(iconImgV.snp.right).offset(12)
             make.top.equalTo(iconImgV)
         }
         
         detailLab.snp.makeConstraints { make in
             make.left.equalTo(titleLab)
             make.top.equalTo(titleLab.snp.bottom).offset(6)
             make.right.equalTo(contentView).inset(60)
         }
         
         timeLab.snp.makeConstraints { make in
             make.top.equalTo(iconImgV)
             make.right.equalTo(contentView).inset(15)
         }
         self.layoutIfNeeded()
         maskLayer.frame = bgView.bounds
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

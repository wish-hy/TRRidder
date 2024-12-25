//
//  TRCommentTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit
import RxCocoa
import RxSwift
class TRCommentTableViewCell: UITableViewCell {
    
    var rateLab : UILabel!
    var priceLab : UILabel!
    
    var quLab : UILabel!
    var startNameLab : UILabel!
    
    var songLab : UILabel!
    var endNameLab : UILabel!
    
    var orderLab : UILabel!
    var timeLab : UILabel!

    var bgView : UIView!
    
    var bag = DisposeBag()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
        setAction()
    }
    private func setAction(){
      
    }
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 13
        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
    

        let rateTipLab = UILabel()
        rateTipLab.text = "满意度"
        rateTipLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        rateTipLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(rateTipLab)
        
        rateLab = UILabel()
        rateLab.text = "90%"
        rateLab.textColor = UIColor.hexColor(hexValue: 0xFA651F)
        rateLab.font = UIFont.trBoldFont(fontSize: 16)
        bgView.addSubview(rateLab)
        
 
        
        priceLab = UILabel()
        priceLab.text = "#01"
        priceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        priceLab.font = UIFont.trBoldFont(fontSize: 23)
        bgView.addSubview(priceLab)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        bgView.addSubview(line)
    
        
        quLab = UILabel()
        quLab.text = "取"
        quLab.textAlignment = .center
        quLab.numberOfLines = 0
        quLab.layer.cornerRadius = 3
        quLab.layer.masksToBounds = true
        quLab.textColor = .white
        quLab.backgroundColor = UIColor.hexColor(hexValue: 0xFF652F)
        quLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(quLab)
        
        let contactLab = UILabel()
        contactLab.text = "联系"
        contactLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        contactLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(contactLab)
        
        startNameLab = UILabel()
        startNameLab.text = "农批市场"
        startNameLab.numberOfLines = 0
        startNameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        startNameLab.font = UIFont.trBoldFont(fontSize: 17)
        bgView.addSubview(startNameLab)
        

        
        songLab = UILabel()
        songLab.text = "送"
        songLab.numberOfLines = 0
        songLab.layer.cornerRadius = 3
        songLab.layer.masksToBounds = true
        songLab.textAlignment = .center
        songLab.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        songLab.textColor = .white
        songLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(songLab)
        
        endNameLab = UILabel()
        endNameLab.text = "南山区粤海街道东方科技大厦 2498"
        endNameLab.numberOfLines = 0
        endNameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        endNameLab.font = UIFont.trBoldFont(fontSize: 17)
        bgView.addSubview(endNameLab)
 
        let line2 = UIView()
        line2.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        bgView.addSubview(line2)
        
        orderLab = UILabel()
        orderLab.text = "订单编号：238430294"
        orderLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        orderLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(orderLab)
        
        timeLab = UILabel()
        timeLab.text = "今天10:00"
        timeLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        timeLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(timeLab)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.right.equalTo(contentView).inset(15)
            make.height.equalTo(195)
            make.bottom.equalTo(contentView)
        }

        rateLab.snp.makeConstraints { make in
            make.left.equalTo(rateTipLab.snp.right).offset(2)
            make.centerY.equalTo(rateTipLab)
        }
        rateTipLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(14)
            make.top.equalTo(bgView).offset(17)
       
        }
        
        
        priceLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(15)
            make.centerY.equalTo(rateLab)
        }
        
        quLab.snp.makeConstraints { make in
            make.left.equalTo(line)
            make.height.width.equalTo(18)
            make.top.equalTo(line.snp.bottom).offset(17)
        }
        //横线
        line.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(rateLab.snp.bottom).offset(18)
            make.height.equalTo(1)
        }
       
 
        startNameLab.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.right.equalTo(bgView).inset(18)
            make.left.equalTo(bgView).offset(50)
        }
  
        
        songLab.snp.makeConstraints { make in
            make.left.equalTo(quLab)
            make.height.width.equalTo(18)
            make.top.equalTo(quLab.snp.bottom).offset(23)
        }
        endNameLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.right.equalTo(bgView).inset(18)
            make.top.equalTo(songLab)
        }
     
        line2.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(songLab.snp.bottom).offset(18)
            make.height.equalTo(1)
        }

        orderLab.snp.makeConstraints { make in
            make.left.equalTo(quLab)
            make.top.equalTo(line2).offset(15)
        }
 
        timeLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).offset(-15)
            make.centerY.equalTo(orderLab)
        }
        
 

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

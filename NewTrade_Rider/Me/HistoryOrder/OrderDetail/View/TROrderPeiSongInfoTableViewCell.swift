//
//  TROrderPeiSongInfoTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TROrderPeiSongInfoTableViewCell: UITableViewCell {
    

    var priceLab : UILabel!
    
    var quLab : UILabel!
    var startNameLab : UILabel!
    
    var songLab : UILabel!
    var endNameLab : UILabel!
    
    var startLocLab : UILabel!
    var userInfo : UILabel!

    var bgView : UIView!
    
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
//        bgView.layer.cornerRadius = 13
//        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
        
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
        
        startLocLab = UILabel()
        startLocLab.text = "宝安区新安街道新安二路十单元"
        startLocLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        startLocLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(startLocLab)
        
        userInfo = UILabel()
        userInfo.text = "刘**(女士)"
        userInfo.textColor = UIColor.hexColor(hexValue: 0x97989A)
        userInfo.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(userInfo)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(0)
            make.left.right.equalTo(contentView).inset(0)
            make.bottom.equalTo(contentView)
        }
   

        
        
        priceLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(16)
            make.centerY.equalTo(quLab)
        }
        
        quLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(20)
            make.height.width.equalTo(18)
            make.top.equalTo(bgView).offset(20)
        }
        //竖线
        line.snp.makeConstraints { make in
            make.centerX.equalTo(quLab)
            make.top.equalTo(quLab.snp.bottom).offset(5)
            make.bottom.equalTo(songLab.snp.top).inset(5)

            make.width.equalTo(1)
        }
       
 
        startNameLab.snp.makeConstraints { make in
            make.top.equalTo(quLab)
            make.right.equalTo(bgView).inset(35)
            make.left.equalTo(bgView).offset(50)
        }
  
        startLocLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.top.equalTo(startNameLab.snp.bottom).offset(5)
        }
        
        songLab.snp.makeConstraints { make in
            make.left.equalTo(quLab)
            make.height.width.equalTo(18)
            make.top.equalTo(quLab.snp.bottom).offset(54)
        }
        endNameLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.right.equalTo(bgView).inset(35)
            make.top.equalTo(songLab)
        }
        userInfo.snp.makeConstraints { make in
            make.left.equalTo(endNameLab)
            make.top.equalTo(endNameLab.snp.bottom).offset(7)
        }
 
 

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

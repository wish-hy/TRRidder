//
//  TRHistoryOrderStateTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxSwift
import RxCocoa
class TRHistoryOrderStateTableViewCell: UITableViewCell {
    
    var typeView : UIButton!
    var timeLab : UILabel!
    var priceLab : UILabel!
    
    var quLab : UILabel!
    var startNameLab : UILabel!
    
    var songLab : UILabel!
    var endNameLab : UILabel!
    
    var orderLab : UILabel!
    var incomeLab : UILabel!

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
        
        typeView = UIButton()
        typeView.isEnabled = false
        typeView.setImage(UIImage(named: "home_time"), for: .normal)
        bgView.addSubview(typeView)
        
        timeLab = UILabel()
        timeLab.text = "10:00"
        timeLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        timeLab.font = UIFont.trBoldFont(fontSize: 17)
        bgView.addSubview(timeLab)
        
        let doneLab = UILabel()
        doneLab.text = "送达"
        doneLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        doneLab.font = UIFont.trFont(fontSize: 14)
        bgView.addSubview(doneLab)
        
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
        
        incomeLab = UILabel()
        incomeLab.text = "订单编号：238430294"
        incomeLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        incomeLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(incomeLab)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.right.equalTo(contentView).inset(15)
            make.height.equalTo(200)
            make.bottom.equalTo(contentView)
        }
        typeView.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(14)
            make.top.equalTo(bgView).offset(24)
            make.height.width.equalTo(18)
        }
        timeLab.snp.makeConstraints { make in
            make.centerY.equalTo(typeView)
            make.left.equalTo(typeView.snp.right).offset(2)
        }
        doneLab.snp.makeConstraints { make in
            make.left.equalTo(timeLab.snp.right).offset(2)
            make.centerY.equalTo(typeView)
        }
        
        
        priceLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(7)
            make.centerY.equalTo(typeView)
        }
        
        quLab.snp.makeConstraints { make in
            make.left.equalTo(line)
            make.height.width.equalTo(18)
            make.top.equalTo(line.snp.bottom).offset(17)
        }
        //横线
        line.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(typeView.snp.bottom).offset(20)
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
            make.top.equalTo(line2).offset(16)
        }
 
        incomeLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).offset(-15)
            make.centerY.equalTo(orderLab)
        }
        
        let dhMutablestring = NSMutableAttributedString()
                    
        let dhStr1 = NSAttributedString(string: "已发放", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0x97989A)])
      
        let dhStr2 = NSAttributedString(string: " ¥5.5", attributes: [.font : UIFont.trBoldFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0xFF652F)])
        dhMutablestring.append(dhStr1)
        dhMutablestring.append(dhStr2)
        incomeLab.attributedText = dhMutablestring

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

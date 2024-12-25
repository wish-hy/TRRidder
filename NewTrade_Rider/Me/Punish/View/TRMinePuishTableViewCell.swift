//
//  TRMinePuishTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit
import RxCocoa
import RxSwift
class TRMinePuishTableViewCell: UITableViewCell {
    
    var reasonLab : UILabel!
    var punishLab : UILabel!
    var appealTimeLab : UILabel!
    
    var quLab : UILabel!
    var startNameLab : UILabel!
    
    var songLab : UILabel!
    var endNameLab : UILabel!
    
    var orderLab : UILabel!
    var timeLab : UILabel!

    var appealBtn : UIButton!
    
    var stateView : TRAppealStateView!
    
    var bgView : UIView!
    
    var bag = DisposeBag()
    
    var state : Int = 1 {
        didSet{
            if state == 0 {
                self.appealBtn.isHidden = false
                self.stateView.isHidden = true
            } else {
                self.appealBtn.isHidden = true
                self.stateView.isHidden = false
                self.stateView.type = state
            }
        }
    }
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
    

        reasonLab = UILabel()
        reasonLab.text = "物品破损"
        reasonLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        reasonLab.font = UIFont.trFont(fontSize: 15)
        bgView.addSubview(reasonLab)
        
        punishLab = UILabel()
        punishLab.text = "扣款5.80元"
        punishLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        punishLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(punishLab)
        
        appealTimeLab = UILabel()
        appealTimeLab.text = "请在07-26 16:30前申诉"
        appealTimeLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        appealTimeLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(appealTimeLab)
        
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
        //隐藏
        orderLab.isHidden = true
        orderLab.text = "订单编号：238430294"
        orderLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        orderLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(orderLab)
        
        timeLab = UILabel()
        timeLab.text = "今天10:00"
        timeLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        timeLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(timeLab)
        
        appealBtn = UIButton()
        appealBtn.setTitle("申诉", for: .normal)
        appealBtn.layer.cornerRadius = 16
        appealBtn.layer.masksToBounds = true
        appealBtn.titleLabel?.font = UIFont.trFont(fontSize: 14)
        appealBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF93F3F)
        bgView.addSubview(appealBtn)
        
        stateView = TRAppealStateView(frame: .zero)
        bgView.addSubview(stateView)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.right.equalTo(contentView).inset(15)
            make.height.equalTo(195)
            make.bottom.equalTo(contentView)
        }

        punishLab.snp.makeConstraints { make in
            make.left.equalTo(reasonLab.snp.right).offset(2)
            make.centerY.equalTo(reasonLab)
        }
        reasonLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(10)
            make.top.equalTo(bgView).offset(17)
       
        }
        
        
        appealTimeLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(15)
            make.centerY.equalTo(punishLab)
        }
        
        quLab.snp.makeConstraints { make in
            make.left.equalTo(line)
            make.height.width.equalTo(18)
            make.top.equalTo(line.snp.bottom).offset(17)
        }
        //横线
        line.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(punishLab.snp.bottom).offset(18)
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
            make.left.equalTo(bgView).offset(10)
            make.centerY.equalTo(orderLab)
        }
        
        appealBtn.snp.makeConstraints { make in
            make.centerY.equalTo(timeLab)
            make.right.equalTo(bgView).offset(-15)
            make.height.equalTo(32)
            make.width.equalTo(64)
        }
        
        stateView.snp.makeConstraints { make in
            make.centerY.equalTo(timeLab)
            make.right.equalTo(bgView).inset(11)
            make.height.equalTo(28)
//            make.width.equalTo(108)
        }

        stateView.type = 3
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

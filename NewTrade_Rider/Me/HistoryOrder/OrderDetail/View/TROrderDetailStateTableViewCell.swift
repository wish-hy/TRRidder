//
//  TROrderDetailStateTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TROrderDetailStateTableViewCell: UITableViewCell {
    var stateBgImgV : UIImageView!
    var stateImgV : UIImageView!
    
    var stateLab : UILabel!
    var stateDetailLab : UILabel!
    
    var priceLab : UILabel!
    
    var reasonView : TROrderReasonView!
    
    var timeLineView : TROrderTimeLineView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        stateBgImgV = UIImageView(image: UIImage(named: "order complete_bg"))
        contentView.addSubview(stateBgImgV)
        
        stateImgV = UIImageView(image: UIImage(named: "order_complete"))
        contentView.addSubview(stateImgV)
        
        stateLab = UILabel()
        stateLab.text = "已取消"
        stateLab.textColor = UIColor.hexColor(hexValue: 0x7AD0A0)
        stateLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(stateLab)
        
        stateDetailLab = UILabel()
        stateDetailLab.text = "骑手已取消"
        stateDetailLab.textColor = UIColor.hexColor(hexValue: 0xA3E3BF)
        stateDetailLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(stateDetailLab)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xA3D7BE)
        contentView.addSubview(line)
        
        priceLab = UILabel()

        contentView.addSubview(priceLab)
        
        reasonView = TROrderReasonView(frame: .zero)
        contentView.addSubview(reasonView)
        
        timeLineView = TROrderTimeLineView(frame: .zero)
        contentView.addSubview(timeLineView)
        
        stateBgImgV.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(90)
        }
        stateImgV.snp.makeConstraints { make in
            make.left.equalTo(stateBgImgV).offset(14)
            make.width.height.equalTo(28)
            make.centerY.equalTo(stateBgImgV)
        }
        
        stateLab.snp.makeConstraints { make in
            make.top.equalTo(stateBgImgV).offset(20)
            make.left.equalTo(stateImgV.snp.right).offset(10)
        }
        stateDetailLab.snp.makeConstraints { make in
            make.left.equalTo(stateLab)
            make.top.equalTo(stateLab.snp.bottom).offset(6)
        }
        
        line.snp.makeConstraints { make in
            make.centerY.equalTo(stateLab)
            make.left.equalTo(stateLab.snp.right).offset(10)
            make.width.equalTo(1)
            make.height.equalTo(10)
        }
        priceLab.snp.makeConstraints { make in
            make.centerY.equalTo(stateLab)
            make.left.equalTo(line).offset(10)
        }
        
        reasonView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(20)
            make.top.equalTo(stateBgImgV.snp.bottom).offset(20)
            make.height.equalTo(74)
        }
        timeLineView.snp.makeConstraints { make in
            make.top.equalTo(reasonView.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
            make.height.equalTo(53)
        }
        let dhMutablestring = NSMutableAttributedString()
                    
        let dhStr1 = NSAttributedString(string: "已发放", attributes: [.font : UIFont.trFont(fontSize: 14), .foregroundColor : UIColor.hexColor(hexValue: 0x97989A)])
      
        let dhStr2 = NSAttributedString(string: " ¥5.5", attributes: [.font : UIFont.trBoldFont(fontSize: 14), .foregroundColor : UIColor.hexColor(hexValue: 0xFF652F)])
        dhMutablestring.append(dhStr1)
        dhMutablestring.append(dhStr2)
        priceLab.attributedText = dhMutablestring
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

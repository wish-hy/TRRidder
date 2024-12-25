//
//  TRSelectStepView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/21.
//

import UIKit

class TRSelectStepViewCell: UITableViewCell {
    var circleView : UIView!
    var lab : UILabel!
    
    var topLine : UIView!
    var bottomLine : UIView!
    
    var arrowImgV : UIImageView!
    
    var lineType = 0 {
        didSet {
            if lineType == 0 {
                topLine.isHidden = true
                bottomLine.isHidden = true
            } else if lineType == 1 {
                topLine.isHidden = false
                bottomLine.isHidden = true
            } else if lineType == 2 {
                topLine.isHidden = false
                bottomLine.isHidden = true
            } else if lineType == 3{
                topLine.isHidden = false
                bottomLine.isHidden = false
            }
        }
    }
    var circleType : Int = 0 {
        didSet {
            if circleType == 0 {
                circleView.backgroundColor = .white
                circleView.layer.borderColor = UIColor.hexColor(hexValue: 0x1D6CFF).cgColor
                lab.textColor = .hexColor(hexValue: 0x1D6CFF)
                arrowImgV.isHidden = true
            } else {
                circleView.backgroundColor = .hexColor(hexValue: 0x1D6CFF)
                circleView.layer.borderColor = UIColor.white.cgColor
                lab.textColor = .txtColor()
                arrowImgV.isHidden = false
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        circleView = UIView()
        circleView.backgroundColor = .clear
        circleView.layer.cornerRadius = 4
        circleView.layer.borderWidth = 1
        circleView.layer.borderColor = UIColor.themeColor().cgColor
        contentView.addSubview(circleView)
        
        lab = UILabel()
        lab.textColor = .themeColor()
        lab.font = UIFont.trMediumFont(fontSize: 14)
        contentView.addSubview(lab)
        
        topLine = UIView()
        topLine.backgroundColor = .themeColor()
        contentView.addSubview(topLine)
        
        bottomLine = UIView()
        bottomLine.backgroundColor = .hexColor(hexValue: 0x1D6CFF)
        contentView.addSubview(bottomLine)
        
        arrowImgV = UIImageView(image: UIImage(named: "mine_more"))
        contentView.addSubview(arrowImgV)
        
        lab.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(20)
            make.left.equalTo(contentView).offset(40)
        }
        circleView.snp.makeConstraints { make in
            make.centerY.equalTo(lab)
            make.left.equalTo(contentView).offset(16)
            make.width.height.equalTo(8)
        }
        
        topLine.snp.makeConstraints { make in
            make.centerX.equalTo(circleView)
            make.top.equalTo(contentView)
            make.bottom.equalTo(circleView.snp.top)
            make.width.equalTo(1)
        }
        bottomLine.snp.makeConstraints { make in
            make.centerX.equalTo(circleView)
            make.top.equalTo(circleView.snp.bottom)
            make.bottom.equalTo(contentView)
            make.width.equalTo(1)
        }
        arrowImgV.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(10)
            make.height.width.equalTo(18)
            make.centerY.equalTo(circleView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

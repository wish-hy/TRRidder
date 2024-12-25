//
//  TRMineApplyAccounInfoCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit

class TRMineApplyAccounInfoCell: UITableViewCell {

    var nameLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
        bgView.backgroundColor = .white
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer;
        contentView.addSubview(bgView)
        
        let itemLab = TRFactory.labelWith(font: .trFont(16), text: "姓名：", textColor: .txtColor(), superView: bgView)
        itemLab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameLab = TRFactory.labelWith(font: .trBoldFont(20), text: TRDataManage.shared.riderModel.name, textColor: .txtColor(), alignment: .left, lines: 1, superView: bgView)
        
        let infoLab = TRFactory.labelWith(font: .trFont(16), text: "证件信息", textColor: .themeColor(), superView: bgView)
        let arrowImgV = UIImageView(image: UIImage(named: "blance_arrow"))
        bgView.addSubview(arrowImgV)
        
        let line = UIView()
        line.backgroundColor = .bgColor()
        contentView.addSubview(line)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(64)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(12)
            make.height.equalTo(1)
            make.bottom.equalTo(bgView)
        }
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.centerY.equalTo(bgView)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(itemLab.snp.right).offset(0)
            make.centerY.equalTo(bgView)
            make.right.equalTo(infoLab.snp.left).offset(-44)
        }
        
        arrowImgV.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(8)
            make.centerY.equalTo(bgView)
            make.width.height.equalTo(16)
        }
        infoLab.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.right.equalTo(arrowImgV.snp.left).offset(-2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

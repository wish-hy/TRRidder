//
//  TRTaskDetailDelMethodCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/1.
//

import UIKit

class TRTaskDetailDelMethodCell: UITableViewCell {

    var nameLab : UILabel!
    var detailLab : UILabel!
    
    var specView : UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        nameLab = UILabel()
        nameLab.text = "配送方式"
        nameLab.textColor = .txtColor()
        nameLab.font = .trFont(16)
        contentView.addSubview(nameLab)
        
        detailLab = UILabel()
        detailLab.text = "x1"
        detailLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        detailLab.font = .trMediumFont(16)
        contentView.addSubview(detailLab)
        
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        detailLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
//            make.right.equalTo(contentView).inset(16)
            make.left.equalTo(contentView).inset(110)
            make.height.equalTo(24)
        }
        
        specView = configSpecView()
        contentView.addSubview(specView)
        specView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(detailLab.snp.right).offset(6)
            make.height.equalTo(18)
            make.width.equalTo(44)
        }
    }
    private func configSpecView()->UIView{
        let layerView = UIView()
        layerView.trCorner(2)
        layerView.frame = CGRect(x: 0, y: 0, width: 44, height: 18)
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 0.92, green: 0.67, blue: 0.36, alpha: 1).cgColor, UIColor(red: 0.85, green: 0.44, blue: 0.26, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = layerView.bounds
        bgLayer1.startPoint = CGPoint(x: 0, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
        layerView.layer.addSublayer(bgLayer1)
        
        let icon = UIImageView(image: UIImage(named: "order_spec"))
        layerView.addSubview(icon)
        
        
        let lab = TRFactory.labelWith(font: .trFont(10), text: "专送", textColor: .hexColor(hexValue: 0xFFFAC7), superView: layerView)
        
        layerView.addSubview(lab)
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(layerView).offset(4)
            make.centerY.equalTo(layerView)
            make.height.width.equalTo(12)
        }
        lab.snp.makeConstraints { make in
            make.centerY.equalTo(layerView)
            make.left.equalTo(icon.snp.right).offset(1)
        }
        
        return layerView
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

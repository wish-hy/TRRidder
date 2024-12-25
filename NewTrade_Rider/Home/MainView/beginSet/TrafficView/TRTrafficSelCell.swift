//
//  TRTrafficSelCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/2/20.
//

import UIKit

class TRTrafficSelCell: UITableViewCell {
    var trafficImgV : UIImageView!
    var iconImgV : UIImageView!
    var nameLab : UILabel!
    var typeLab : UILabel!
    var selImgV : UIImageView!
    var line : UIView!

    var model : TRApplerVehicleInfoModel? {
        didSet {
            guard let model = model else { return }
            trafficImgV.sd_setImage(with: URL.init(string: model.iconUrl), placeholderImage: UIImage(named: "traffic_ele"), context: nil)
            nameLab.text = model.numberplate
            typeLab.text = model.arName
        }
    }
    
    //申请时的车辆信息
    var applyVehiclemodel : TRRidderApplyVehicleSelModel? {
        didSet {
            guard let applyVehiclemodel = applyVehiclemodel else { return }
            if applyVehiclemodel.isUseful {
                trafficImgV.sd_setImage(with: URL.init(string: applyVehiclemodel.iconUrl), placeholderImage: UIImage(named: "traffic_ele"), context: nil)
                iconImgV.image = UIImage(named: "traffic_car_icon")
                nameLab.textColor = .txtColor()
                typeLab.textColor = .hexColor(hexValue: 0x97989A)
            } else {
                trafficImgV.image = UIImage(named: "electromobile_gray")
                iconImgV.image = UIImage(named: "traffic_car_icon_gray")
                nameLab.textColor = .hexColor(hexValue: 0xC6C9CB)
                typeLab.textColor = .hexColor(hexValue: 0xC6C9CB)

            }
            nameLab.text = applyVehiclemodel.numberplate
            typeLab.text = applyVehiclemodel.codeName
        }
    }
    //开工时的选择
    var isSel : Bool = false {
        didSet {
            if isSel {
                selImgV.image = UIImage(named: "sel_circle")
            } else {
                selImgV.image = UIImage(named: "sel_nor")
            }
        }
    }
    var isApplySel : Bool = false {
        didSet {
            if isSel {
                selImgV.image = UIImage(named: "address_sel")
                selImgV.isHidden = false
            } else {
                selImgV.isHidden = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        trafficImgV = TRFactory.imageViewWith(image: UIImage(named: "traffic_ele"), mode: .scaleAspectFill, superView: contentView)
        iconImgV = TRFactory.imageViewWith(image: UIImage(named: "traffic_car_icon"), mode: .scaleAspectFill, superView: contentView)
        nameLab = TRFactory.labelWith(font: .trMediumFont(20), text: "深A·66666", textColor: .txtColor(), superView: contentView)
        typeLab = TRFactory.labelWith(font: .trFont(12), text: "电动车", textColor: .hexColor(hexValue: 0x97989A), superView: contentView)
        selImgV = TRFactory.imageViewWith(image: UIImage(named: "sel_nor"), mode: .scaleAspectFill, superView: contentView)
        
        line = UIView()
        line.backgroundColor = .lineColor()
        contentView.addSubview(line)
        
        trafficImgV.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).inset(15)
            make.bottom.equalTo(contentView).inset(10)
            make.width.height.equalTo(50)
        }
        iconImgV.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.left.equalTo(trafficImgV.snp.right).offset(10)
            make.top.equalTo(trafficImgV)
        }
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgV)
            make.left.equalTo(iconImgV.snp.right).offset(5)
        }
        typeLab.snp.makeConstraints { make in
            make.bottom.equalTo(trafficImgV)
            make.left.equalTo(iconImgV)
        }
        selImgV.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.width.equalTo(24)
            make.right.equalTo(contentView).inset(15)
        }
        line.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.left.equalTo(trafficImgV.snp.right)
            make.height.equalTo(1)
            make.right.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

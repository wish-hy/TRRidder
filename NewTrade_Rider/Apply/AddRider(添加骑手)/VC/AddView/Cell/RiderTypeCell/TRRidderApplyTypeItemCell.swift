//
//  TRRidderApplyTypeItemCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/18.
//

import UIKit

class TRRidderApplyTypeItemCell: UICollectionViewCell {
    var titleLab : UILabel!
    var infoLab : UILabel!
    
    var imgV : UIImageView!
    
    var selImgV : UIImageView!
    
    var model : TRRiderApplyTypeModel? {
        didSet {
            guard let model = model else { return }
            titleLab.text = model.name
            infoLab.text = model.intro
            imgV.image = UIImage(named: model.localImgName)
        }
    }
    
    var isSel : Bool = false {
        didSet {
            if isSel {
                bgView.layer.borderColor = UIColor.themeColor().cgColor
                selImgV.isHidden = false
            } else {
                bgView.layer.borderColor = UIColor.hexColor(hexValue: 0xD1D4D5).cgColor
                selImgV.isHidden = true
            }
        }
    }
    
    var bgView : UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setupView()
    }
    
    private func setupView(){
        
        bgView = UIView()
        bgView.trCorner(8)
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.hexColor(hexValue: 0xD1D4D5).cgColor
        contentView.addSubview(bgView)
        
        titleLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 16), text: "普通骑手", textColor: .txtColor(), superView: bgView)
        
        infoLab = TRFactory.labelWith(font: .trFont(fontSize: 12), text: "自由接单\n多跑多赚", textColor: .hexColor(hexValue: 0x67686A), superView: bgView)
        infoLab.numberOfLines = 0
        imgV = UIImageView(image: UIImage(named: "vihicle_common"))
        bgView.addSubview(imgV)
        
        selImgV = UIImageView(image: UIImage(named: "vihicle_common_sel"))
        bgView.addSubview(selImgV)
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(10)
            make.top.equalTo(bgView).offset(15)
        }
        infoLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.bottom.equalTo(imgV)
        }
        
        imgV.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.centerY.equalTo(bgView)
            make.right.equalTo(bgView).inset(12)
        }
        
        selImgV.snp.makeConstraints { make in
            make.top.right.equalTo(bgView)
        }
        selImgV.isHidden = false
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

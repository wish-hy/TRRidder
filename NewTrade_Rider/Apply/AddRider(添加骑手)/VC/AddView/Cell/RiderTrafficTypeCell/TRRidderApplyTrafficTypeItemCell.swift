//
//  TRRidderApplyTrafficTypeItemCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/18.
//

import UIKit

class TRRidderApplyTrafficTypeItemCell: UICollectionViewCell {
    var itemImgV : UIImageView!
    var itemLab : UILabel!
    
    var model : TRRiderVehicleTypeModel? {
        didSet {
            guard let model = model else { return }
            itemImgV.sd_setImage(with: URL.init(string: model.iconUrl), placeholderImage: Net_Default_Img)
            itemLab.text = model.name
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        itemImgV = TRFactory.imageViewWith(image: UIImage(named: "traffic_ele"), mode: .scaleAspectFit, superView: contentView)
        itemLab = TRFactory.labelWith(font: .trFont(12), text: "电车", textColor: .hexColor(hexValue: 0x67686A), superView: contentView)
        itemLab.textAlignment = .center
        itemImgV.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(contentView).offset(12)
            make.centerX.equalTo(contentView)
        }
        itemLab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(itemImgV.snp.bottom).offset(2)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TRRiderTrainHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/26.
//

import UIKit

class TRRiderTrainHeader: UITableViewHeaderFooterView {
    var lab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    

    
    private func setupUI(){
        let topImgV = TRFactory.imageViewWith(image: UIImage(named: "rider_train_top"), mode: .scaleAspectFill, superView: contentView)
        let tipImgV = TRFactory.imageViewWith(image: UIImage(named: "rider_train_tip_bg"), mode: .scaleToFill, superView: contentView)
        contentView.addSubview(topImgV)
        
        lab = TRFactory.labelWith(font: .trFont(14), text: "非常棒！你已完成骑手培训，成为一名合格的骑手，接单工作中请注意安全。", textColor: .hexColor(hexValue: 0x4E8063 ), superView: tipImgV)
        lab.numberOfLines = 2
        
        topImgV.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(240 * TRWidthScale)
        }
        tipImgV.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(topImgV.snp.bottom).offset(-25)
            make.bottom.equalTo(contentView)
            make.height.equalTo(58)
        }
        
        lab.snp.makeConstraints { make in
            make.left.equalTo(tipImgV).offset(85)
            make.centerY.equalTo(tipImgV)
            make.right.equalTo(tipImgV.snp.right).offset(-15)
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

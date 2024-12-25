//
//  TRTaskDetailTotalItemCollectionCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/1.
//

import UIKit

class TRTaskDetailTotalItemCollectionCell: UICollectionViewCell {
    var itemImgV : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        itemImgV = TRFactory.imageViewWith(image: Net_Default_Img, mode: .scaleAspectFill, superView: contentView)
        itemImgV.trCorner(12)
        itemImgV.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

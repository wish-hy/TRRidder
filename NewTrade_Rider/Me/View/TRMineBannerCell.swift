//
//  TRMineBannerCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineBannerCell: UICollectionViewCell {
    var recycleView : SDCycleScrollView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    

    private func setupView(){
        contentView.backgroundColor = .bgColor()
        
        recycleView = SDCycleScrollView(frame: .zero)
        recycleView.backgroundColor = .bgColor()
        contentView.addSubview(recycleView)
        recycleView.layer.cornerRadius = 10
        recycleView.layer.masksToBounds = true
        recycleView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(15)
            make.top.bottom.equalTo(contentView).inset(0)
        }
        
        recycleView.localizationImageNamesGroup = ["me_banner"]
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

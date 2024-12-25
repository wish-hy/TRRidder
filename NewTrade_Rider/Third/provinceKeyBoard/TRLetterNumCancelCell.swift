//
//  TRLetterNumCancelCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/5/30.
//

import UIKit

class TRLetterNumCancelCell: UICollectionViewCell {
    let w = (Screen_Width - 16 - 6 * 7) / 10
    var cancelImgV : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        let bgView = UIView()
        bgView.layer.cornerRadius = 6
        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
        
        cancelImgV = UIImageView()
        cancelImgV.image = UIImage(named: "cancel_keyboard")
        cancelImgV.contentMode = .scaleAspectFit
        contentView.addSubview(cancelImgV)
        cancelImgV.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
            make.center.equalTo(contentView)
        }
        bgView.snp.makeConstraints { make in
            make.height.equalTo(w + 8)
            make.width.equalTo(w + 8)
            make.top.bottom.left.right.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

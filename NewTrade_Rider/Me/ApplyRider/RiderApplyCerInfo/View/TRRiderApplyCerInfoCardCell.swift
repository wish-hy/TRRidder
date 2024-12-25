//
//  TRRiderApplyCerInfoCardCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit

class TRRiderApplyCerInfoCardCell: UITableViewCell {
    var frontImgV : UIImageView!
    var backImgV : UIImageView!
    
    var model : TRApplerUserInfoModel? {
        didSet {
            guard let model = model else { return }
            frontImgV.sd_setImage(with: URL.init(string: model.idCardFrontUrl), placeholderImage: Net_Default_Img)
            backImgV.sd_setImage(with: URL.init(string: model.idCardBackUrl), placeholderImage: Net_Default_Img)
            
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 1000), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        frontImgV = TRFactory.imageViewWith(image: Net_Default_Img, mode: .scaleAspectFit, superView: bgView)
        frontImgV.backgroundColor = .bgColor()
        frontImgV.clipsToBounds = true
        backImgV = TRFactory.imageViewWith(image: Net_Default_Img, mode: .scaleAspectFit, superView: bgView)
        backImgV.backgroundColor = .bgColor()
        backImgV.clipsToBounds = true
        
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
        
        frontImgV.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(9)
            make.top.equalTo(bgView).offset(12)
            make.height.equalTo(110)
            make.right.equalTo(bgView.snp.centerX).inset(2.5)
            make.bottom.equalTo(bgView).inset(10)
        }
        backImgV.snp.makeConstraints { make in
            make.left.equalTo(frontImgV.snp.right).offset(2.5)
            make.top.bottom.equalTo(frontImgV)
            make.right.equalTo(bgView).inset(9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

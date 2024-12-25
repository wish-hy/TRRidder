//
//  TRHomeBeginHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/16.
//

import UIKit

class TRHomeBeginHeader: UIView {

    
    var riderSatitView : TRHomeRiderStaticView!
    var banner : SDCycleScrollView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = .hexColor(hexValue: 0xE7E9EB)
        riderSatitView = TRHomeRiderStaticView(frame: .zero)
        self.addSubview(riderSatitView)
        
        let bannerBg = UIView()
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bannerBg.layer.mask = maskLayer;
        
        bannerBg.backgroundColor = .white
        
        self.addSubview(bannerBg)
        banner = SDCycleScrollView(frame: .zero)
        banner.backgroundColor = .clear
        banner.localizationImageNamesGroup = ["traffic_tip"]
        self.addSubview(banner)
        
        
        riderSatitView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self)
        }
        bannerBg.snp.makeConstraints { make in
            make.height.equalTo(129)
            make.left.right.equalTo(self)
            make.top.equalTo(riderSatitView.snp.bottom).offset(12)
            make.bottom.equalTo(self)
        }
        banner.snp.makeConstraints { make in
            make.left.right.equalTo(bannerBg).inset(16)
            make.top.equalTo(bannerBg).offset(15)
            make.height.equalTo(104)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

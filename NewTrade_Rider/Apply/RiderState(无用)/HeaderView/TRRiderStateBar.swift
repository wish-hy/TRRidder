//
//  TRRiderStateBar.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderStateBar: UIView {
    var backBtn : UIButton!
    var titleLab : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        self.clipsToBounds = true
       let bgImgV = UIImageView(image: UIImage(named: "rider_state_top_bg"))
        self.addSubview(bgImgV)
        
        backBtn = TRFactory.buttonWith(image: UIImage(named: "nav_white"), superView: self)
        
        titleLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 17), text: "骑手待审核", textColor: .white, superView: self)
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.equalTo(self)
            make.height.equalTo(182)
        }
        
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(9)
            make.height.width.equalTo(24)
            make.bottom.equalTo(self).inset(8)
        }
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

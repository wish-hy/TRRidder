//
//  TRSimpleTipView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/6.
//

import UIKit

class TRSimpleTipView: TRPopBaseView {

    var tipLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        let bgImgV = UIImageView(image: UIImage(named: "pop_bg"))
        bgImgV.isUserInteractionEnabled = true
        bgImgV.trCorner(15)
        contentView.addSubview(bgImgV)
        
        let cancelBtn = TRFactory.buttonWith(image: UIImage(named: "cancel_gray"), superView: bgImgV)
        cancelBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        tipLab = TRFactory.labelWith(font: .trBoldFont(18), text: "差价账单已发送至用户账户，请等待用户支付", textColor: .txtColor(), superView: contentView)
        tipLab.numberOfLines = 0
        tipLab.textAlignment = .center
        tipLab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(40)
            make.centerY.equalTo(bgImgV)
        }
        
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
            make.height.equalTo(172)
            make.width.equalTo(302)
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.right.equalTo(bgImgV).inset(8)
            make.width.height.equalTo(24)
        }
    }
    override func addToWindow() {
        super.addToWindow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
            guard let self = self else {return}
            self.closeView()
        }
    }
    @objc func closeView(){
        self.removeFromSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

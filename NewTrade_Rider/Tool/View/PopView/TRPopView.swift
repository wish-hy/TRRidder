//
//  TRPopView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRPopView: TRPopBaseView {
    
    private var bg : UIView!
    var icon : UIImageView!
    var lab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }
    
    private func setupSubView(){
        contentView.backgroundColor = .clear
        bg = UIView()
        bg.layer.cornerRadius = 13
        bg.layer.masksToBounds = true
        bg.backgroundColor = UIColor.hexColor(hexValue: 0x2D2F31)
        contentView.addSubview(bg)
        
        icon = UIImageView()
        icon.image = UIImage(named: "pop_success")
        contentView.addSubview(icon)
        
        lab = UILabel()
        lab.text = "昨日收入(元)"
        lab.textColor = .white
        lab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(lab)
        
        bg.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.height.equalTo(124)
            make.width.equalTo(162)
        }
        contentView.snp.remakeConstraints { make in
            make.left.right.top.bottom.equalTo(bg)
        }
        icon.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.centerX.equalTo(bg)
            make.top.equalTo(bg).offset(23)
        }
        lab.snp.makeConstraints { make in
            make.centerX.equalTo(bg)
            make.bottom.equalTo(bg).offset(-22)
        }
        self.layoutIfNeeded()
    }
    
    override func addToWindow() {
        super.addToWindow()

        self.bg.transform = self.transform.scaledBy(x: 0.85, y: 0.85)
        UIView.animate(withDuration: 0.02) {
            self.bg.transform = .identity
        } completion: { _ in
            
        }

        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, flags: []) {
            self.removeFromSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

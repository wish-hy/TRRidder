//
//  TRHomeRiderStaticSubView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/16.
//

import UIKit

class TRHomeRiderStaticSubView: UIView {
    
    var itemLab : UILabel!
    var valueLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        itemLab = TRFactory.labelWith(font: .trFont(13), text: "昨日收入", textColor: .white, superView: self)
        itemLab.textAlignment = .center
        valueLab = UILabel()
        valueLab.textAlignment = .center
        valueLab.textColor = .white
        valueLab.text = "0.00"
        self.addSubview(valueLab)
        itemLab.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.centerY).inset(5)
        }
        valueLab.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY).offset(5)
            make.left.right.equalTo(self)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

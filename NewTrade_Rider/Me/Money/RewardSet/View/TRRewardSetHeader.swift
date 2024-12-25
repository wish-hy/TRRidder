//
//  TRRewardSetHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRRewardSetHeader: UITableViewHeaderFooterView {
    var titleLab : UILabel!
    
    var desLab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    

    
    private func setupUI(){
        titleLab = UILabel()
        titleLab.text = "打赏金额设置"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 15)
        self.addSubview(titleLab)
        
        desLab = UILabel()
        desLab.text = "设置小小金额以此鼓励"
        desLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        desLab.font = UIFont.trFont(fontSize: 13)
        self.addSubview(desLab)
        
        titleLab.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(5)
            make.left.equalTo(self).offset(16)
        }
        
        desLab.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalTo(self).inset(16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

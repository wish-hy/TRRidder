//
//  TRPickupSetHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRPickupSetHeader: UITableViewHeaderFooterView {

    var titleLab : UILabel!
    
    var desLab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    private func setupView(){
 
        
        contentView.backgroundColor = .white
        titleLab = UILabel()
        titleLab.text = "签约店铺优先派单"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        desLab = UILabel()
        desLab.numberOfLines = 0
        desLab.text = "签约店铺优先派单需要在店铺商家发起和你签约，申请后系统自动开启签约模式，优先自动派发签约店铺的订单"
        desLab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB )
        desLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(desLab)

        titleLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(15)
        }
        desLab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

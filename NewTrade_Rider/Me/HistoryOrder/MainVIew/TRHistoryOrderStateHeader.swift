//
//  TRHistoryOrderStateHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRHistoryOrderStateHeader: UITableViewHeaderFooterView {
    var  menuView : TRHistoryOrderMenuView!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupVIew()
    }
    private func setupVIew(){
        let incomeTipLab = UILabel()
        incomeTipLab.text = "昨日收入(元)"
        incomeTipLab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        incomeTipLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(incomeTipLab)
        menuView = TRHistoryOrderMenuView(frame: .zero)
        contentView.addSubview(menuView)
        
        incomeTipLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(0)
        }
        menuView.snp.makeConstraints { make in
            make.left.equalTo(incomeTipLab)
            make.right.equalTo(contentView)
            make.top.equalTo(incomeTipLab.snp.bottom).offset(15)
            make.height.equalTo(25)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

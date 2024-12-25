//
//  TRCancelAcountTipCell.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/4/26.
//

import UIKit

class TRCancelAcountTipCell: UITableViewCell {
    var titleLab : UILabel!
    var tipLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        titleLab = TRFactory.labelWith(font: .trMediumFont(14), text: "注销账号有以下风险：", textColor: .txtColor(), superView: contentView)
        
        tipLab = TRFactory.labelWith(font: .trFont(14), text: "", textColor: .txtColor(), superView: contentView)
        tipLab.numberOfLines = 0
        let name = "嘉马骑手"
        tipLab.text = "1.永久注销，无法登录\n账号一旦注销，支持\(name)账户登录的多项产品/服务将无法登录井使用。\n2.所有账号数据将无法找回\n特别地，账号所产生的交易数据将被清空，请确保所有交易已完结且无纠纷，账号注销后因历史交易可能产生的资金退回等权益，将视作自动放弃。\n3.所有账号权益将永久清空\n您的身份信息、账户信息、平台积分、账期权益等平台会员权益将被清空且无法找回"
        
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(16)
        }
        tipLab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(titleLab.snp.bottom).offset(25)
            make.bottom.equalTo(contentView).inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

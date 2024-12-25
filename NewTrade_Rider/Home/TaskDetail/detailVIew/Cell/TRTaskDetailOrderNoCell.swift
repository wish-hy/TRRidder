//
//  TRTaskDetailOrderNoCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/1.
//

import UIKit

class TRTaskDetailOrderNoCell: UITableViewCell {
    var nameLab : UILabel!
    var detailLab : UILabel!
    
    var copyBtn : UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        nameLab = UILabel()
        nameLab.text = "订单编号"
        nameLab.textColor = .txtColor()
        nameLab.font = .trFont(16)
        contentView.addSubview(nameLab)
        
        detailLab = UILabel()
        detailLab.textColor = .txtColor()
        detailLab.font = .trMediumFont(16)
        contentView.addSubview(detailLab)
       
        copyBtn = TRFactory.buttonWithBorder(title: "复制", txtColor: .hexColor(hexValue: 0x67686A), borderColor: .hexColor(hexValue: 0xD6D8D9), font: .trFont(11), corner: 9)
        copyBtn.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        contentView.addSubview(copyBtn)
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        detailLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).inset(110)
            make.height.equalTo(24)
        }

        copyBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 18))
            make.centerY.equalTo(contentView)
            make.left.equalTo(detailLab.snp.right).offset(8)
        }

    }
    @objc func copyAction(){
        if !TRTool.isNullOrEmplty(s: detailLab.text) {
            UIPasteboard.general.string = detailLab.text
            SVProgressHUD.showSuccess(withStatus: "复制成功")
        } else {
            SVProgressHUD.showInfo(withStatus: "无订单号")
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRChatTimeCell.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/3/30.
//

import UIKit

class TRChatTimeCell: UITableViewCell {
    var lab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        let bgView = UIView()
        lab = TRFactory.labelWith(font: .trFont(12), text: "10:00", textColor: .hexColor(hexValue: 0x97989A), alignment: .center, lines: 1, superView: contentView)
        lab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

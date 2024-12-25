//
//  TRRiderReviewTrafficCodeCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderReviewTrafficCodeCell: UITableViewCell {

    var itemLab : UILabel!
    var codeView : TRTrafficCodeView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        let w = (Screen_Width - 24 - 3 * 6 - 9) / 8

        itemLab = TRFactory.labelWith(font: .trFont(fontSize: 16), text: "item", textColor: .txtColor(), superView: contentView)
        
        codeView = TRTrafficCodeView(frame: .zero)
        contentView.addSubview(codeView)
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(12)
            make.top.equalTo(contentView)
        }
        codeView.snp.makeConstraints { make in
            make.top.equalTo(itemLab.snp.bottom).offset(10)
            make.left.right.equalTo(contentView).inset(16)
            make.height.equalTo(w)
            make.bottom.equalTo(contentView).inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

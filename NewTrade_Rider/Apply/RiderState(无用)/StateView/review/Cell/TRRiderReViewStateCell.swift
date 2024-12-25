//
//  TRRiderReViewStateCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderReViewStateCell: UITableViewCell {
    var passBtn : UIButton!
    var failedBtn : UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        let itemLab = TRFactory.labelWithImportant(font: .trFont(fontSize: 16), text: "审核状态", textColor: .txtColor(), superView: contentView)
        
        passBtn = TRFactory.buttonWith(title: "通过", textColor: .txtColor(), font: .trFont(fontSize: 16), superView: contentView)
        passBtn.setImage(UIImage(named: "check_circle_point"), for: .normal)
        
        failedBtn = TRFactory.buttonWith(title: "不通过", textColor: .txtColor(), font: .trFont(fontSize: 16), superView: contentView)
        failedBtn.setImage(UIImage(named: "uncheck_circle"), for: .normal)
        
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(18)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-15)
        }
        
        failedBtn.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(12)
            make.centerY.equalTo(itemLab)
            make.height.equalTo(25)
            
        }
        
        passBtn.snp.makeConstraints { make in
            make.right.equalTo(failedBtn.snp.left).offset(-18)
            make.centerY.height.equalTo(failedBtn)
            
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

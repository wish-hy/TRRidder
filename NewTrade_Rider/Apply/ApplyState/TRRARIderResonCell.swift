//
//  TRRARIderResonCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/26.
//

import UIKit

class TRRARIderResonCell: UITableViewCell {
    var titleLab : UILabel!
    var resonLab : UILabel!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.trCorner(10)
        contentView.addSubview(bgView)
        
        titleLab = TRFactory.labelWith(font: .trMediumFont(18), text: "审核不通过原因：", textColor: .txtColor(), superView: bgView)
        resonLab = TRFactory.labelWith(font: .trFont(14), text: "根据对比来思考并不会让人逻辑混乱，因为即使是对比也可以联结称一个和谐的整体", textColor: .txtColor(), superView: bgView)
        resonLab.numberOfLines = 0
        
 
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).inset(15)
            make.top.equalTo(bgView).offset(15)
        }
        resonLab.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(titleLab.snp.bottom).offset(12)
            make.bottom.equalTo(bgView).inset(20)
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

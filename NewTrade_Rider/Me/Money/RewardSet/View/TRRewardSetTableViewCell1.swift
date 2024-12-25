//
//  TRRewardSetTableViewCell1.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRRewardSetTableViewCell1: UITableViewCell {
    
    var titleLab : UILabel!
    
    var priceLab : UILabel!
    
    
    var bgImgV : UIImageView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        
        bgImgV = UIImageView(image: UIImage(named: "yue_bg"))
        contentView.addSubview(bgImgV)
        
        titleLab = UILabel()
        titleLab.text = "钱包余额"
        titleLab.textColor = .white
        titleLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(titleLab)
        
        priceLab = UILabel()
        priceLab.text = "100"
        priceLab.textColor = .white
        priceLab.font = UIFont.trBoldFont(fontSize: 32)
        contentView.addSubview(priceLab)
        
 
        
       
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView).inset(15)
            make.bottom.equalTo(contentView).offset(0)
        }
        

        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgImgV).offset(15)
            make.top.equalTo(bgImgV).offset(35)
        }
        priceLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
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

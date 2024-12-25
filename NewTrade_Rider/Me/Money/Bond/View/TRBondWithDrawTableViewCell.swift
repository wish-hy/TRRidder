//
//  TRBondWithDrawTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRBondWithDrawTableViewCell: UITableViewCell {
    var titleLab : UILabel!
    
    var priceLab : UILabel!
    
    var actionBtn : TRRightButton!

    var bgImgV : UIImageView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    

    
    
    private func setupView(){
        
        
        bgImgV = UIImageView(image: UIImage(named: "yue_bg"))
        contentView.addSubview(bgImgV)
        
        titleLab = UILabel()
        titleLab.text = "钱包余额"
        titleLab.textColor = .white
        titleLab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(titleLab)
        
        priceLab = UILabel()
        priceLab.text = "100"
        priceLab.textColor = .white
        priceLab.font = UIFont.trBoldFont(fontSize: 32)
        contentView.addSubview(priceLab)
        
        actionBtn = TRRightButton(frame: .zero)
        actionBtn.lab.text = "提现"
        actionBtn.lab.textColor = .red
        actionBtn.lab.font = UIFont.trFont(fontSize: 16)
        actionBtn.imgV.image = UIImage(named: "tx_arrow")
        actionBtn.backgroundColor = UIColor.hexColor(hexValue: 0xFFFEF1)
        actionBtn.layer.cornerRadius = 17
        actionBtn.layer.masksToBounds = true
        contentView.addSubview(actionBtn)
        
       
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView).inset(15)
            make.bottom.equalTo(contentView).offset(0)
        }
        
        actionBtn.snp.makeConstraints { make in
            make.centerY.equalTo(priceLab)
            make.right.equalTo(bgImgV).offset(-15)
//            make.width.equalTo(78)
            make.height.equalTo(34)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

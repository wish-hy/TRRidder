//
//  TRHistoryOrderInfoTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRHistoryOrderInfoTableViewCell: UITableViewCell {
    
    var incomeLab : UILabel!
    var detailLab : UILabel!
    
    var doneLab : UILabel!
    var cancelLab : UILabel!
    var transLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        
        let bgImgV = UIImageView(image: UIImage(named: "history_order_header_bg"))
        contentView.addSubview(bgImgV)
        
        let incomeTipLab = UILabel()
        incomeTipLab.text = "总收入"
        incomeTipLab.textColor = UIColor.hexColor(hexValue: 0xE0FFEE)
        incomeTipLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(incomeTipLab)
        
        incomeLab = UILabel()
        incomeLab.text = "153"
        incomeLab.textColor = .white
        incomeLab.font = UIFont.trBoldFont(fontSize: 26)
        contentView.addSubview(incomeLab)
        
        detailLab = UILabel()
        detailLab.text = "配送费 120"
        detailLab.textColor = .white
        detailLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(detailLab)
        
        let doneTipLab = UILabel()
        doneTipLab.text = "完成单"
        doneTipLab.textColor = UIColor.hexColor(hexValue: 0xE0FFEE)
        doneTipLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(doneTipLab)
        
        doneLab = UILabel()
        doneLab.text = "120"
        doneLab.textColor = .white
        doneLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(doneLab)
        
        let cancelTipLab = UILabel()
        cancelTipLab.text = "完成单"
        cancelTipLab.textColor = UIColor.hexColor(hexValue: 0xE0FFEE)
        cancelTipLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(cancelTipLab)
        
        cancelLab = UILabel()
        cancelLab.text = "5"
        cancelLab.textColor = .white
        cancelLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(cancelLab)
        
        let transTipLab = UILabel()
        transTipLab.text = "已转单"
        transTipLab.textColor = UIColor.hexColor(hexValue: 0xE0FFEE)
        transTipLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(transTipLab)
        
        transLab = UILabel()
        transLab.text = "3"
        transLab.textColor = .white
        transLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(transLab)

        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0x7FE0AA)
        contentView.addSubview(line)
        bgImgV.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).offset(20)
            make.bottom.equalTo(contentView).inset(20)
        }
        
        incomeTipLab.snp.makeConstraints { make in
            make.left.equalTo(bgImgV).offset(15)
            make.top.equalTo(bgImgV).offset(20)
        }
        
        incomeLab.snp.makeConstraints { make in
            make.left.equalTo(incomeTipLab)
            make.top.equalTo(incomeTipLab.snp.bottom).offset(5)
        }
        detailLab.snp.makeConstraints { make in
            make.left.equalTo(incomeTipLab)
            make.top.equalTo(incomeLab.snp.bottom).offset(10)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(bgImgV).inset(15)
            make.top.equalTo(detailLab.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        doneTipLab.snp.makeConstraints { make in
            make.left.equalTo(bgImgV).offset(33)
            make.top.equalTo(line).offset(15)
        }
        doneLab.snp.makeConstraints { make in
            make.left.equalTo(doneTipLab)
            make.top.equalTo(doneTipLab.snp.bottom).offset(5)
        }
        
        cancelTipLab.snp.makeConstraints { make in
            make.centerX.equalTo(bgImgV)
            make.top.equalTo(doneTipLab)
        }
        cancelLab.snp.makeConstraints { make in
            make.left.equalTo(cancelTipLab)
            make.top.equalTo(doneLab)
        }
        
        transTipLab.snp.makeConstraints { make in
            make.right.equalTo(bgImgV).offset(-33)
            make.top.equalTo(doneTipLab)
        }
        transLab.snp.makeConstraints { make in
            make.left.equalTo(transTipLab)
            make.top.equalTo(doneLab)
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

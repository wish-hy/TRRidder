//
//  TROrderDetailResultTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TROrderDetailResultTableViewCell: UITableViewCell {

    var timeLab : UILabel!
    var detailLab : UILabel!
    var stateLab : UILabel!
    var arrowImgV : UIImageView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        timeLab = UILabel()
        timeLab.text = "今日\n19:00"
        timeLab.numberOfLines = 0
        timeLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        timeLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(timeLab)
        
        detailLab = UILabel()
        detailLab.text = "15分钟≤抢单后，骑手取消"
        detailLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        detailLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(detailLab)
        
        stateLab = UILabel()
        stateLab.text = "未执行"
        stateLab.backgroundColor = UIColor.hexColor(hexValue: 0x23B1F5)
        stateLab.layer.cornerRadius = 4
        stateLab.textAlignment = .center
        stateLab.layer.masksToBounds = true
        stateLab.textColor = .white
        stateLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(stateLab)
        
        arrowImgV = UIImageView(image: UIImage(named: "advance_gray"))
        contentView.addSubview(arrowImgV)
        
        timeLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
            
        }
        detailLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(timeLab.snp.right).offset(15)
//            make.right.equalTo(stateLab.snp.left).offset(-10)
        }
        
        arrowImgV.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.right.equalTo(contentView).offset(-15)
            make.centerY.equalTo(self.contentView)
        }
        
        stateLab.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(50)
            make.centerY.equalTo(arrowImgV)
            make.right.equalTo(arrowImgV.snp.left).offset(-5)
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

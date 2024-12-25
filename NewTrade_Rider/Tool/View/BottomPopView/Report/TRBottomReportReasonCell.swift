//
//  TRBottomReportReasonCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRBottomReportReasonCell: UITableViewCell {

    var reasonLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        
        let pointLab = UILabel()
        pointLab.text = "*"
        pointLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        pointLab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(pointLab)
        
        let nameLab = UILabel()
        nameLab.text = "异常原因"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(nameLab)

        
        reasonLab = UILabel()
        reasonLab.text = "途中车辆故障"
        reasonLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        reasonLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(reasonLab)
        
        let arrowImgV = UIImageView()
        arrowImgV.image = UIImage(named: "advance_gray")
        contentView.addSubview(arrowImgV)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        pointLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(pointLab.snp.right).offset(0)
        }
        
        reasonLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-32)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
        arrowImgV.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.right.equalTo(contentView).offset(-16)
            make.centerY.equalTo(contentView)
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

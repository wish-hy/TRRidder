//
//  TRContactBottomTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit
import RxSwift
import RxCocoa
class TRContactBottomTableViewCell: UITableViewCell {
    var iconImgV : UIImageView!
    var nameLab : UILabel!
    var desLab : UILabel!
    
    var actionBtn : UIButton!
    
    var line : UIView!
    
    var tipImgV : UIImageView!
    var tipLab : UILabel!
    
    var bag : DisposeBag = DisposeBag()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = UIColor.white
        setupView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    private func setupView(){
        
        iconImgV = UIImageView()
        iconImgV.image = UIImage(named: "home_phone")
        contentView.addSubview(iconImgV)
        
        nameLab = UILabel()
        nameLab.text = "拨打电话"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x97989A )
        nameLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(nameLab)
        
        desLab = UILabel()
        desLab.text = "139 3070 8868"
        desLab.textColor = UIColor.hexColor(hexValue: 0x141414 )
        desLab.font = UIFont.trBoldFont(fontSize: 14)
        contentView.addSubview(desLab)
        
        //隐藏
        actionBtn = UIButton()
        actionBtn.isHidden = true
        actionBtn.setTitle("发短信", for: .normal)
        actionBtn.setImage(UIImage(named: "information"), for: .normal)
        actionBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A), for: .normal)
        actionBtn.titleLabel?.font = UIFont.trFont(fontSize: 14)
        actionBtn.layer.cornerRadius = 5
        actionBtn.layer.masksToBounds = true
        actionBtn.layer.borderWidth = 1
        actionBtn.layer.borderColor = UIColor.hexColor(hexValue: 0x97989A).cgColor
        contentView.addSubview(actionBtn)
        
        tipImgV = UIImageView(image: UIImage(named: "pop_tip"))
        contentView.addSubview(tipImgV)
        tipLab = TRFactory.labelWith(font: .trMediumFont(18), text: "请忽略语音提示，\n无需输入分机号！", textColor: .red, superView: contentView)
        tipLab.numberOfLines = 0
        
        line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
        iconImgV.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(12)
            make.width.height.equalTo(24)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(iconImgV.snp.right).offset(4)
            make.top.equalTo(iconImgV)
        }
        desLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom).offset(3)
        }
        actionBtn.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(27)
            make.height.equalTo(27)
            make.width.equalTo(77)
            make.centerY.equalTo(contentView)
        }
        tipImgV.snp.makeConstraints { make in
            make.right.equalTo(tipLab.snp.left).offset(-4)
            make.height.equalTo(18)
            make.width.equalTo(18)
            make.centerY.equalTo(contentView)
        }
        tipLab.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(27)
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

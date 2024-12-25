//
//  TRHomeBeginSetTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit

class TRHomeBeginSetTableViewCell1: UITableViewCell {
    
    var titleLab : UILabel!
    var carImgV : UIImageView!
    var iconImgV : UIImageView!
    var codeLab : UILabel!
    var nameLab : UILabel!
    
    var setModel : TRUserModel? {
        didSet {
            guard let setModel = setModel else { return }
            carImgV.sd_setImage(with: URL.init(string: setModel.iconUrl), placeholderImage: UIImage(named: "electromobile"), context: nil)
            codeLab.text = setModel.numberplate
            nameLab.text = setModel.codeName
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "开工车辆"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        carImgV = UIImageView()
        carImgV.image = UIImage(named: "electromobile")
        contentView.addSubview(carImgV)
        
        iconImgV = UIImageView()
        iconImgV.image = UIImage(named: "ew energy")
        contentView.addSubview(iconImgV)
        
        codeLab = UILabel()
        codeLab.text = "深A·66666"
        codeLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        codeLab.font = UIFont.trFont(fontSize: 20)
        contentView.addSubview(codeLab)
        
        nameLab = UILabel()
        nameLab.text = "电动车"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        nameLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(nameLab)
        
        let avdImgV = UIImageView(image: UIImage(named: "advance_gray"))
        contentView.addSubview(avdImgV)
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(15)

        }
        carImgV.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.width.height.equalTo(50)
            make.bottom.equalTo(contentView).inset(15)
            
        }
        iconImgV.snp.makeConstraints { make in
            make.left.equalTo(carImgV.snp.right).offset(10)
            make.top.equalTo(carImgV)
            make.height.width.equalTo(22)
        }
        codeLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgV)
            make.left.equalTo(iconImgV.snp.right).offset(2)
            
        }
        nameLab.snp.makeConstraints { make in
            make.bottom.equalTo(carImgV).inset(2)
            make.left.equalTo(iconImgV)
        }
        avdImgV.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(8)
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

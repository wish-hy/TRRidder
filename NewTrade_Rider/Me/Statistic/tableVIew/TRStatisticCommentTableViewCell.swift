//
//  TRStatisticCommentTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStatisticCommentTableViewCell: UITableViewCell {
    var guestView : TRStatisticInfoView!
    var shopperVie : TRStatisticInfoView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupView()
    }
    private func setupView(){
        let guestBgView = UIView()
        guestBgView.layer.cornerRadius = 13
        guestBgView.layer.masksToBounds = true
        guestBgView.backgroundColor = .white
        contentView.addSubview(guestBgView)
        
        let guestTipView = UIView()
        guestTipView.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        contentView.addSubview(guestTipView)
        
        let shopBgView = UIView()
        shopBgView.layer.cornerRadius = 13
        shopBgView.layer.masksToBounds = true
        shopBgView.backgroundColor = .white
        contentView.addSubview(shopBgView)
        
        let shopTipView = UIView()
        shopTipView.backgroundColor = UIColor.hexColor(hexValue: 0xFA651F)
        contentView.addSubview(shopTipView)
        
        guestView = TRStatisticInfoView(frame: .zero)
        guestView.subTheme1()
        contentView.addSubview(guestView)

        shopperVie = TRStatisticInfoView(frame: .zero)
        shopperVie.subTheme2()
        contentView.addSubview(shopperVie)
        
        guestBgView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(0)
            make.right.equalTo(contentView.snp.centerX).inset(8)
            make.bottom.equalTo(contentView).inset(10)
        }
        guestTipView.snp.makeConstraints { make in
            make.left.equalTo(guestBgView).offset(5)
            make.top.equalTo(guestBgView).offset(15)
            make.width.equalTo(3)
            make.height.equalTo(15)
        }
        
        shopBgView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.centerX).offset(8)
            make.top.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).inset(15)
            make.bottom.equalTo(guestBgView)
        }
        shopTipView.snp.makeConstraints { make in
            make.left.equalTo(shopBgView).offset(5)
            make.top.equalTo(shopBgView).offset(15)
            make.width.equalTo(3)
            make.height.equalTo(15)
        }
        
        guestView.snp.makeConstraints { make in
            make.left.equalTo(guestTipView.snp.right).offset(5)
            make.top.equalTo(guestTipView)
            make.right.equalTo(guestBgView)
            make.bottom.equalTo(guestBgView)
        }
        
        shopperVie.snp.makeConstraints { make in
            make.left.equalTo(shopTipView.snp.right).offset(5)
            make.top.equalTo(shopTipView)
            make.right.equalTo(shopBgView)
            make.bottom.equalTo(shopBgView)
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

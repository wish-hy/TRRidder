//
//  TRRiderReviewImg_2Cell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderReviewImgCell: UITableViewCell {
    var leftImgV : UIImageView!
    var rightImgV : UIImageView!
    
    private var leftView : UIView!
    var rightView : UIView!
    
    var type : Int = 1 { // 1 有背景 0 无背景
        didSet {
            if type == 0 {
                leftView.layer.borderColor = UIColor.hexColor(hexValue: 0xffffff).cgColor
                rightView.layer.borderColor = UIColor.hexColor(hexValue: 0xffffff).cgColor

                leftImgV.snp.remakeConstraints { make in
                    make.left.right.top.bottom.equalTo(leftView).inset(0)
                }
                rightImgV.snp.remakeConstraints { make in
                    make.left.right.top.bottom.equalTo(rightView).inset(0)

                }
            } else {
                leftView.layer.borderColor = UIColor.hexColor(hexValue: 0xE5E7E7).cgColor
                rightView.layer.borderColor = UIColor.hexColor(hexValue: 0xE5E7E7).cgColor

                leftImgV.snp.remakeConstraints { make in
                    make.left.right.top.bottom.equalTo(leftView).inset(6)
                }
                rightImgV.snp.remakeConstraints { make in
                    make.left.right.top.bottom.equalTo(rightView).inset(6)

                }
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        leftView = UIView()
        leftView.layer.borderWidth = 1
        leftView.layer.borderColor = UIColor.hexColor(hexValue: 0xE5E7E7).cgColor
        leftView.layer.cornerRadius = 8
        leftView.layer.masksToBounds = true
        leftView.clipsToBounds = true
        leftView.backgroundColor = .white
        contentView.addSubview(leftView)
        
        rightView = UIView()
        rightView.layer.borderWidth = 1
        rightView.layer.borderColor = UIColor.hexColor(hexValue: 0xE5E7E7).cgColor
        rightView.layer.cornerRadius = 8
        rightView.layer.masksToBounds = true
        rightView.clipsToBounds = true
        rightView.backgroundColor = .white
        contentView.addSubview(rightView)
        
        leftImgV = TRFactory.imageViewWith(image: UIImage(named: "id_card_front"), mode: .scaleAspectFill, superView: leftView)
        
        rightImgV = TRFactory.imageViewWith(image: UIImage(named: "id_card_back"), mode: .scaleAspectFill, superView: rightView)
        
        leftView.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(15)
            make.right.equalTo(contentView.snp.centerX).offset(-6.5)
        }
        rightView.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(leftView)
            make.left.equalTo(contentView.snp.centerX).offset(6.5)
        }
        
        leftImgV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(leftView).inset(6)
        }
        rightImgV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(rightView).inset(6)

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

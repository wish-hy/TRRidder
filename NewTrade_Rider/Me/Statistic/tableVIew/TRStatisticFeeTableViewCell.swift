//
//  TRStatisticFeeTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStatisticFeeTableViewCell: UITableViewCell {
    
    var bgView : UIView!
    var deliveryView : TRStatisticFeeView!
    var punishView : TRStatisticFeeView!
    var feeView : TRStatisticFeeView!
    var transView : TRStatisticFeeView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
 
    private func setupView(){
//        let bottomView = UIView()
//        bottomView.backgroundColor = UIColor.hexColor(hexValue: 0xF7F9FA)
//        contentView.addSubview(bottomView)
        
        bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 13
        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
        
        deliveryView = TRStatisticFeeView(frame: .zero)
        deliveryView.titleLab.text = "配送费"
        deliveryView.iconImgV.image = UIImage(named: "statistic_fee")
        contentView.addSubview(deliveryView)

        punishView = TRStatisticFeeView(frame: .zero)
        punishView.titleLab.text = "惩罚"
        punishView.iconImgV.image = UIImage(named: "statistic_chengfa")
        contentView.addSubview(punishView)

        feeView = TRStatisticFeeView(frame: .zero)
        feeView.titleLab.text = "打赏"
        feeView.iconImgV.image = UIImage(named: "statistic_jiangli")
        contentView.addSubview(feeView)

        transView = TRStatisticFeeView(frame: .zero)
        transView.titleLab.text = "转单"
        transView.iconImgV.image = UIImage(named: "statistic_trans")
        contentView.addSubview(transView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(15)
        }
        
//        bottomView.snp.makeConstraints { make in
//            make.left.right.equalTo(contentView)
//            make.bottom.equalTo(contentView).inset(15)
//            make.height.equalTo(97 - tmH)
//        }
        
        deliveryView.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(30)
            make.top.equalTo(bgView).offset(20)
           
            make.height.equalTo(60)
            make.width.equalTo(100)
        }
        punishView.snp.makeConstraints { make in
            make.top.equalTo(deliveryView)
            make.right.equalTo(bgView).offset(-30)
            make.height.equalTo(deliveryView)
            make.width.equalTo(deliveryView)

        }
        
        feeView.snp.makeConstraints { make in
            make.left.equalTo(deliveryView)
            make.top.equalTo(deliveryView.snp.bottom).offset(30)
            make.right.equalTo(deliveryView)
            make.height.equalTo(deliveryView)
        }
        transView.snp.makeConstraints { make in
            make.left.equalTo(punishView)
            make.top.equalTo(feeView)
            make.right.equalTo(punishView)
            make.height.equalTo(deliveryView)
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

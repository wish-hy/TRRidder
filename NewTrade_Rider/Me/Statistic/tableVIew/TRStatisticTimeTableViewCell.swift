//
//  TRStatisticTimeTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStatisticTimeTableViewCell: UITableViewCell {

    var tipView : TRStatisticInfoTipView!
    
    var rateView : TRStatisticInfoView!
    var avgView : TRStatisticInfoView!
    var distanceView : TRStatisticInfoView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    

    
    
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 13
        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
        
        tipView = TRStatisticInfoTipView(frame: .zero)
        tipView.tipView.backgroundColor = UIColor.hexColor(hexValue: 0x23B1F5)
        tipView.titleLab.text = "配送时长"
        bgView.addSubview(tipView)
        
        rateView = TRStatisticInfoView(frame: .zero)
        rateView.titleLab.text = "配送准时率"
        rateView.valueLab.text = "--%"
        rateView.subTheme3()
        bgView.addSubview(rateView)
        
        avgView = TRStatisticInfoView(frame: .zero)
        avgView.titleLab.text = "平均送达时长"
        avgView.valueLab.text = "--"
        avgView.subTheme3()
        bgView.addSubview(avgView)
        
        distanceView = TRStatisticInfoView(frame: .zero)
        distanceView.titleLab.text = "送货里程"
        distanceView.valueLab.text = "--km"
        distanceView.subTheme3()
        bgView.addSubview(distanceView)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(10)
        }
        tipView.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(5)
            make.top.equalTo(bgView).offset(18)
            make.height.equalTo(25)
        }
        rateView.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(15)
            make.top.equalTo(tipView.snp.bottom).offset(15)
            make.bottom.equalTo(bgView).offset(15)
            make.width.equalTo(80)
//            make.width.equalTo(T##other: ConstraintRelatableTarget##ConstraintRelatableTarge)
        }
        avgView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(rateView)
            make.height.equalTo(rateView)
            make.width.equalTo(rateView)
        }
        
        distanceView.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(15)
            make.top.equalTo(rateView)
            make.height.equalTo(rateView)
            make.width.equalTo(rateView)
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

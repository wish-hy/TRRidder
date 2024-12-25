//
//  TRHomeBeginTableViewCell1.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit

class TRHomeBeginTableViewCell1: UITableViewCell {
    var bgImgV : UIImageView!
    
    var incomeLab : UILabel!
    var scoreLab : UILabel!
    var numLab : UILabel!
    var timeLab : UILabel!
    var model : TRRiderStaticsModel? {
        didSet {
            guard let model = model else { return }
//            incomeLab.text = model.totalActualIncome
        }
    }
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        setupViews()
    }
    
    private func setupViews(){
        bgImgV = TRFactory.imageViewWith(image: UIImage(named: "card bg"), mode: .scaleAspectFill, superView: contentView)
        
        
        let bgImagV1 = UIImageView(image: UIImage(named: "card bg"))
        let bgImagV2 = UIImageView(image: UIImage(named: "white"))
        let bgImagV3 = UIImageView(image: UIImage(named: "illutr"))
        contentView.addSubview(bgImagV1)
        contentView.addSubview(bgImagV2)
        contentView.addSubview(bgImagV3)
        
        let infoLab = UILabel()
        infoLab.text = "资料卡"
        infoLab.textColor = .white
        infoLab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(infoLab)
        
        let incomeTipLab = UILabel()
        incomeTipLab.text = "昨日收入(元)"
        incomeTipLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        incomeTipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(incomeTipLab)
        
        incomeLab = UILabel()
        incomeLab.text = "--"
        incomeLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        incomeLab.font = UIFont.trBoldFont(fontSize: 32)
        contentView.addSubview(incomeLab)
        
        let scoreTipLab = UILabel()
        scoreTipLab.text = "评分"
        scoreTipLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        scoreTipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(scoreTipLab)
        
        scoreLab = UILabel()
        scoreLab.text = "--%"
        scoreLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        scoreLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(scoreLab)
        
        let numTipLab = UILabel()
        numTipLab.text = "昨日接单"
        numTipLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        numTipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(numTipLab)
        
        numLab = UILabel()
        numLab.text = "0"
        numLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        numLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(numLab)
        let numUnitLab = UILabel()
        numUnitLab.text = "单"
        numUnitLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        numUnitLab.font = UIFont.trBoldFont(fontSize: 12)
        contentView.addSubview(numUnitLab)
        
        let timeTipLab = UILabel()
        timeTipLab.text = "在线时长"
        timeTipLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        timeTipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(timeTipLab)
        
        timeLab = UILabel()
        timeLab.text = "0"
        timeLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        timeLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(timeLab)
        let timeUnitLab = UILabel()
        timeUnitLab.text = "小时"
        timeUnitLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        timeUnitLab.font = UIFont.trBoldFont(fontSize: 12)
        contentView.addSubview(timeUnitLab)
        
        bgImgV.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).inset(8)
            make.height.equalTo(88)
            make.bottom.equalTo(contentView).inset(16)
        }
        
        infoLab.snp.makeConstraints { make in
            make.left.equalTo(bgImagV1).offset(15)
            make.top.equalTo(bgImagV1).offset(9)
        }
        incomeTipLab.snp.makeConstraints { make in
            make.left.equalTo(bgImagV2).offset(9)
            make.top.equalTo(bgImagV2).offset(15)
        }
        incomeLab.snp.makeConstraints { make in
            make.left.equalTo(bgImagV2).offset(9)
            make.top.equalTo(incomeTipLab.snp.bottom).offset(5)
        }
        
        scoreTipLab.snp.makeConstraints { make in
            make.left.equalTo(bgImagV2).offset(15)
            make.top.equalTo(incomeLab.snp.bottom).offset(18)
        }
        scoreLab.snp.makeConstraints { make in
            make.left.equalTo(scoreTipLab)
            make.top.equalTo(scoreTipLab.snp.bottom).offset(3)
        }
        
        numTipLab.snp.makeConstraints { make in
            make.centerX.equalTo(bgImagV2).offset(-20)
            make.top.equalTo(scoreTipLab)
        }
        numLab.snp.makeConstraints { make in
            make.left.equalTo(numTipLab)
            make.top.equalTo(scoreLab)
        }
        numUnitLab.snp.makeConstraints { make in
            make.bottom.equalTo(numLab).inset(3)
            make.left.equalTo(numLab.snp.right)
        }
        
        timeTipLab.snp.makeConstraints { make in
            make.right.equalTo(bgImagV2).inset(40)
            make.top.equalTo(scoreTipLab)
        }
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(timeTipLab)
            make.top.equalTo(scoreLab)
        }
        timeUnitLab.snp.makeConstraints { make in
            make.bottom.equalTo(timeLab).inset(3)
            make.left.equalTo(timeLab.snp.right)
        }
    }
    
    private func old(){
        let bgImagV1 = UIImageView(image: UIImage(named: "card bg"))
        let bgImagV2 = UIImageView(image: UIImage(named: "white"))
        let bgImagV3 = UIImageView(image: UIImage(named: "illutr"))
        contentView.addSubview(bgImagV1)
        contentView.addSubview(bgImagV2)
        contentView.addSubview(bgImagV3)
        
        let infoLab = UILabel()
        infoLab.text = "资料卡"
        infoLab.textColor = .white
        infoLab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(infoLab)
        
        let incomeTipLab = UILabel()
        incomeTipLab.text = "昨日收入(元)"
        incomeTipLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        incomeTipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(incomeTipLab)
        
        incomeLab = UILabel()
        incomeLab.text = "--"
        incomeLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        incomeLab.font = UIFont.trBoldFont(fontSize: 32)
        contentView.addSubview(incomeLab)
        
        let scoreTipLab = UILabel()
        scoreTipLab.text = "评分"
        scoreTipLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        scoreTipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(scoreTipLab)
        
        scoreLab = UILabel()
        scoreLab.text = "--%"
        scoreLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        scoreLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(scoreLab)
        
        let numTipLab = UILabel()
        numTipLab.text = "昨日接单"
        numTipLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        numTipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(numTipLab)
        
        numLab = UILabel()
        numLab.text = "0"
        numLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        numLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(numLab)
        let numUnitLab = UILabel()
        numUnitLab.text = "单"
        numUnitLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        numUnitLab.font = UIFont.trBoldFont(fontSize: 12)
        contentView.addSubview(numUnitLab)
        
        let timeTipLab = UILabel()
        timeTipLab.text = "在线时长"
        timeTipLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        timeTipLab.font = UIFont.trFont(fontSize: 12)
        contentView.addSubview(timeTipLab)
        
        timeLab = UILabel()
        timeLab.text = "0"
        timeLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        timeLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(timeLab)
        let timeUnitLab = UILabel()
        timeUnitLab.text = "小时"
        timeUnitLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        timeUnitLab.font = UIFont.trBoldFont(fontSize: 12)
        contentView.addSubview(timeUnitLab)
        
        
        bgImagV1.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(15)
            make.left.right.equalTo(contentView)
        }
        bgImagV2.snp.makeConstraints { make in
            make.top.equalTo(bgImagV1).inset(40)
            make.left.right.bottom.equalTo(bgImagV1).inset(5)
        }
        bgImagV3.snp.makeConstraints { make in
            make.right.top.equalTo(bgImagV1)
            make.height.width.equalTo(140)
        }
        infoLab.snp.makeConstraints { make in
            make.left.equalTo(bgImagV1).offset(15)
            make.top.equalTo(bgImagV1).offset(9)
        }
        incomeTipLab.snp.makeConstraints { make in
            make.left.equalTo(bgImagV2).offset(9)
            make.top.equalTo(bgImagV2).offset(15)
        }
        incomeLab.snp.makeConstraints { make in
            make.left.equalTo(bgImagV2).offset(9)
            make.top.equalTo(incomeTipLab.snp.bottom).offset(5)
        }
        
        scoreTipLab.snp.makeConstraints { make in
            make.left.equalTo(bgImagV2).offset(15)
            make.top.equalTo(incomeLab.snp.bottom).offset(18)
        }
        scoreLab.snp.makeConstraints { make in
            make.left.equalTo(scoreTipLab)
            make.top.equalTo(scoreTipLab.snp.bottom).offset(3)
        }
        
        numTipLab.snp.makeConstraints { make in
            make.centerX.equalTo(bgImagV2).offset(-20)
            make.top.equalTo(scoreTipLab)
        }
        numLab.snp.makeConstraints { make in
            make.left.equalTo(numTipLab)
            make.top.equalTo(scoreLab)
        }
        numUnitLab.snp.makeConstraints { make in
            make.bottom.equalTo(numLab).inset(3)
            make.left.equalTo(numLab.snp.right)
        }
        
        timeTipLab.snp.makeConstraints { make in
            make.right.equalTo(bgImagV2).inset(40)
            make.top.equalTo(scoreTipLab)
        }
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(timeTipLab)
            make.top.equalTo(scoreLab)
        }
        timeUnitLab.snp.makeConstraints { make in
            make.bottom.equalTo(timeLab).inset(3)
            make.left.equalTo(timeLab.snp.right)
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

//
//  TRHomeTableViewCell4.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit
import RxCocoa
import RxSwift
class TRHomeBeginTableViewCell4: UITableViewCell {
    
    var block : Int_Block?
    
    let bag = DisposeBag()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        
        let bgImgV = UIImageView()
        bgImgV.image = UIImage(named: "map card")
        contentView.addSubview(bgImgV)
        
        let infoLab = UILabel()
        infoLab.text = "点击开工，马上开始接单"
        infoLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        infoLab.font = UIFont.trFont(fontSize: 17)
        contentView.addSubview(infoLab)
        
        let setBtn = UIButton()
        setBtn.setImage(UIImage(named: "jiedan setting"), for: .normal)
        contentView.addSubview(setBtn)
        let setLab = UILabel()
        setLab.text = "接单设置"
        setLab.font = UIFont.trFont(fontSize: 12)
        setLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        contentView.addSubview(setLab)
        
        let noticeLab = UILabel()
        noticeLab.text = "请遵守交通规则，注意出行安全"
        noticeLab.textColor = UIColor.hexColor(hexValue: 0xFCBD9F)
        noticeLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(noticeLab)
        
        let beginBtn = UIButton();
        contentView.addSubview(beginBtn)
        let beginLab = UILabel()
        beginLab.text = "开工"
        beginLab.textColor = .white
        beginLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(beginLab)

        bgImgV.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(contentView)
        }
        infoLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(25)
            
        }
        setBtn.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(13)
            make.right.equalTo(contentView).inset(27)
            make.width.height.equalTo(24)
        }
        setLab.snp.makeConstraints { make in
            make.centerX.equalTo(setBtn)
            make.top.equalTo(setBtn.snp.bottom).offset(2)
        }
        noticeLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(bgImgV).offset(77)
            
        }
        beginBtn.snp.makeConstraints { make in
            make.top.equalTo(noticeLab.snp.bottom).offset(30)
            make.left.right.equalTo(contentView).inset(15)
            make.height.equalTo(46)
            make.bottom.equalTo(contentView).inset(15)
        }
        beginLab.snp.makeConstraints { make in
            make.center.equalTo(beginBtn)
        }
        
        contentView.layoutIfNeeded()
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.32, blue: 0.36, alpha: 1).cgColor, UIColor(red: 1, green: 0.26, blue: 0.26, alpha: 1).cgColor, UIColor(red: 0.96, green: 0.14, blue: 0.16, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1, 1]
        bgLayer1.frame = CGRect(x: 0, y: 0, width: Screen_Width - 15, height: 46)
        bgLayer1.startPoint = CGPoint(x: 0.02, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        beginBtn.layer.masksToBounds = true
        beginBtn.layer.cornerRadius = 23;
        beginBtn.layer.addSublayer(bgLayer1)
        
        setBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            if block != nil {
                block!(1)
            }
        }).disposed(by: bag)
        beginBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            if block != nil {
                block!(2)
            }
        }).disposed(by: bag)
        
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

//
//  TRMineInfoHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit
import RxSwift
import RxCocoa
class TRMineInfoHeader: UICollectionReusableView {
    
    var contentView : UIView!
    var userIcon : UIImageView!
    var userNameLab : UILabel!
    var userPhoneLab : UILabel!
    
    var orderBtn : TRMineHeaderButton!
    var incomeBtn : TRMineHeaderButton!
    
    var bag = DisposeBag()
    var model : TRUserModel? {
        didSet {
            guard let model = model else { return }
            // rider_head_def
            userIcon.sd_setImage(with: URL.init(string: model.getRealHeadUrl()), placeholderImage: UIImage(named: "rider_head_def"))
            userNameLab.text = model.getRealName()
            userPhoneLab.text = model.phone
        }
    }
    var block : Int_Block?
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    private func setView(){
        contentView = UIView()
        self.addSubview(contentView)
        let bgImgV = UIImageView()
//        bgImgV.contentMode = .scaleAspectFit
        bgImgV.image = UIImage(named: "me_header_bg")
//        bgImgV.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer()
//        bgImgV.addGestureRecognizer(tap)
//        tap.rx.event.debug("Tap").subscribe(onNext:{[weak self] _ in
//            guard let self  = self  else { return }
//            if block != nil {
//                block!(1)
//            }
//        }).disposed(by: bag)
        contentView.addSubview(bgImgV)
        
        userIcon = UIImageView()
        userIcon.contentMode = .scaleAspectFill
        
        userIcon.trCorner(29)
        userIcon.clipsToBounds = true
        userIcon.image = UIImage(named: "test")
        contentView.addSubview(userIcon)
        
        userNameLab = UILabel()
        userNameLab.text = "刘华健"
        userNameLab.textColor = .white
        userNameLab.font = UIFont.trBoldFont(fontSize: 23)
        contentView.addSubview(userNameLab)
        
        userPhoneLab = UILabel()
        userPhoneLab.text = "138 5574 6500"
        userPhoneLab.textColor = UIColor.hexColor(hexValue: 0xE2FFF0)
        userPhoneLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(userPhoneLab)
        
        let arrowImgV = UIImageView()
        arrowImgV.image = UIImage(named: "arrow_white")
        contentView.addSubview(arrowImgV)
        
        let whiteBgView = UIImageView()
        whiteBgView.isUserInteractionEnabled = true
        whiteBgView.image = UIImage(named: "mine_header_order_bg")
        whiteBgView.layer.cornerRadius = 13
        whiteBgView.layer.masksToBounds = true
        contentView.addSubview(whiteBgView)
        
        orderBtn = TRMineHeaderButton(frame: .zero)
        orderBtn.numLab.text = "0"
        orderBtn.tipLab.text = "今日完成订单(单)"
        contentView.addSubview(orderBtn)
        
        incomeBtn = TRMineHeaderButton(frame: .zero)
        incomeBtn.numLab.text = "0"
        incomeBtn.tipLab.text = "今日预估收入(元)"
        incomeBtn.iconImgV.image = UIImage(named: "func_today_income")
        contentView.addSubview(incomeBtn)
        
//        orderBtn.rx.tap.subscribe(onNext: {[weak self] in
//            guard let self  = self  else { return }
//            if block != nil {
//                block!(2)
//            }
//        }).disposed(by: bag)
//        incomeBtn.rx.tap.subscribe(onNext: {[weak self] in
//            guard let self  = self  else { return }
//            if block != nil {
//                block!(3)
//            }
//        }).disposed(by: bag)
        let spadLine = UIView()
        spadLine.backgroundColor = .bgColor()
        contentView.addSubview(spadLine)
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(self).inset(15)
        }
        
        whiteBgView.snp.makeConstraints { make in
            make.bottom.equalTo(spadLine.snp.top).offset(0)
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(110)
        }
        
        userIcon.snp.makeConstraints { make in
            make.width.height.equalTo(58)
            make.left.equalTo(self).offset(13)
            make.bottom.equalTo(whiteBgView.snp.top).offset(-28)
        }
        userNameLab.snp.makeConstraints { make in
            make.top.equalTo(userIcon).offset(2)
            make.left.equalTo(userIcon.snp.right).offset(9)
            
        }
        userPhoneLab.snp.makeConstraints { make in
            make.left.equalTo(userNameLab)
            make.bottom.equalTo(userIcon)
        }
        
        arrowImgV.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-9)
            make.width.height.equalTo(24)
            make.centerY.equalTo(userIcon)
        }
        
        orderBtn.snp.makeConstraints { make in
            make.top.equalTo(whiteBgView).offset(20)
            make.left.equalTo(whiteBgView).offset(23)
        }
        incomeBtn.snp.makeConstraints { make in
            make.top.equalTo(whiteBgView).offset(20)
            make.right.equalTo(whiteBgView).inset(23)
        }
        
        spadLine.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(15)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
}

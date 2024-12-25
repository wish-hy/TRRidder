//
//  TRPickupView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit
//确认取货弹窗

import RxCocoa
import RxSwift
class TRPickupView: TRPopBaseView {
    var titleLab : UILabel!
    var tipLab : UILabel!
    var cancelBtn : UIButton!
    var sureBtn : UIButton!
    let bag = DisposeBag()
    
    var block : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        let bg = UIImageView()
        bg.isUserInteractionEnabled = true
        bg.image = UIImage(named: "pop_bg")
        bg.contentMode = .scaleAspectFill
        contentView.addSubview(bg)
        
        titleLab = UILabel()
        titleLab.text = "是否确认已取到货"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 20)
        bg.addSubview(titleLab)
        
        tipLab = UILabel()
        tipLab.text = ""
        tipLab.numberOfLines = 0
        tipLab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        tipLab.font = UIFont.trFont(fontSize: 14)
        bg.addSubview(tipLab)
        
        cancelBtn = UIButton()
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.masksToBounds = true
        cancelBtn.setTitle("还没有", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        bg.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        sureBtn.layer.cornerRadius = 10
        sureBtn.layer.masksToBounds = true
        sureBtn.setTitle("确认取货", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        bg.addSubview(sureBtn)
        
        bg.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(0)
            make.height.equalTo(172)
//            make.centerY.equalTo(contentView)
            make.top.bottom.equalTo(contentView)
        }
        
        titleLab.snp.makeConstraints { make in
            make.centerX.equalTo(bg)
            make.top.equalTo(bg).offset(30)
        }
        tipLab.snp.makeConstraints { make in
            make.left.right.equalTo(bg).inset(46)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(bg).offset(20)
            make.top.equalTo(tipLab.snp.bottom).offset(40)
            make.bottom.equalTo(bg).offset(-25)
            make.width.equalTo(122)
            make.height.equalTo(44)
        }
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(bg).inset(20)
            make.bottom.equalTo(bg).offset(-25)
            make.width.equalTo(122)
            make.height.equalTo(44)
        }
        sureBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self = self else {return}
            if self.block != nil {
                self.block!(1)
            }
            self.removeFromSuperview()
            
        }).disposed(by: bag)
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
       
            
            self?.removeFromSuperview()
        }).disposed(by: bag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

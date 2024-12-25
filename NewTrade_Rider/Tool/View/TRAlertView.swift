//
//  TRPickupView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

import RxCocoa
import RxSwift
enum TRAlertViewType{
    case normal
    case important
    case colorful
}
class TRAlertView: TRPopBaseView {
    var titleLab : UILabel!
    var tipLab : UILabel!
    var cancelBtn : UIButton!
    var sureBtn : UIButton!
    
    var type : TRAlertViewType = .normal {
        didSet {
            if type == .normal {
                sureBtn.setTitleColor(.lightThemeColor(), for: .normal)
                sureBtn.backgroundColor = .hexColor(hexValue: 0xE1F0FF)
                tipLab.textColor = .lightThemeColor()
            } else if type == .important{
                sureBtn.setTitleColor(.hexColor(hexValue: 0xF54444), for: .normal)
                sureBtn.backgroundColor = .hexColor(hexValue: 0xFFE9E9)
                tipLab.textColor = .hexColor(hexValue: 0xF54444)
            } else if type == .colorful {
                sureBtn.setTitleColor(.hexColor(hexValue: 0xFFFFFF), for: .normal)
                sureBtn.backgroundColor = .hexColor(hexValue: 0xFF7A2D)
                tipLab.textColor = .hexColor(hexValue: 0xFF7A2D)

            }
        }
    }
    let bag = DisposeBag()
    
    var block : Int_Block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        let bg = UIImageView()
        bg.layer.cornerRadius = 12
        bg.layer.masksToBounds = true
        bg.backgroundColor = .white
        contentView.addSubview(bg)
        
        titleLab = UILabel()
        titleLab.text = ""
        titleLab.numberOfLines = 0
        titleLab.textAlignment = .center
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(titleLab)
        
        tipLab = UILabel()
        tipLab.text = ""
        tipLab.numberOfLines = 0
        tipLab.textAlignment = .center
        tipLab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        tipLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(tipLab)
        
        cancelBtn = UIButton()
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.masksToBounds = true
        cancelBtn.setTitle("还没有", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        sureBtn.layer.cornerRadius = 10
        sureBtn.layer.masksToBounds = true
        sureBtn.setTitle("确认取货", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(sureBtn)
        
        bg.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(0)
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
            make.top.equalTo(tipLab.snp.bottom).offset(30)
            make.bottom.equalTo(bg).offset(-30)
            make.width.equalTo(122)
            make.height.equalTo(44)
        }
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(bg).inset(20)
            make.bottom.equalTo(bg).offset(-30)
            make.width.equalTo(122)
            make.height.equalTo(44)
        }
        sureBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            if self.block != nil {
                self.block!(1)
            }
            self.removeFromSuperview()
            
        }).disposed(by: bag)
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            if cancelBlock != nil {
                self.cancelBlock!(0)
            }
            self.removeFromSuperview()
        }).disposed(by: bag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

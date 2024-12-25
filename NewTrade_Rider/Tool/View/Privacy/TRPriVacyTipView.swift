//
//  TRPriVacyTipView.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/4/23.
//

import UIKit
import RxSwift
import RxCocoa
class TRPriVacyTipView: TRPopBaseView {
    var titleLab : UILabel!
    var tipLab : UILabel!
    var cancelBtn : UIButton!
    var sureBtn : UIButton!
    //1 同意协议 2 协议 3 隐私
    var block : Int_Block?
    let bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        let bg = UIView()
        bg.layer.cornerRadius = 13
        bg.layer.masksToBounds = true
        bg.backgroundColor = .white
        contentView.addSubview(bg)
        
        titleLab = UILabel()
        titleLab.text = "个人信息保护指引"
        titleLab.numberOfLines = 0
        titleLab.textAlignment = .center
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(titleLab)
        
        tipLab = UILabel()
        tipLab.text = "我们通过相关政策协议帮助你了解APP提供的服务，及收集、梳理个人信息的方式，使用APP前需要您的同意"
        tipLab.numberOfLines = 0
        tipLab.textAlignment = .left
        tipLab.textColor = .txtColor()
        tipLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(tipLab)
        
        let agreeLab = UILabel()
        agreeLab.textColor = UIColor.hexColor(hexValue: 0xc6c8cb)
        agreeLab.font = .systemFont(ofSize: 14)
        agreeLab.text = "阅读";
        bg.addSubview(agreeLab)
        
        let agreeLab1 = UILabel()
        agreeLab1.textColor = UIColor.hexColor(hexValue: 0xc6c8cb)
        agreeLab1.font = .systemFont(ofSize: 14)
        agreeLab1.text = "和";
        bg.addSubview(agreeLab1)
        
        let xyLab = UILabel()
        xyLab.textColor = UIColor.hexColor(hexValue: 0x3596FB)
        xyLab.font = .systemFont(ofSize: 14)
        xyLab.text = "《用户协议》";
        xyLab.isUserInteractionEnabled = true
        bg.addSubview(xyLab)
        
        let zcLab = UILabel()
        zcLab.textColor = UIColor.hexColor(hexValue: 0x3596FB)
        zcLab.isUserInteractionEnabled = true
        zcLab.font = .systemFont(ofSize: 14)
        zcLab.text = "《隐私政策》";
        bg.addSubview(zcLab)
        
        
        cancelBtn = UIButton()
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.masksToBounds = true
        cancelBtn.setTitle("不同意", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        sureBtn.layer.cornerRadius = 10
        sureBtn.layer.masksToBounds = true
        sureBtn.setTitle("同意", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(sureBtn)

        bg.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.bottom.equalTo(contentView)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(bg).offset(25)
            make.centerX.equalTo(bg)
        }
        tipLab.snp.makeConstraints { make in
            make.left.right.equalTo(bg).inset(16)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
        }
        agreeLab.snp.makeConstraints({ make in
            make.top.equalTo(tipLab.snp.bottom).offset(25)
            make.left.equalTo(bg).offset(16)
        })
        xyLab.snp.makeConstraints({ make in
            make.centerY.equalTo(agreeLab)
            make.left.equalTo(agreeLab.snp.right).offset(0)
            make.height.equalTo(15)
        })
        agreeLab1.snp.makeConstraints({ make in
            make.centerY.equalTo(agreeLab)
            make.left.equalTo(xyLab.snp.right).offset(3)
        })
        zcLab.snp.makeConstraints({ make in
            make.centerY.equalTo(agreeLab)
            make.left.equalTo(agreeLab1.snp.right).offset(0)
            make.height.equalTo(15)
        })
        
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(bg).offset(20)
            make.top.equalTo(agreeLab.snp.bottom).offset(30)
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
            guard let self = self else { return }
            if self.block != nil {
                self.block!(1)
            }
            self.removeFromSuperview()
            
        }).disposed(by: bag)
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self = self else { return }
            SVProgressHUD.showInfo(withStatus: "使用APP请同意相关协议")
        }).disposed(by: bag)
        
        
        let xyGes = UITapGestureRecognizer()
        let zcGes = UITapGestureRecognizer()
        xyLab.addGestureRecognizer(xyGes)
        zcLab.addGestureRecognizer(zcGes)
        xyGes.rx.event.debug("Tap").subscribe(onNext : {[weak self] _ in
            guard let self  = self  else { return }
            if self.block != nil {
                self.block!(2)
            }
            self.removeFromSuperview()
        }).disposed(by: bag)
        zcGes.rx.event.debug("Tap").subscribe(onNext : {[weak self] _ in
            guard let self  = self  else { return }
            if self.block != nil {
                self.block!(3)
            }
            self.removeFromSuperview()
        }).disposed(by: bag)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

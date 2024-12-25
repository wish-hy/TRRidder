//
//  TRHomeStateView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/6.
//

import UIKit
import RxCocoa
import RxSwift
class TRHomeStateView: UIView {
    //0 上线 1 忙碌 2 休息
    var state : Int = 1 {
        didSet{
            if state == 0 {
                stateImgV.image = UIImage(named: "home_state_kg")
                stateLab.text = "开工"
            } else if state == 1{
                stateImgV.image = UIImage(named: "home_state_xx")
                stateLab.text = "收工"
            } else{
                stateImgV.image = UIImage(named: "home_state_ml")
                stateLab.text = "忙碌"
            }
        }
    }
    
    private var stateImgV : UIImageView = UIImageView()
    private var stateLab : UILabel = UILabel()
    private var downArrowImagV : UIImageView = UIImageView()
    private var bgView : UIButton!
    let bag = DisposeBag()
    var block : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    private func setupView(){
      
        bgView = UIButton()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 19
        bgView.layer.masksToBounds = true
        bgView.frame = CGRect(x: 0, y: 0, width: 103, height: 38)
        let borderLayer1 = CALayer()
        borderLayer1.frame = CGRect(x: 0, y: 0, width: 113, height: 38)
        borderLayer1.backgroundColor = UIColor(red: 0.91, green: 1, blue: 0.95, alpha: 1).cgColor
        bgView.layer.addSublayer(borderLayer1)
        let bgLayer1 = CALayer()
        bgLayer1.frame = CGRect(x: 1, y: 1, width: 111, height: 36)
        bgLayer1.backgroundColor = UIColor(red: 0.86, green: 0.98, blue: 0.92, alpha: 1).cgColor
        bgView.layer.addSublayer(bgLayer1)
        self.addSubview(bgView)
        
        
        stateImgV.image = UIImage(named: "home_state_kg")
        self.addSubview(stateImgV)
        
        downArrowImagV.image = UIImage(named: "home_arrow_down")
        self.addSubview(downArrowImagV)
        
        stateLab.text = "开工"
        stateLab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        stateLab.font = UIFont.trFont(fontSize: 16)
        self.addSubview(stateLab)
        stateImgV.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        stateLab.frame = CGRect(x: stateImgV.frame.origin.x + 30, y: 8, width: 40, height: 22)
        downArrowImagV.frame = CGRect(x: stateLab.frame.origin.x + 40 + 0, y: 10, width: 20, height: 20)
//        bgView.snp.makeConstraints { make in
//            make.left.right.bottom.top.equalTo(self)
//        }
//        stateImgV.snp.makeConstraints { make in
//            make.width.height.equalTo(20)
//            make.left.equalTo(bgView).offset(10)
//            make.centerY.equalTo(bgView)
//        }
//        stateLab.snp.makeConstraints { make in
//            make.centerY.equalTo(bgView)
//            make.left.equalTo(stateImgV.snp.right).offset(2)
//        }
//        downArrowImagV.snp.makeConstraints { make in
//            make.centerY.equalTo(bgView)
//            make.left.equalTo(stateLab.snp.right).offset(3)
//        }
        
        stateImgV.isUserInteractionEnabled = true
        stateLab.isUserInteractionEnabled = true
        downArrowImagV.isUserInteractionEnabled = true
        
        let ges1 = UITapGestureRecognizer()
        let ges2 = UITapGestureRecognizer()
        let ges3 = UITapGestureRecognizer()

        stateImgV.addGestureRecognizer(ges1)
        stateLab.addGestureRecognizer(ges2)
        downArrowImagV.addGestureRecognizer(ges3)
        
        ges1.rx.event.debug("Tap").subscribe(onNext : {[weak self]_ in
            guard let self  = self  else { return }
            if(self.block != nil){
                self.block!(1)
            }
        }).disposed(by: bag)
        ges2.rx.event.debug("Tap").subscribe(onNext : {[weak self]_ in
            guard let self  = self else { return  }
            if(self.block != nil){
                self.block!(1)
            }
        }).disposed(by: bag)
        ges3.rx.event.debug("Tap").subscribe(onNext : {[weak self]_ in
            guard let self  = self  else { return }
            if(self.block != nil){
                self.block!(1)
            }
        }).disposed(by: bag)
        bgView.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self else { return  }
            if(self.block != nil){
                self.block!(1)
            }
        }).disposed(by: bag)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

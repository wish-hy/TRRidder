//
//  TRHistoryOrderHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxCocoa
import RxSwift
class TRHistoryOrderHeader: UIView {

    var contentView : UIView!
    
    var line : UIView!
    var todayOrderBtn : TRRightButton!
    var moneyOrderBtn : TRRightButton!
    
    let bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        
        line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        contentView.addSubview(line)
        
        todayOrderBtn = TRRightButton(frame: .zero)
        todayOrderBtn.lab.text = "今日订单"
        todayOrderBtn.lab.textColor = UIColor.hexColor(hexValue: 0x141414)
        todayOrderBtn.lab.font = UIFont.trBoldFont(fontSize: 16)
        todayOrderBtn.imgV.image = UIImage(named: "history_order_down")
        contentView.addSubview(todayOrderBtn)
        
        moneyOrderBtn = TRRightButton(frame: .zero)
        moneyOrderBtn.lab.text = "本月订单"
        moneyOrderBtn.lab.textColor = UIColor.hexColor(hexValue: 0x141414)
        moneyOrderBtn.lab.font = UIFont.trBoldFont(fontSize: 16)
        moneyOrderBtn.imgV.image = UIImage(named: "history_order_down")
        contentView.addSubview(moneyOrderBtn)
        
        todayOrderBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(25)
        }
        
        moneyOrderBtn.snp.makeConstraints { make in
            make.left.equalTo(todayOrderBtn.snp.right).offset(0)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(25)
        }
        
        line.snp.makeConstraints { make in
            make.width.equalTo(62)
            make.height.equalTo(3)
            make.bottom.equalTo(contentView)
            make.centerX.equalTo(todayOrderBtn)
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
        todayOrderBtn.rx.tap.subscribe(onNext:{[weak self] in
            self!.line.snp.remakeConstraints { make in
                make.width.equalTo(62)
                make.height.equalTo(3)
                make.bottom.equalTo(self!.contentView)
                make.centerX.equalTo(self!.todayOrderBtn)
            }
            
            
        }).disposed(by: bag)
        
        moneyOrderBtn.rx.tap.subscribe(onNext:{[weak self] in
            self!.line.snp.remakeConstraints { make in
                make.width.equalTo(62)
                make.height.equalTo(3)
                make.bottom.equalTo(self!.contentView)
                make.centerX.equalTo(self!.moneyOrderBtn)
            }
        }).disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

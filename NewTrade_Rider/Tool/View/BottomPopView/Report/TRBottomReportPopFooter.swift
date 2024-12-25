//
//  TRBottomReportPopFooter.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

import RxCocoa
import RxSwift
class TRBottomReportPopFooter: UITableViewHeaderFooterView {

    var qxddBtn : UIButton!
    var tipLab : UILabel!
    
    var cancelBtn : UIButton!
    var sureBtn : UIButton!
    
    //隐藏取消订单，默认false 不用处理
    var hiddenCancelOrder : Bool = false {
        didSet {
           if hiddenCancelOrder {
               qxddBtn.isHidden = true
               tipLab.isHidden = true
               cancelBtn.snp.remakeConstraints { make in
                   make.left.equalTo(contentView).inset(26)
                   make.top.equalTo(qxddBtn.snp.top)
                   make.height.equalTo(44)
                   make.width.equalTo(152)
               }
            }
        }
    }
    var bag = DisposeBag()
    
    
    var siCancel = false {
        didSet {
            if self.siCancel {
                self.qxddBtn.setImage(UIImage(named: "select"), for: .normal)
            } else {
                self.qxddBtn.setImage(UIImage(named: "uncheck"), for: .normal)

            }
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    private func setupView(){
        contentView.backgroundColor = .white
        qxddBtn = UIButton()
        qxddBtn.setTitle("取消订单", for: .normal)
        qxddBtn.setImage(UIImage(named: "uncheck"), for: .normal)
        qxddBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        qxddBtn.titleLabel?.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(qxddBtn)
        
        tipLab = UILabel()
        tipLab.text = "（取消订单后，可能会接受处罚）"
        tipLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        tipLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(tipLab)
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.masksToBounds = true
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        sureBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        sureBtn.layer.cornerRadius = 10
        sureBtn.layer.masksToBounds = true
        contentView.addSubview(sureBtn)
        
        qxddBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(25)
//            make.width.equalTo(70)
        }
        
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(qxddBtn.snp.right)
            make.centerY.equalTo(qxddBtn)
        }
       
    
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(26)
            make.top.equalTo(qxddBtn.snp.bottom).offset(25)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(26)
            make.top.equalTo(cancelBtn)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
        
//        qxddBtn.rx.tap.subscribe(onNext: {[weak self] in
//            guard let self  = self  else { return }
//            self.siCancel = !self.siCancel
//
//        }).disposed(by: bag)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

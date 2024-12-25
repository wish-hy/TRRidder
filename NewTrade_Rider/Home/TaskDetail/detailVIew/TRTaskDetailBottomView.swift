//
//  TRTaskDetailBottomView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit
import RxCocoa
import RxSwift
class TRTaskDetailBottomView: UIView {
    
    var contentView : UIView!
    var priceLab : UILabel!
    var tipLab : UILabel!
    var qdBtn : UIButton!
    var blcok : Int_Block?
    var bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        
        let unitLab = UILabel()
        unitLab.text = "¥"
        unitLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        unitLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(unitLab)
        
        priceLab = UILabel()
        priceLab.text = "99"
        priceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        priceLab.font = UIFont.trBoldFont(fontSize: 26)
        contentView.addSubview(priceLab)
        
        let tipUnitLab = UILabel()
        tipUnitLab.isHidden = true
        tipUnitLab.text = "小费¥"
        tipUnitLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        tipUnitLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(tipUnitLab)
        
        tipLab = UILabel()
        tipLab.isHidden = true
        tipLab.text = "99"
        tipLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        tipLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(tipLab)
        
        qdBtn = UIButton()
        qdBtn.layer.cornerRadius = 23
        qdBtn.layer.masksToBounds = true
        qdBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        qdBtn.setTitle("抢单", for: .normal)
        qdBtn.setTitleColor(.white, for: .normal)
        qdBtn.titleLabel?.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(qdBtn)
        
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self)
        }
        unitLab.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.bottom.equalTo(priceLab)
        }
        priceLab.snp.makeConstraints { make in
            make.left.equalTo(unitLab.snp.right)
            make.top.equalTo(contentView).offset(18)
        }
        
        tipLab.snp.makeConstraints { make in
            make.centerY.equalTo(priceLab)
            make.left.equalTo(tipUnitLab.snp.right)
        }
        tipUnitLab.snp.makeConstraints { make in
            make.left.equalTo(priceLab.snp.right).offset(5)
            make.bottom.equalTo(tipLab)
        }
        qdBtn.snp.makeConstraints { make in
            make.centerY.equalTo(priceLab)
            make.height.equalTo(46)
            make.left.equalTo(contentView.snp.centerX)
            make.right.equalTo(contentView).inset(16)
        }
        
//        qdBtn.rx.tap.subscribe(onNext:{[weak self] in
//            print("抢单")
//        }).disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

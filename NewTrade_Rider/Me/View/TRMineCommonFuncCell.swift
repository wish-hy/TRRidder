//
//  TRMineCommonFuncCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

import RxCocoa
import RxSwift
class TRMineCommonFuncCell: UICollectionViewCell {
    
    var moneyBtn : TRMineCommonFunBtn!
    var orderBtn : TRMineCommonFunBtn!
    var commentBtn : TRMineCommonFunBtn!
    var illegalBtn : TRMineCommonFunBtn!
    let bag = DisposeBag()
    
    var commonFunctionsModel : CommonFunctionsModel? {
        didSet {
            guard let commonFunctionsModel = commonFunctionsModel else { return }
            moneyBtn.valueLab.text = commonFunctionsModel.totalAmount
            orderBtn.valueLab.text = commonFunctionsModel.historyOrderCount
            commentBtn.valueLab.text = commonFunctionsModel.evaluationCount
            illegalBtn.valueLab.text = commonFunctionsModel.violationAppealCount
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVIew()
        setAction()
    }
    private func setAction(){
        moneyBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self  else { return }
            let vc = TRWebViewController()
            vc.type = .rider_wallet
            vc.hidesBottomBarWhenPushed = true
            self.viewController()?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
        orderBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self else { return }
            let vc = TRWebViewController()
            vc.type = .rider_history_order
            vc.hidesBottomBarWhenPushed = true
            self.viewController()?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
        commentBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self  else { return }
            let vc = TRWebViewController()
            vc.type = .rider_order_comment
            vc.hidesBottomBarWhenPushed = true
            self.viewController()?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
        illegalBtn.rx.tap.subscribe(onNext :{[weak self] in
            guard let self = self  else { return }
            let vc = TRWebViewController()
            vc.type = .rider_order_rules
            vc.hidesBottomBarWhenPushed = true
            self.viewController()?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
    }

    private func setupVIew(){
        contentView.backgroundColor = .bgColor()
        let bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        moneyBtn = TRMineCommonFunBtn(frame: .zero)
        moneyBtn.bgImgV.image = UIImage(named: "func_money_bg")
        moneyBtn.titleLab.text = "我的钱包(元)"
        moneyBtn.valueLab.text = "0"
        contentView.addSubview(moneyBtn)
        
        orderBtn = TRMineCommonFunBtn(frame: .zero)
        orderBtn.bgImgV.image = UIImage(named: "func_history_bg")
        orderBtn.titleLab.text = "历史订单"
        orderBtn.valueLab.text = "0"
        orderBtn.titleLab.textColor = UIColor.hexColor(hexValue: 0x79C1E4)
        orderBtn.valueLab.textColor = UIColor.hexColor(hexValue: 0x23B1F5)
        contentView.addSubview(orderBtn)

        commentBtn = TRMineCommonFunBtn(frame: .zero)
        commentBtn.bgImgV.image = UIImage(named: "func_comment_bg")
        commentBtn.titleLab.text = "我的评价"
        commentBtn.valueLab.text = "0"
        commentBtn.titleLab.textColor = UIColor.hexColor(hexValue: 0x88E6B1)
        commentBtn.valueLab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        contentView.addSubview(commentBtn)

        illegalBtn = TRMineCommonFunBtn(frame: .zero)
        illegalBtn.bgImgV.image = UIImage(named: "func_ts_bg")
        illegalBtn.titleLab.text = "违规申诉"
        illegalBtn.valueLab.text = "0"
        illegalBtn.titleLab.textColor = UIColor.hexColor(hexValue: 0xF7A79F)
        illegalBtn.valueLab.textColor = UIColor.hexColor(hexValue: 0xFF6A5B)
        contentView.addSubview(illegalBtn)
//
        
        
        moneyBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(30)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(84)
            make.right.equalTo(contentView.snp.centerX).offset(-4.5)
        }
            
        orderBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.centerX).offset(4.5)
            make.top.bottom.equalTo(moneyBtn)
            make.right.equalTo(contentView).offset(-30)
        }
        
        commentBtn.snp.makeConstraints { make in
            make.left.equalTo(moneyBtn)
            make.top.equalTo(moneyBtn.snp.bottom).offset(10)
            make.height.equalTo(moneyBtn)
            make.right.equalTo(moneyBtn)
        }
        
        illegalBtn.snp.makeConstraints { make in
            make.left.right.equalTo(orderBtn)
            make.top.bottom.equalTo(commentBtn)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

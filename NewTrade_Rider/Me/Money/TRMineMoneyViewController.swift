//
//  TRMineMoneyViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit
import RxCocoa
import RxSwift
class TRMineMoneyViewController: BasicViewController {

    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configBar()
        configMainView()
    }
    private func configMainView(){
        let yueView = TRMineMoneyBalanceView(frame: .zero)
        let yueMutablestring = NSMutableAttributedString()
                    
        let yueStr2 = NSAttributedString(string: "200元", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0x141414)])
      
        let yueStr1 = NSAttributedString(string: "接单保证金：", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0x97989A)])
        yueMutablestring.append(yueStr1)
        yueMutablestring.append(yueStr2)
        yueView.bzjBtn.lab.attributedText = yueMutablestring
        self.view.addSubview(yueView)
        
        yueView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(16)
            make.top.equalTo(self.view).offset(Nav_Height + 15)
            make.height.equalTo(162)
        }
        
        let yqView = TRMineMoneyView(frame: .zero)
        yqView.actionBtn.setTitle("去邀请", for: .normal)
        yqView.actionBtn.setBackgroundImage(UIImage(named: "yq_btn_bg"), for: .normal)
        yqView.actionBtn.setTitleColor(UIColor.hexColor(hexValue: 0xDF6241), for: .normal)
        yqView.actionBtn.setTitleColor(UIColor.hexColor(hexValue: 0xDF6241), for: .highlighted)
        yqView.actionBtn.setBackgroundImage(UIImage(named: "yq_btn_bg"), for: .highlighted)
        yqView.titleLab.text = "邀请骑手"
        self.view.addSubview(yqView)
        let yqMutablestring = NSMutableAttributedString()
                    
        let yqStr1 = NSAttributedString(string: "200", attributes: [.font : UIFont.trBoldFont(fontSize: 32), .foregroundColor : UIColor.hexColor(hexValue: 0xDF6241)])
      
        let yqStr2 = NSAttributedString(string: "人", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0xDF6241)])
        yqMutablestring.append(yqStr1)
        yqMutablestring.append(yqStr2)
        yqView.valueLab.attributedText = yqMutablestring
        
        let yqDetailMutablestring = NSMutableAttributedString()
                    
        let yqDetailStr1 = NSAttributedString(string: "赚 ", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0x141414)])
      
        let yqDetailStr2 = NSAttributedString(string: "2000", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0xF93F3F)])
        
        let yqDetailStr3 = NSAttributedString(string: " 元已到钱包余额", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0x141414)])
      
        yqDetailMutablestring.append(yqDetailStr1)
        yqDetailMutablestring.append(yqDetailStr2)
        yqDetailMutablestring.append(yqDetailStr3)

        yqView.detailLab.attributedText = yqDetailMutablestring
        
        yqView.snp.makeConstraints { make in
            make.left.right.equalTo(yueView)
            make.top.equalTo(yueView.snp.bottom).offset(28 * APP_Scale)
            make.height.equalTo(114)
        }
        
        let dhView = TRMineMoneyView(frame: .zero)
        dhView.actionBtn.setTitle("设置打赏", for: .normal)
        dhView.actionBtn.setTitleColor(UIColor.hexColor(hexValue: 0xFA7B05), for: .normal)
        dhView.actionBtn.setBackgroundImage(UIImage(named: "yq_btn_bg"), for: .normal)
        dhView.actionBtn.setTitleColor(UIColor.hexColor(hexValue: 0xFA7B05), for: .highlighted)
        dhView.actionBtn.setBackgroundImage(UIImage(named: "yq_btn_bg"), for: .highlighted)
        dhView.titleLab.text = "顾客打赏"
        dhView.actionBtn.rx.tap.subscribe(onNext:{[weak self] in
            let vc = TRMineRewardSetViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
        let dhMutablestring = NSMutableAttributedString()
                    
        let dhStr1 = NSAttributedString(string: "100", attributes: [.font : UIFont.trBoldFont(fontSize: 32), .foregroundColor : UIColor.hexColor(hexValue: 0xF68B13)])
      
        let dhStr2 = NSAttributedString(string: "次", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0xF68B13)])
        dhMutablestring.append(dhStr1)
        dhMutablestring.append(dhStr2)
        dhView.valueLab.attributedText = dhMutablestring
        
        
        let dhDetailMutablestring = NSMutableAttributedString()
                    
        let dhDetailStr1 = NSAttributedString(string: "赚 ", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0x141414)])
      
        let dhDetailStr2 = NSAttributedString(string: "2.02", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0xF93F3F)])
        
        let dhDetailStr3 = NSAttributedString(string: " 元已到钱包余额", attributes: [.font : UIFont.trFont(fontSize: 13), .foregroundColor : UIColor.hexColor(hexValue: 0x141414)])
      
        dhDetailMutablestring.append(dhDetailStr1)
        dhDetailMutablestring.append(dhDetailStr2)
        dhDetailMutablestring.append(dhDetailStr3)

        dhView.detailLab.attributedText = dhDetailMutablestring
        
        self.view.addSubview(dhView)
        
        dhView.snp.makeConstraints { make in
            make.left.right.equalTo(yueView)
            make.top.equalTo(yqView.snp.bottom).offset(15 * APP_Scale)
            make.height.equalTo(114)
        }
  
        
        yueView.actionBtn.rx.tap.subscribe(onNext:{
            let vc = TRMineWithDrawViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
        yueView.bzjBtn.rx.tap.subscribe(onNext:{
            let vc = TRBondViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
    }
    private func configBar(){
        configNavBar()
        configNavLeftBtn()
       configNavTitle(title: "我的钱包")
        let incomeDetailBtn = UIButton(frame: .init(x: 0, y: 0, width: 90, height: 30))
        incomeDetailBtn.setTitle("收支明细", for: .normal)
        incomeDetailBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        incomeDetailBtn.titleLabel?.font = UIFont.trFont(fontSize: 15)
        
        navBar?.rightView = incomeDetailBtn
        incomeDetailBtn.rx.tap.subscribe(onNext: {[weak self] in
            print("1")
        }).disposed(by: bag)
    }
   


}

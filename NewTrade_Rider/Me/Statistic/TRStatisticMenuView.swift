//
//  TRStatisticMenuView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxCocoa
import RxSwift
class TRStatisticMenuView: UIView {
    var currentSel : Int = 0 {
        didSet{
           configChangeState(state: currentSel)
        }
    }
    
    var menuLab1 : UILabel!
    var menuLab2 : UILabel!
    var menuLab3 : UILabel!
    
    var line : UIView!
    
    var block : Int_Block?
    private var bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        menuLab1 = UILabel()
        menuLab1.text = "昨天"
        menuLab1.textColor = .white
        menuLab1.font = UIFont.trBoldFont(fontSize: 18)
        self.addSubview(menuLab1)
        
        menuLab2 = UILabel()
        menuLab2.text = "本月"
        menuLab2.textColor = UIColor.hexColor(hexValue: 0xDBF3E6)
        menuLab2.font = UIFont.trFont(fontSize: 18)
        self.addSubview(menuLab2)
        
        menuLab3 = UILabel()
        menuLab3.text = "上月"
        menuLab3.textColor = UIColor.hexColor(hexValue: 0xDBF3E6)
        menuLab3.font = UIFont.trFont(fontSize: 18)
        self.addSubview(menuLab3)
        
        line = UIView()
        line.backgroundColor = .white
        self.addSubview(line)
        
        let w = 90
        let h = 30
        menuLab1.snp.makeConstraints { make in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self)
//            make.width.equalTo(w)
            make.height.equalTo(h)
        }
        
        menuLab2.snp.makeConstraints { make in
            make.left.equalTo(menuLab1.snp.right).offset(15)
            make.top.equalTo(self)
//            make.width.equalTo(w)
            make.height.equalTo(h)
        }
        
        menuLab3.snp.makeConstraints { make in
            make.left.equalTo(menuLab2.snp.right).offset(15)
            make.top.equalTo(self)
//            make.width.equalTo(w)
            make.height.equalTo(h)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(menuLab1)
            make.bottom.equalTo(self)
            make.height.equalTo(3)
        }
        
        menuLab1.isUserInteractionEnabled = true
        menuLab2.isUserInteractionEnabled = true
        menuLab3.isUserInteractionEnabled = true

        let tap1 = UITapGestureRecognizer()
        let tap2 = UITapGestureRecognizer()
        let tap3 = UITapGestureRecognizer()

        menuLab1.addGestureRecognizer(tap1)
        menuLab2.addGestureRecognizer(tap2)
        menuLab3.addGestureRecognizer(tap3)


        tap1.rx.event.subscribe(onNext : { _ in
            self.currentSel = 0
            if (self.block != nil) {
                self.block!(self.currentSel)
            }
        }).disposed(by: bag)
        
        tap2.rx.event.subscribe(onNext : { _ in
            self.currentSel = 1
            if (self.block != nil) {
                self.block!(self.currentSel)
            }
        }).disposed(by: bag)
           
        tap3.rx.event.subscribe(onNext : { _ in
            self.currentSel = 2
            if (self.block != nil) {
                self.block!(self.currentSel)
            }
        }).disposed(by: bag)
    }
    private func configChangeState(state : Int){
       let labArr = [menuLab1, menuLab2, menuLab3]
        for index in 0 ..< labArr.count {
            let lab = labArr[index]! as UILabel
            lab.textColor = UIColor.hexColor(hexValue: 0xE2FFF0)
            if index == currentSel {
                lab.textColor = .white
              
                line.snp.remakeConstraints { make in
                    make.left.right.equalTo(lab)
                    make.bottom.equalTo(self)
                    make.height.equalTo(3)
                }
            }
        }
        
       

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//
//  TROrderMonthView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit
import RxSwift
import RxCocoa
class TROrderDatePickView: UIView {
    var topView : UIView!// 透明view
    var bgView : UIView! //半透明view
    var contentView : UIView!
    var cancelBtn : UIButton!
    var titleLab : UILabel!
    var sureBtn : UIButton!
    var dataPicker : UIDatePicker!
    let nHeight : Int = 351
    let bag = DisposeBag()
    var block : Int_Int_Block?
    var offsetY : CGFloat = 0
    var hour : Int = 0
    var minu : Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        topView = UIView()
        topView.backgroundColor = .clear
        self.addSubview(topView)
        
        bgView = UIView()
        bgView.backgroundColor = .black.withAlphaComponent(0.5)
        self.addSubview(bgView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
    
        
        cancelBtn = UIButton()
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.masksToBounds = true
        cancelBtn.setTitle("重置", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066 )
        sureBtn.layer.cornerRadius = 10
        sureBtn.layer.masksToBounds = true
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(sureBtn)
        
        dataPicker = UIDatePicker()
        dataPicker.datePickerMode = .date
        dataPicker.locale = Locale(identifier: "zh")
        dataPicker.rx.controlEvent(.valueChanged).subscribe(onNext:{[weak self] in
            print(self!.dataPicker.date)
        }).disposed(by: bag)
        if #available(iOS 13.4, *) {
            dataPicker.preferredDatePickerStyle = .wheels
            dataPicker.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 246)
        }
        contentView.addSubview(dataPicker)
       
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.centerX).inset(10)
            make.left.equalTo(contentView).offset(26)
            make.height.equalTo(44)
            make.bottom.equalTo(contentView).inset(20)
        }
        sureBtn.snp.makeConstraints { make in
            make.bottom.equalTo(cancelBtn)
            make.right.equalTo(contentView).inset(26)
            make.left.equalTo(contentView.snp.centerX).offset(10)
            make.height.equalTo(44)
        }
                
        dataPicker.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView).offset(0)
            make.height.equalTo(246)
        }
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            self?.closeView()
        }).disposed(by: bag)
        sureBtn.rx.tap.subscribe(onNext: {[weak self] in
            if self!.block != nil {
                self!.block!(self!.hour, self!.minu)
            }
            self?.closeView()
        }).disposed(by: bag)
        
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(contentView.snp.bottom)
        }
    }
    

    func addToWindow(){
        let window = UIApplication.shared.delegate!.window!!
        window.addSubview(self)
        self.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(window)
            make.top.equalTo(window).offset(0)
        }
    }
    func openView(){
        self.layoutIfNeeded()
        self.layoutSubviews()
        topView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: offsetY)
        self.contentView.frame = CGRect(x: 0, y: Int(offsetY), width: Int(Screen_Width), height: 310)
       
    }
    func closeView(){
        self.removeFromSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TROrderDayPicker.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit
import RxCocoa
import RxSwift
class TROrderMonthPicker: UIView ,UIPickerViewDelegate, UIPickerViewDataSource{
    var bgView : UIView!
    var contentView : UIView!
    var cancelBtn : UIButton!
    var titleLab : UILabel!
    var sureBtn : UIButton!
    var dataPicker : UIPickerView!
    let nHeight : Int = 351
    let bag = DisposeBag()
    var block : Int_Int_Block?
    var offsetY : CGFloat = 0 {
        didSet {
            self.contentView.frame = CGRect(x: 0.0, y: offsetY, width: CGFloat(Int(Screen_Width)), height: 310)

        }
    }
    var hour : Int = 0
    var minu : Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        bgView = UIView()
//        bgView.backgroundColor = .black.withAlphaComponent(0.5)
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
        
        dataPicker = UIPickerView()
        dataPicker.delegate = self
        dataPicker.dataSource = self
        contentView.addSubview(dataPicker)
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
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
        
        self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.nHeight))

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 100
        } else {
            return 12
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            hour = row
        } else {
            minu = row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            
            return "\(row + 2023)"
        } else {
            return String(format: "%02d", row + 1)
        }
    }
    func addToWindow(){
        let window = UIApplication.shared.delegate!.window as! UIWindow
        window.addSubview(self)
        self.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(window)
        }
    }
    func openView(){
        self.layoutIfNeeded()
        self.layoutSubviews()
        self.contentView.frame = CGRect(x: 0, y: Int(self.offsetY), width: Int(Screen_Width), height: 310)
        
    }
    func closeView(){
        self.layoutIfNeeded()
        self.layoutSubviews()

        self.removeFromSuperview()
   
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

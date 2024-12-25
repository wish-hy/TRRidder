//
//  TRDatePicker.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit
import RxCocoa
import RxSwift
class TRDatePicker: UIView ,UIPickerViewDelegate, UIPickerViewDataSource{
   
    
    var bgView : UIView!
    var contentView : UIView!
    var cancelBtn : UIButton!
    var titleLab : UILabel!
    var sureBtn : UIButton!
    var dataPicker : UIPickerView!
    let nHeight : Int = 310
    let bag = DisposeBag()
    var block : Int_Int_Block?
    
    var hour : Int = 0
    var minu : Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .black.withAlphaComponent(0.5)
        self.addSubview(bgView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        
        titleLab = UILabel()
        titleLab.text = "选择时间"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(titleLab)
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A ), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        
        sureBtn.setTitleColor(UIColor.hexColor(hexValue: 0x13D066 ), for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(sureBtn)
        
        dataPicker = UIPickerView()
        dataPicker.delegate = self
        dataPicker.dataSource = self
        contentView.addSubview(dataPicker)
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(44)
        }
        sureBtn.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).inset(20)
            make.width.equalTo(50)
            make.height.equalTo(44)
        }
        
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(cancelBtn)
            make.centerX.equalTo(contentView)
        }
        
        dataPicker.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(sureBtn.snp.bottom).offset(16)
            make.bottom.equalTo(contentView).inset(54)
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
            return 24
        } else {
            return 60
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
            
            return "\(row)" + ":00"
        } else {
            return String(format: "%02d", row)
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
        UIView.animate(withDuration: 0.3) {
            self.contentView.frame = CGRect(x: 0, y: Int(Screen_Height) - self.nHeight, width: Int(Screen_Width), height: 310)
        }
        
    }
    func closeView(){
        self.layoutIfNeeded()
        self.layoutSubviews()

        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.nHeight))
        }, completion: { _ in
            self.removeFromSuperview()
        })
   
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

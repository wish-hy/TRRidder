//
//  TRSimpleDataPicker.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/11/2.
//

import UIKit
import RxSwift
import RxCocoa
class TRSimpleDataPicker: UIView  ,UIPickerViewDelegate, UIPickerViewDataSource{
    var items : [String] = [] {
        didSet {
            dataPicker.reloadAllComponents()
        }
    }
    var bgView : UIView!
    var contentView : UIView!
    var cancelBtn : UIButton!
    var titleLab : UILabel!
    var sureBtn : UIButton!
    var dataPicker : UIPickerView!
    let nHeight : Int = (IS_IphoneX ? 310 : 290)
    let bag = DisposeBag()
    var block : Int_Block?
    var index : Int = 0 {
        didSet{
//            dataPicker.selectedRow(inComponent: index)
            dataPicker.selectRow(index, inComponent: 0, animated: true)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .black.withAlphaComponent(0.3)
        self.addSubview(bgView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 10000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 12, height: 12))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer
        
        let line = UIView()
        line.backgroundColor = .lineColor()
        contentView.addSubview(line)
        
        titleLab = TRFactory.labelWith(font: .trMediumFont(fontSize: 18), text: "选择必选分组", textColor: .hexColor(hexValue: 0x141414), superView: contentView)
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        
        sureBtn.setTitleColor(.lightThemeColor(), for: .normal)
        sureBtn.titleLabel?.font = UIFont.trMediumFont(fontSize: 18)
        contentView.addSubview(sureBtn)
        
        dataPicker = UIPickerView()
        dataPicker.delegate = self
        dataPicker.dataSource = self
        contentView.addSubview(dataPicker)
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(20)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.height.equalTo(1)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.centerY.equalTo(titleLab)
            make.height.equalTo(44)
            
        }
        sureBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalTo(contentView).inset(26)
            make.height.equalTo(44)
        }
        
        dataPicker.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(titleLab.snp.bottom).offset(45)
            make.height.equalTo(180)
        }
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            self?.closeView()
        }).disposed(by: bag)
        sureBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            if self.block != nil {
                self.block!(self.index)
            }
            self.closeView()
        }).disposed(by: bag)
        
        self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.nHeight))
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 38
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
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
            self.contentView.frame = CGRect(x: 0, y: Screen_Height - CGFloat(self.nHeight), width: Screen_Width, height: CGFloat(self.nHeight))
        }
        
    }
    func closeView(){
        self.layoutIfNeeded()
        self.layoutSubviews()
        UIView.animate(withDuration: 0.3) {
            self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.nHeight))
        } completion: { _ in
            self.removeFromSuperview()
        }

        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

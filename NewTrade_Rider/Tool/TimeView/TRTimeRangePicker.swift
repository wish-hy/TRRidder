//
//  TRTimeRangePicker.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/11/6.
//

import UIKit
import RxSwift
import RxCocoa
class TRTimeRangePicker: UIView ,UIPickerViewDelegate, UIPickerViewDataSource{

    var bgView : UIView!
    var contentView : UIView!
    var cancelBtn : UIButton!
    var titleLab : UILabel!
    var sureBtn : UIButton!
    var dataPicker : UIPickerView!
    let nHeight : Int = IS_IphoneX ? 354 : 329
    let bag = DisposeBag()
    var block : String_Block?

    var shour : Int = 0
    var sminu : Int = 0
    
    var ehour : Int = 0
    var eminu : Int = 0
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
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 10000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 12, height: 12))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer
        
        let line = UIView()
        line.backgroundColor = .lineColor()
        contentView.addSubview(line)
        
        titleLab = UILabel()
        titleLab.text = "选择置顶时段"
        titleLab.textColor = .txtColor()
        titleLab.font = UIFont.trMediumFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A ), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        
        sureBtn.setTitleColor(.lightThemeColor(), for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(sureBtn)
        
        let sTimeTip = TRFactory.labelWith(font: .trBoldFont(fontSize: 17), text: "开始时间", textColor: .txtColor(), superView: contentView)
        let tolab = TRFactory.labelWith(font: .trBoldFont(fontSize: 17), text: "-", textColor: .txtColor(), superView: contentView)
        let eTimeTip = TRFactory.labelWith(font: .trBoldFont(fontSize: 17), text: "结束时间", textColor: .txtColor(), superView: contentView)

        dataPicker = UIPickerView()
        dataPicker.delegate = self
        dataPicker.dataSource = self
//        dataPicker.rx.controlEvent(.valueChanged).subscribe(onNext:{[weak self] in
//            print(self!.dataPicker.date)
//        }).disposed(by: bag)
//        if #available(iOS 13.4, *) {
//            dataPicker.preferredDatePickerStyle = .wheels
//            dataPicker.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 246)
//        }
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
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.height.equalTo(1)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
        }
        sTimeTip.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.centerX).offset(-50)
            make.top.equalTo(line.snp.bottom).offset(20)
        }
        tolab.snp.makeConstraints { make in
            make.centerY.equalTo(sTimeTip)
            make.centerX.equalTo(contentView)
        }
        eTimeTip.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.centerX).offset(50)
            make.centerY.equalTo(sTimeTip)
        }
        dataPicker.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(eTimeTip.snp.bottom).offset(16)
            make.bottom.equalTo(contentView).inset(IS_IphoneX ? 25 : 15)
        }
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            self?.closeView()
        }).disposed(by: bag)
        sureBtn.rx.tap.subscribe(onNext: {[weak self] in
            if self!.block != nil {
//                self!.block!(self!.dataPicker.date)
                let str = String.init(format: "%02d:%02d~%02d:%02d", self!.shour, self!.sminu, self!.ehour, self!.eminu)
                self!.block!(str)
            }
            self?.closeView()
        }).disposed(by: bag)
        
        self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.nHeight))

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
            self.contentView.frame = CGRect(x: 0, y: Int(Screen_Height) - self.nHeight, width: Int(Screen_Width), height: self.nHeight)
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        } else if component == 1{
            return 60
        } else if component == 2{
            return 24
        } else if component == 3{
            return 60
        }
        
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            shour = row
        } else if component == 1{
            sminu = row
        } else if component == 2{
            ehour = row
        } else if component == 3{
            eminu = row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(row)" + ":00"
        } else if component == 1{
            return String(format: "%02d", row)
        } else if component == 2{
            return "\(row)" + ":00"
        } else if component == 3{
            return String(format: "%02d", row)
        }
        return nil
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

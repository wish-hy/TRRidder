//
//  TROrderMonthView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit
import RxSwift
import RxCocoa
enum TRDatePickViewType : Int {
    case future
    case birth
    case past
    case other
    case none
}

class TRDatePickView: UIView {
    var bgView : UIView!
    var contentView : UIView!
    var cancelBtn : UIButton!
    var titleLab : UILabel!
    var sureBtn : UIButton!
    var dataPicker : UIDatePicker!
    let nHeight : Int = IS_IphoneX ? 310 : 285
    let bag = DisposeBag()
    var block : Date_Block?
    
    var hour : Int = 0
    var minu : Int = 0
    
    var dateType : TRDatePickViewType = .none {
        didSet {
            if dateType == .none {
                dataPicker.maximumDate = nil
                dataPicker.minimumDate = nil
            } else if dateType == .future {
                dataPicker.minimumDate = Date()
                dataPicker.maximumDate = nil
            } else if dateType == .past {
                dataPicker.maximumDate = Date()
                dataPicker.minimumDate = nil
            } else if dateType == .birth {
                dataPicker.minimumDate = nil
                dataPicker.maximumDate = Date()
//                let s = "2000-01-01"
//                let df = DateFormatter()
//                df.dateFormat = "YYYY-MM-dd"
//                dataPicker.date = df.date(from: s)!
            }
        }
    }
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
            make.bottom.equalTo(contentView).inset(IS_IphoneX ? 25 : 15)
        }
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            self?.closeView()
        }).disposed(by: bag)
        sureBtn.rx.tap.subscribe(onNext: {[weak self] in
            if self!.block != nil {
                self!.block!(self!.dataPicker.date)
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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

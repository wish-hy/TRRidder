//
//  TRVaildDatePicker.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/29.
//

import UIKit
import RxSwift
import RxCocoa
class TRVaildDatePicker: UIView {
    var bgView : UIView!
    var contentView : UIView!
    var cancelBtn : UIButton!
    var titleLab : UILabel!
    var sureBtn : UIButton!
    var dataPicker : UIDatePicker!
    let nHeight : Int = IS_IphoneX ? 310 : 285
    let bag = DisposeBag()
    var block : Str_Str_Block?

    var beginBtn : TRVaildDateSubView!
    var endBtn : TRVaildDateSubView!
    let df = DateFormatter()
    private var beginTime : String = "未选择"
    private var endTime : String = "未选择"
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
        titleLab.text = "证件有效期"
        titleLab.textColor = .txtColor()
        titleLab.font = UIFont.trMediumFont(fontSize: 18)
        contentView.addSubview(titleLab)
        df.dateFormat = "YYYY-MM-dd"
        let line = UIView()
        line.backgroundColor = .hexColor(hexValue: 0xC6C9CB)
        contentView.addSubview(line)
        
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
        
        beginBtn = TRVaildDateSubView(frame: .zero)
        beginBtn.trCorner(8)
        contentView.addSubview(beginBtn)
        endBtn = TRVaildDateSubView(frame: .zero)
        endBtn.trCorner(8)
        contentView.addSubview(endBtn)
        
        let middleView = UIView()
        middleView.backgroundColor = .hexColor(hexValue: 0xC6C9CB)
        contentView.addSubview(middleView)
        
        dataPicker = UIDatePicker()
        dataPicker.datePickerMode = .date
        dataPicker.minimumDate = nil
        dataPicker.maximumDate = Date()
        dataPicker.locale = Locale(identifier: "zh")
        
        dataPicker.rx.controlEvent(.valueChanged).subscribe(onNext:{[weak self] in
            guard let self  = self  else { return }
//            print(self!.dataPicker.date)
           
           
            if beginBtn.editState == 1 {
                beginTime = df.string(from: dataPicker.date)
                beginBtn.timeLab.text = beginTime
            } else {
                endTime = df.string(from: dataPicker.date)
                endBtn.timeLab.text = endTime
            }
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
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(titleLab.snp.bottom).offset(16)
            make.height.equalTo(0.5)
        }
        middleView.snp.makeConstraints { make in
            make.width.equalTo(13)
            make.height.equalTo(1)
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(endBtn)
        }
        beginBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.right.equalTo(middleView.snp.left).offset(-13)
            make.height.equalTo(34)
            make.top.equalTo(titleLab.snp.bottom).offset(25)
        }
        endBtn.snp.makeConstraints { make in
            make.left.equalTo(middleView.snp.right).offset(13)
            make.top.bottom.equalTo(beginBtn)
            make.right.equalTo(contentView).inset(16)
        }
        dataPicker.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(beginBtn.snp.bottom).offset(16)
            make.bottom.equalTo(contentView).inset(IS_IphoneX ? 25 : 15)
        }
        
        cancelBtn.rx.tap.subscribe(onNext : {[weak self] in
            self?.closeView()
        }).disposed(by: bag)
        sureBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self  else { return }
            if beginTime.elementsEqual("未选择") {
                SVProgressHUD.showInfo(withStatus: "请选择开始时间")
                return
            }
            if endTime.elementsEqual("未选择") {
                SVProgressHUD.showInfo(withStatus: "请选择结束时间")
                return
            }
            if beginTime.compare(endTime) != .orderedAscending {
                SVProgressHUD.showInfo(withStatus: "结束时间应大于开始时间")
            }
            if block != nil {
                block!(beginTime, endTime)
            }
            self.closeView()
        }).disposed(by: bag)
        
        self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.nHeight))

        beginBtn.addTarget(self, action: #selector(beginAction), for:.touchUpInside)
        endBtn.addTarget(self, action: #selector(endAction), for:.touchUpInside)

    }
    @objc func beginAction(){

        
        dataPicker.minimumDate = nil
        dataPicker.maximumDate = Date()
//        let s = "2000-01-01"
//        let df = DateFormatter()
//        df.dateFormat = "YYYY-MM-dd"
//        dataPicker.date = df.date(from: s)!
        
        if endTime.elementsEqual("未选择") {
            endBtn.editState = 0
        } else {
            endBtn.editState = 2
        }
        beginBtn.editState = 1
        
    }
    @objc func endAction(){
        dataPicker.date = Date()
        dataPicker.minimumDate = Date()
        dataPicker.maximumDate = nil
        if beginTime.elementsEqual("未选择") {
            beginBtn.editState = 0
        } else {
            beginBtn.editState = 2
        }
        endBtn.editState = 1
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
        beginBtn.editState = 1//默认
        endBtn.editState = 0
        beginTime = df.string(from: dataPicker.date)
        beginBtn.timeLab.text = beginTime
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

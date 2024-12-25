//
//  TRTrafficCodeView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

import RxSwift
import RxCocoa

//键盘类型
enum TRTrafficCodeKeyBoardType {
    case provice
    case letter
}
class TRTrafficCodeView: UIView, UITextFieldDelegate {
    var w = (Screen_Width - 24 - 3 * 6 - 9) / 8 {
        didSet {
            setupView()
        }
    }
    //新能源 限制》
    var limitNum : Bool = false {
        didSet {
            let lab = labs.last
            if limitNum {
                lab?.isHidden = true
            } else {
                lab?.isHidden = false
            }
        }
    }
    
    var code : String = "湘A·529863" {
        
        didSet {
            if labs.count <= 0 {
                setupView()
            }
            if code.isEmpty {
                return
            }
            
            //            if code.count - 1 > labs.count {return}
            let str = code as NSString
            let fixStr = str.replacingOccurrences(of: "·", with: "") as NSString
            
            tempCode = code
            for i in 0...fixStr.length - 1 {
                if i <= 7 {
                    let tf = labs[i]
                    tf.text = fixStr.substring(with: .init(location: i, length: 1))
                }
            }
        }
    }
    var textFiled : UITextField!
    private var isModify  = false
    var tempCode : String = "" {
        didSet {
            if tempCode.isEmpty {return}
            for lab in labs {
                lab.text = ""
            }
            for i in 0...tempCode.count - 1 {
                if i > 7 {return}
                let s = tempCode as! NSString
                let a = s.substring(with: .init(location: i, length: 1))
                let tf = labs[i]
                tf.text = a
            }
            
        }
    }
    var tempIndex : Int = 0 //当前光标位置
    var firstView : UIView!
    var secondView : UIView!
    let bag = DisposeBag()
    private var labs : [UILabel] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func setupView(){
        textFiled = UITextField(frame: CGRect(x: -50, y: -50, width: 20, height: 20))
        textFiled.delegate = self
        textFiled.rx.text.subscribe(onNext: {[weak self](txt) in
            guard let self = self else {return}
            if txt!.elementsEqual(tempCode){return}
            if txt == nil || txt!.count <= 1{return}
            if tempIndex >= 8 && isModify == false{
                textFiled.resignFirstResponder()
                return
            }
            if tempIndex == txt!.count - 1 {
                
                self.textFiled.text = txt
                self.tempCode =  txt!
                
            } else {
                if tempIndex <= 7 && tempIndex <= tempCode.count - 1{
                    let mutaStr = NSMutableString(string: tempCode)
                    let last = txt! as NSString
                    let a = last.substring(from: last.length - 1)
                    mutaStr.replaceCharacters(in: .init(location: self.tempIndex, length: 1), with: a)
                    textFiled.text = mutaStr as String
                    self.tempCode =  mutaStr as String
                }
            }
            
            tempIndex += 1
            
            updateBorder(tempIndex)
        }).disposed(by: bag)
        self.addSubview(textFiled)
        
        var preTf : UILabel?
        for i in 0...7 {
            let tf = UILabel(frame: .zero)
            tf.isUserInteractionEnabled = true
            tf.tag = 100 + i
            let tap = UITapGestureRecognizer(target: self, action: #selector(labAction))
            tf.addGestureRecognizer(tap)
            if i == 0 {
                firstView = tf
            } else if i == 1 {
                secondView = tf
            }
            
            
            tf.textAlignment = .center
            tf.font = .trBoldFont(fontSize: 18)
            tf.textColor = .txtColor()
            tf.layer.cornerRadius = 6
            tf.layer.borderColor = UIColor.hexColor(hexValue: 0xE5E7E7).cgColor
            tf.layer.borderWidth = 1
            tf.layer.masksToBounds = true
            self.addSubview(tf)
            labs.append(tf)
            if i == 2 {
                tf.snp.makeConstraints { make in
                    make.left.equalTo(preTf!.snp.right).offset(9)
                    make.width.equalTo(w)
                    make.top.bottom.equalTo(self)
                }
                let pointView = UILabel()
                pointView.layer.cornerRadius = 1.5
                pointView.layer.masksToBounds = true
                pointView.backgroundColor = .txtColor()
                self.addSubview(pointView)
                pointView.snp.makeConstraints { make in
                    make.centerY.equalTo(tf)
                    make.right.equalTo(tf.snp.left).offset(-3)
                    make.width.height.equalTo(3)
                }
            } else {
                
                tf.snp.makeConstraints { make in
                    make.width.equalTo(w)
                    make.top.bottom.equalTo(self)
                    if preTf == nil {
                        make.left.equalTo(self)
                    } else {
                        make.left.equalTo(preTf!.snp.right).offset(3)
                    }
                }
            }
            preTf = tf
        }
    }
    //    func getInputCode() -> String {
    //        var code = ""
    //        for v in labs {
    //            if v.isHidden == true {
    //                code = code + (v.text ?? "")
    //            }
    //        }
    //
    //        return code
    //    }
    @objc func labAction(tap : UITapGestureRecognizer){
        //当 键盘不存在时，要重新创建键盘，block会
        tempIndex = tap.view!.tag - 100
        if self.tempCode.count <= tempIndex {
            tempIndex = self.tempCode.count
        }
        if tempIndex == 0 {
            
            switchKeyBoardType(type: .provice)
            
        } else {
            switchKeyBoardType(type: .letter)
        }
        //        tempIndex += 1
        textFiled.becomeFirstResponder()
        updateBorder(tempIndex)
    }
    func updateBorder(_ index : Int){
        for x in 0...labs.count - 1 {
            let tf = labs[x]
            if x == index {
                tf.layer.borderColor = UIColor.themeColor().cgColor
            } else {
                tf.layer.borderColor = UIColor.hexColor(hexValue: 0xE5E7E7).cgColor
            }
        }
        
        
    }
//    func resignAllFirstResponder(){
//        for x in labs {
//            x.resignFirstResponder()
//        }
//    }
    //键盘切换
    func switchKeyBoardType(type : TRTrafficCodeKeyBoardType){
        let h = ((Screen_Width - 87) / 8 + 8 ) * 4 + 40 + (IS_IphoneX ? 25 : 0)
        
        if type == .provice {
            var oriKeyBoard = textFiled.inputView as? TRProvinceKeyBoard
            if oriKeyBoard != nil {
                self.textFiled.becomeFirstResponder()
                return
            }
            
            let aa = TRProvinceKeyBoard(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: h))
            
            aa.block = {[weak self](value) in
                guard let self = self else {return}
                if self.tempCode.isEmpty {
                    self.tempCode = value
                    self.textFiled.text = value
                    
                } else {
                    var s = self.tempCode
                    s.removeFirst()
                    self.tempCode = value + s
                    self.textFiled.text = value + s
                }
                self.tempIndex += 1
                self.updateBorder(self.tempIndex)
                //输入一个后要切换成字母键盘
                switchKeyBoardType(type: .letter)
            }
            self.textFiled.inputView = aa
            self.textFiled.becomeFirstResponder()
        } else if type == .letter {
            var aa = textFiled.inputView as? TRLetterNumKeyBoard
            
            var bb : TRLetterNumKeyBoard?
            if aa != nil {
                self.textFiled.becomeFirstResponder()
                return
            } else {
                textFiled.resignFirstResponder()
                bb = TRLetterNumKeyBoard(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: h))
                textFiled.inputView = bb
                textFiled.becomeFirstResponder()
            }
            bb!.cancelBlock = {[weak self] in
                guard let self = self  else { return }
                var s = NSMutableString(string: self.tempCode)
                if s.length > 1 {
                    s.deleteCharacters(in: .init(location: s.length - 1, length: 1))
                    self.textFiled.text = s as String
                    self.tempCode = s as String
                    tempIndex -= 1
                }
                
            }
            bb!.block = {[weak self](value) in
                guard let self = self else {return}
                if tempIndex == 1 {
                    let a = Int(value)
                    if a != nil {
                        SVProgressHUD.showInfo(withStatus: "请输入字母")
                        return
                    }
                }
                
                var s = NSMutableString(string: self.tempCode)
                if tempIndex <= s.length - 1 {
                    let last = s.replacingCharacters(in: .init(location: tempIndex, length: 1), with: value)
                    self.tempCode =  last
                    self.textFiled.text =  last
                } else {
                    if limitNum{
                        if tempIndex <  7  {
                            s.append(value)
                            tempIndex += 1
                        }
                    }else{
                        if tempIndex < 8{
                            s.append(value)
                            tempIndex += 1
                        }
                    }
                    self.tempCode =  s as String
                    self.textFiled.text =  s as String
                }
               
                updateBorder(tempIndex)
            }
            textFiled.becomeFirstResponder()
            updateBorder(tempIndex)
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 获取当前文本框的文本
               let currentText = textField.text ?? ""
               
               // 计算输入后的文本
               let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
               
               // 检查文本长度是否超过最大值
        if limitNum {
            if newText.count > 8 {
                return false // 不允许输入
            }
        }else {
            if newText.count > 7 {
                return false // 不允许输入
            }
        }
             return true // 允许输入
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

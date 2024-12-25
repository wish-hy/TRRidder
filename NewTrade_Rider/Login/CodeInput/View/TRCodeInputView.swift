//
//  TRCodeInputView.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/1/26.
//

import UIKit
import RxSwift
import RxCocoa
class TRCodeInputView: UIView, UITextViewDelegate {
    private var views : [TRCodeInputSubView] = []
    var num = 6
    
    var doneBlock : Void_Block?
    
    let bag = DisposeBag()
    private var textField : UITextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    func getStr()->String {
        var s = ""
        for x in views {
            s.append(x.textField.text!)
        }
        return s
    }
    private func setupView(){
        textField = UITextField(frame: .init(x: -100, y: -100, width: 10, height: 10))
        textField.keyboardType = .numberPad
        self.addSubview(textField)
        textField.rx.text.subscribe(onNext: {[weak self](t) in
            
            guard let self  = self  else { return }
            if views.isEmpty {
                return
            }
            guard let t  = t else { return }
            var s = t as! NSString
            if s.length > 6 {
                let h = s.substring(to: 6)
                textField.text = h
                s = h as NSString
            }
            if s.length > 0 {
                for x in 0...s.length - 1 {
                let v = views[x]
                v.textField.layer.borderColor = UIColor.themeColor().cgColor
                v.textField.layer.borderWidth = 1
                v.textField.text = s.substring(with: .init(location: x, length: 1))
            }
        }
            var a = s.length
            
            if s.length < 6 {
                for i in a...5 {
                    let v = views[i]
                    v.textField.layer.borderColor = UIColor.clear.cgColor
                    v.textField.layer.borderWidth = 1
                    v.textField.text = ""
                }
            }
            
            if s.length == 6 {
                if doneBlock != nil {
                    doneBlock!()
                }
            }
        }).disposed(by: bag)
        
        for i in 0...num - 1 {
            let v = TRCodeInputSubView(frame: .zero)
            v.trCorner(8)
            v.backgroundColor = .hexColor(hexValue: 0xF1F3F4)
            v.textField.tag = 1000 + i
            let tap = UITapGestureRecognizer()
            v.addGestureRecognizer(tap)
            tap.addTarget(self, action: #selector(openKeyBoard))
            v.textField.isUserInteractionEnabled = true
            self.addSubview(v)
            views.append(v)
            if i == 0 {
                //                v.textField.becomeFirstResponder()
            }
        }
        
        views.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.height.equalTo(58 * TRWidthScale)
            make.bottom.equalTo(self)
        }
        views.snp.distributeViewsAlong(axisType: 0, fixedSpacing: 10, leadSpacing: 16, tailSpacing: 16)
        
        textField.becomeFirstResponder()
    }
    @objc func openKeyBoard(){
        textField.becomeFirstResponder()
    }
//    func textViewDidChange(_ textView: UITextView) {
//        if !TRTool.isNullOrEmplty(s: textView.text) {
//            let s = textView.text as! NSString
//            textView.text = s.substring(from: s.length - 1)
//            textView.layer.borderColor = UIColor.lightThemeColor().cgColor
//            textView.layer.borderWidth = 1
//            let tag = textView.tag - 1000
//            if tag == views.count - 1 {
//                //
//                if doneBlock != nil {
//                    doneBlock!()
//                }
//            } else {
//                let v = views[tag + 1]
//                v.textField.becomeFirstResponder()
//            }
//        } else {
//            textView.layer.borderColor = UIColor.clear.cgColor
//            textView.layer.borderWidth = 1
//            let tag = textView.tag - 1000
//            if tag != 0 {
//                let v = views[tag - 1]
//                v.textField.becomeFirstResponder()
//            }
//        }
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////        if string.elementsEqual("") {
////            textField.text = ""
////            let tag = textField.tag - 1000
////            let perTag = tag - 1
////            if perTag >= 0 {
////                let v = views[perTag]
////                v.textField.becomeFirstResponder()
////            }
////            return false
////        }
//
//        if !TRTool.isNullOrEmplty(s: textField.text) {
//
//            let s = string as! NSString
//            textField.text = string
//            let tag = textField.tag - 1000
//            if tag == views.count - 1 {
//                //
//                if doneBlock != nil {
//                    doneBlock!()
//                }
//                return false
//
//            } else {
//                let v = views[tag + 1]
//                v.textField.becomeFirstResponder()
//                return false
//            }
//        }
//        return true
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

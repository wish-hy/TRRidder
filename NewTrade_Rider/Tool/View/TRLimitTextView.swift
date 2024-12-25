//
//  TRLimitTextView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit
import RxCocoa
import RxSwift
class TRLimitTextView: UIView {

    var placeHolder : String = "" {
        didSet{
            placeholderLab.text = placeHolder
        }
    }
    private var placeholderLab : UILabel!
    var numLab : UILabel!
    var textView : UITextView!
    let bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        textView = UITextView()
        textView.text = ""
        textView.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        textView.font = UIFont.trFont(fontSize: 14)
        textView.backgroundColor = .clear
        self.addSubview(textView)
        
        numLab = UILabel()
        numLab.text = "0/50"
        numLab.textAlignment = .right
        numLab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        numLab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(numLab)
        
        numLab.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        textView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(numLab.snp.top).offset(-12)
        }
        
        textView.rx.text.subscribe(onNext:{[weak self] (text) in
            if text == nil {
                return
            }
            if text!.count >= 50 {
               
                self?.textView.text = (text! as NSString).substring(to: 50)
                self!.numLab.text = "50/50"
            }
            
            self!.numLab.text = "\(text!.count)/50"
        }).disposed(by: bag)
        
        
        placeholderLab = UILabel()
        placeholderLab.text = ""
        placeholderLab.textColor = UIColor.hexColor(hexValue: 0x9B9C9C)
        placeholderLab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(placeholderLab)
        placeholderLab.frame = CGRect(x: 8, y: 8, width: Screen_Width - 80, height: 15)
        
        textView.rx.text.subscribe(onNext:{[weak self] (text) in
            if text == nil || text == "" {
                self!.placeholderLab.isHidden = false
            } else {
               self!.placeholderLab.isHidden = true
            }
           
            
            
        }).disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

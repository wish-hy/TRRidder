//
//  TRPlaceHolderTextView.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/28.
//

import UIKit
import NextGrowingTextView
import RxCocoa
import RxSwift
class TRPlaceHolderTextView: NextGrowingTextView {
    var placeholder : String? {
        didSet {
                placeholderLab.text = placeholder
        }
    }
    var text : String = "" {
        didSet {
            self.textView.text = text
        }
    }
     var font: UIFont? {
        didSet {
            self.textView.font = font
            placeholderLab.font = font
        }
    }
    var textColor : UIColor = .black {
        didSet{
            self.textView.textColor = textColor
        }
    }
    private var placeholderLab : UILabel!
    private let bag = DisposeBag()
    override init() {
        super.init()
        setupView()
    }
    
    func setupView(){
        placeholderLab = UILabel()
        placeholderLab.text = "请输入"
        placeholderLab.textColor = UIColor.hexColor(hexValue: 0x9B9C9C)
        placeholderLab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(placeholderLab)
        placeholderLab.snp.makeConstraints { make in
            make.left.equalTo(self).offset(4)
            make.top.equalTo(self).offset(6)
        }
        self.textView.rx.text.subscribe(onNext:{[weak self] (text) in
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

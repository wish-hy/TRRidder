//
//  NGView.swift
//  NewTrade_Seller
//
//  Created by xph on 2024/7/13.
//

import UIKit

class NGView: UIView, UITextViewDelegate {
    var textView : UITextView!
    var placeholder : String = "" {
        didSet {
            placeholderLab.text = placeholder
        }
    }
    var text = "" {
        didSet {
            textView.text = text
            
            if TRTool.isNullOrEmplty(s: textView.text) {
                placeholderLab.isHidden = false
            } else {
                placeholderLab.isHidden = true
            }
        }
    }
    
    var font : UIFont? {
        didSet {
            guard let font = font else { return }
            textView.font = font
            placeholderLab.font = font
        }
    }
    private var placeholderLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
       
        
        textView = UITextView(frame: .zero)
        textView.delegate = self
        self.addSubview(textView)
        
        placeholderLab = UILabel()
        placeholderLab.numberOfLines = 2
        placeholderLab.textColor = .hexColor(hexValue: 0x9B9C9C)
        self.addSubview(placeholderLab)
       
        placeholderLab.snp.makeConstraints { make in
            make.left.right.top.equalTo(self).inset(8)
        }
        textView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if TRTool.isNullOrEmplty(s: textView.text) {
            placeholderLab.isHidden = false
        } else {
            placeholderLab.isHidden = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

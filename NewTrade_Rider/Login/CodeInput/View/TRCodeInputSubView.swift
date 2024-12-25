//
//  TRCodeInputSubView.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/1/26.
//

import UIKit

class TRCodeInputSubView: UIView {
    var textField : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        textField = UILabel(frame: .zero)
        textField.text = ""
        textField.backgroundColor = .clear
        textField.trCorner(8)
        self.addSubview(textField)
        textField.textAlignment = .center
        textField.font = .trBoldFont(32)
        textField.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

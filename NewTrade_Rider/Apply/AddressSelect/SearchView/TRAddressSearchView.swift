//
//  TRAddressSearchView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/21.
//

import UIKit

class TRAddressSearchView: UIView {

    var contentView : UIView!
    var searchImgV : UIImageView!
    var textField : UITextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        self.addSubview(contentView)
        
        
        searchImgV = UIImageView(image: UIImage(named: "search_gray"))
        contentView.addSubview(searchImgV)
        contentView.backgroundColor = .hexColor(hexValue: 0xF1F3F4)
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        textField = UITextField()
        contentView.addSubview(textField)
        textField.placeholder = "搜索 省/市/区（县）/乡镇"
        textField.font = .trFont(fontSize: 13)
        textField.textColor = .txtColor()
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(5)
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(self)
        }
        searchImgV.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.height.width.equalTo(20)
        }
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(searchImgV.snp.right).offset(5)
            make.height.equalTo(28)
            make.right.equalTo(contentView).inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

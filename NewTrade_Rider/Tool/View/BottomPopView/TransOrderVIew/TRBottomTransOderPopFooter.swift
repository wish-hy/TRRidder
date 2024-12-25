//
//  TRBottomTransOderPopFooter.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit
import RxCocoa
import RxSwift
class TRBottomTransOderPopFooter: UITableViewHeaderFooterView {
    
    var cancelBtn : UIButton!
    var sureBtn : UIButton!
    let bag = DisposeBag()
  
    var siCancel = false
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    

    private func setupView(){
        contentView.backgroundColor = .white
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.masksToBounds = true
        contentView.addSubview(cancelBtn)
        
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        sureBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        sureBtn.layer.cornerRadius = 10
        sureBtn.layer.masksToBounds = true
        contentView.addSubview(sureBtn)
 
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(26)
            make.top.equalTo(contentView).offset(15)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(26)
            make.top.equalTo(cancelBtn)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

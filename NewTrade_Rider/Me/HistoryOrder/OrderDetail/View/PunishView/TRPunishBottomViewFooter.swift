//
//  TRPunishBottomViewFooter.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxCocoa
import RxSwift
class TRPunishBottomViewFooter: UITableViewHeaderFooterView {
    
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
        cancelBtn.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(15)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
 
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRServiceFooter.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxSwift
import RxCocoa

class TRServiceFooter: UITableViewHeaderFooterView {
    var btn : UIButton!
    var bag = DisposeBag()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    private func setupUI(){
        contentView.backgroundColor = .bgColor()
        
        btn = UIButton()
        btn.backgroundColor = UIColor.hexColor(hexValue: 0x3D066)
        btn.setTitle("提交", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.white, for: .highlighted)
        btn.layer.cornerRadius = 23
        btn.layer.masksToBounds = true
        contentView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.left.right.equalTo(contentView).inset(35)
            make.top.equalTo(contentView).offset(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

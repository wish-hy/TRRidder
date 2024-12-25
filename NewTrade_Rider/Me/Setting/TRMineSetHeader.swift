//
//  TRMineSetHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineSetHeader: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var titleLab : UILabel!
    var desLab : UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    private func setupView(){
        contentView.backgroundColor = .white
        let topView = UIView()
        topView.backgroundColor = .bgColor()
        contentView.addSubview(topView)
        titleLab = UILabel()
        titleLab.text = "个人信息"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(titleLab)

        topView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(10)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.left.equalTo(contentView).offset(16)
            
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

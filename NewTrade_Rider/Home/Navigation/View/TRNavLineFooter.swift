//
//  TRNavLineFooter.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit
import RxSwift
import RxCocoa

class TRNavLineFooter: UITableViewHeaderFooterView {
    var navBtn : UIButton!
    
    var bag = DisposeBag()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        bag = DisposeBag()
        setupUII()
    }
    

    
    private func setupUII(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        let startImgV = UIImageView(image: UIImage(named: "nav_end"))
        bgView.addSubview(startImgV)
        
        let startLab = UILabel()
        startLab.text = "完成配送"
        startLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        startLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(startLab)
        
        navBtn = TRFactory.buttonWithCorner(title: "按推荐路线导航", bgColor: .lightThemeColor(), font: .trBoldFont(18), corner: 23)
        contentView.addSubview(navBtn)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xffffff)
        contentView.addSubview(line)
        
        bgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
            make.height.equalTo(120)
        }

        
        startImgV.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(15)
            make.top.equalTo(contentView)
            make.width.height.equalTo(36)
        }
        startLab.snp.makeConstraints { make in
            make.centerY.equalTo(startImgV)
            make.left.equalTo(startImgV.snp.right).offset(9)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.height.equalTo(1)
            make.top.equalTo(startLab.snp.bottom).offset(34)
        }
        navBtn.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(30)
            make.height.equalTo(46)
            make.top.equalTo(line.snp.bottom).offset(10)
        }
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

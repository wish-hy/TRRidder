//
//  TRServiceHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxSwift
import RxCocoa
class TRServiceHeader: UITableViewHeaderFooterView {
    var iconImgV : UIImageView!
    var titleLab : UILabel!
    
    var moreBtn : TRRightButton!
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
        contentView.backgroundColor = .white
        let topView = UIView()
        topView.backgroundColor = .bgColor()
        contentView.addSubview(topView)
        
        iconImgV = UIImageView(image: UIImage(named: "common_question"))
        contentView.addSubview(iconImgV)
        
        titleLab = UILabel()
        titleLab.text = "常见问题"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        moreBtn = TRRightButton(frame: .zero)
        moreBtn.lab.text = "更多"
        moreBtn.lab.textColor = UIColor.hexColor(hexValue: 0x141414)
        moreBtn.lab.font = UIFont.trFont(fontSize: 13)
        moreBtn.imgV.image = UIImage(named: "advance_gray")
        contentView.addSubview(moreBtn)

        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(10)
        }
        
        iconImgV.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(contentView).offset(13)
            make.centerY.equalTo(contentView).offset(5)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(iconImgV.snp.right).offset(4)
            make.centerY.equalTo(iconImgV)
        }
        
        moreBtn.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-16)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

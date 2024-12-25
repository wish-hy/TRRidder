//
//  TROrderReasonView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TROrderReasonView: UIView {
    var contentView : UIView!
    var reasonLab : UILabel!
    var reasonDetailLab : UILabel!
    
    var bgColor: UIColor = UIColor.hexColor(hexValue: 0xFFF5F5){
        didSet {
            contentView.backgroundColor = bgColor
        }
    }
    var textColor : UIColor = UIColor.hexColor(hexValue: 0xF93F3F ){
        didSet {
            reasonLab.textColor = textColor
            reasonDetailLab.textColor = textColor
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        contentView.backgroundColor = UIColor.hexColor(hexValue: 0xFFF5F5)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        self.addSubview(contentView)
        
        reasonLab = UILabel()
        reasonLab.text = "昨日收入(元)"
        reasonLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F )
        reasonLab.font = UIFont.trFont(fontSize: 17)
        contentView.addSubview(reasonLab)
        
        reasonDetailLab = UILabel()
        reasonDetailLab.text = "取消原因：配送延时太长"
        reasonDetailLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F )
        reasonDetailLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(reasonDetailLab)
        
        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        reasonLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(contentView).offset(15)
        }
        reasonDetailLab.snp.makeConstraints { make in
            make.left.equalTo(reasonLab)
            make.top.equalTo(reasonLab.snp.bottom).offset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

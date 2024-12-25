//
//  TRPin_RiderView.swift
//  NewTrade_Rider
//
//  Created by xzy on 2024/11/26.
//

import UIKit
 
class TRPIin_RiderView: UIView {
    var bgView : YCShadowView!
    var timeLab : UILabel!
    var waitLab : UILabel!
//    var type :{
//        didSet{
//
//        }
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        bgView = YCShadowView()
        bgView.yc_shaodw()
        bgView.yc_cornerRadius(5)
        self.addSubview(bgView)
        
//        let arrowIcon = UIImageView(image: UIImage(named: "sanjiao_xia"))
//        self.addSubview(arrowIcon)
//        let bottomIcon = UIImageView(image: UIImage(named: "loc_bottom_black"))
//        self.addSubview(bottomIcon)
        
        waitLab = UILabel(frame: frame)
        self.addSubview(waitLab)
        waitLab.text = ""
        waitLab.textAlignment = .center
        waitLab.font =  UIFont.trFont(fontSize: 14)
        
        timeLab = UILabel(frame: frame)
        timeLab.font =  UIFont.trFont(fontSize: 14)
        self.addSubview(timeLab)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(10)
            make.bottom.right.equalTo(self)
        }
        waitLab.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(bgView)
            make.width.equalTo(90)
            make.height.equalTo(25)
        }
//        timeLab.snp.makeConstraints { make in
//            make.top.equalTo(waitLab.snp.bottom)
//            make.left.equalTo(waitLab)
//            make.width.equalTo(150)
//            make.height.equalTo(25)
//        }
    }
//    func
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


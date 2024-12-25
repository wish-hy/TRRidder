//
//  TRHomeNavBar.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/22.
//

import UIKit

class TRHomeNavBar: UIView {
    var headImgV : UIImageView!
    var stateView : TRHomeStateView!
    var mesBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        /*
         navStateView = TRHomeStateView(frame: CGRect(x: 0, y: 0, width: 113, height: 38))

         */
        headImgV = TRFactory.imageViewWith(image: Net_Default_Head, mode: .scaleAspectFill, superView: self)
        headImgV.sd_setImage(with: URL.init(string: TRDataManage.shared.applyModel.riderInfo.profilePicUrl), placeholderImage: UIImage(named: "rider_head_def"))

        headImgV.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer()
        headImgV.addGestureRecognizer(tapGes)
        tapGes.addTarget(self, action: #selector(tapAction))
        headImgV.trCorner(20)
        
        stateView = TRHomeStateView(frame: .zero)
        self.addSubview(stateView)
        
        mesBtn = UIButton()
        mesBtn.setImage(UIImage(named: "home_message_white"), for: .normal)
        self.addSubview(mesBtn)
        
        headImgV.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.top.equalTo(self).inset(StatusBar_Height + 8)
            make.height.width.equalTo(40)
        }
        stateView.snp.makeConstraints { make in
            make.centerY.equalTo(headImgV)
            make.left.equalTo(headImgV.snp.right).offset(8)
            make.width.equalTo(105)
            make.height.equalTo(38)
        }
        mesBtn.snp.makeConstraints { make in
            make.height.width.equalTo(38)
            make.centerY.equalTo(headImgV)
            make.right.equalTo(self).inset(16)
        }
        
    }
    @objc func tapAction(){
        let vc = TRMineViewController()
        vc.hidesBottomBarWhenPushed = true
        self.iq.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

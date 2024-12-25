//
//  TRRiderApplyRecordDetailHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/24.
//

import UIKit

class TRRiderApplyRecordDetailHeader: UIView {
    
    var topBgImgV : UIImageView!
    var itemLab : UILabel!
    var addressLab : UILabel!
    var stateImgV : UIImageView!
    
    var model : TRRiderApplyRecordModel? {
        didSet {
            guard let model = model else { return }
            /*
        当前认证状态: 待审核=UNAUDITED，审核不通过=REJECTED，审核通过=APPROVE，待签约=UNSIGNED，待培训=UNTRAINED，已培训=TRAINED,可用值:UNAUDITED,REJECTED,UNSIGNED,UNTRAINED,TRAINED
        */
            itemLab.text = model.serviceCodeDesc
            addressLab.text = model.areaAddress
           if model.authStatus.elementsEqual("UNAUDITED") {
               // apply_recrod_state_bg_pending
               topBgImgV.image = UIImage(named: "apply_recrod_state_bg_pending")
               stateImgV.image = UIImage(named: "apply_recrod_state_pending")
           } else if model.authStatus.elementsEqual("REJECTED") {
               topBgImgV.image = UIImage(named: "apply_record_state_bg_failed")
               stateImgV.image = UIImage(named: "apply_recrod_state_failed")
           } else if model.authStatus.elementsEqual("APPROVE") {
               topBgImgV.image = UIImage(named: "apply_record_state_bg_success")
               stateImgV.image = UIImage(named: "apply_record_state_success")
           } else if model.authStatus.elementsEqual("UNSIGNED") {
               topBgImgV.image = UIImage(named: "apply_record_state_bg_success")
               stateImgV.image = UIImage(named: "apply_record_state_success")
           } else if model.authStatus.elementsEqual("UNTRAINED") {
               topBgImgV.image = UIImage(named: "apply_record_state_bg_success")
               stateImgV.image = UIImage(named: "apply_record_state_success")
           } else if model.authStatus.elementsEqual("TRAINED") {
               topBgImgV.image = UIImage(named: "apply_record_state_bg_success")
               stateImgV.image = UIImage(named: "apply_record_state_success")
           }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        topBgImgV = TRFactory.imageViewWith(image: UIImage(named: "apply_record_state_bg_success"), mode: .scaleAspectFill, superView: self)
        stateImgV = TRFactory.imageViewWith(image: UIImage(named: "apply_state_success"), mode: .scaleAspectFit, superView: self)
        itemLab = TRFactory.labelWith(font: .trBoldFont(22), text: "同城送货", textColor: .txtColor(), superView: self)

        addressLab = TRFactory.labelWith(font: .trFont(13), text: "广东省深圳市", textColor: .hexColor(hexValue: 0x67686A), superView: self)
        let addressImgV = TRFactory.imageViewWith(image: UIImage(named: "record_location"), mode: .scaleAspectFit, superView: self)
        
        
        topBgImgV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        stateImgV.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-13)
            make.bottom.equalTo(self).offset(-35)
        }
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.top.equalTo(self).offset(StatusBar_Height + 44 + 15)
        }
        addressImgV.snp.makeConstraints { make in
            make.left.equalTo(itemLab)
            make.top.equalTo(itemLab.snp.bottom).offset(4)
            make.width.height.equalTo(18)
        }
        addressLab.snp.makeConstraints { make in
            make.centerY.equalTo(addressImgV)
            make.left.equalTo(addressImgV.snp.right).offset(2)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

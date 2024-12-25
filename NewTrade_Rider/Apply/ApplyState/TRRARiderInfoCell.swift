//
//  TRRARiderInfoCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/25.
//

import UIKit

class TRRARiderInfoCell: UITableViewCell {
    var headImgV : UIImageView!
    var nameLab : UILabel!
    var phoneLab : UILabel!
    
    var sendTypeLab : UILabel!
    var addressLab : UILabel!
    var vehicleLab : UILabel!
    var timeLab : UILabel!
    var stateImgV : UIImageView!
    
    var vehicleTipLab : UILabel!
    var sendTypeTipLab : UILabel!
    var timeTipLab : UILabel!
    var bgView : UIView!
    //申请记录的数据模型
    var recordModel : TRRiderApplyRecordModel? {
        didSet {
            guard let recordModel = recordModel else { return }
            nameLab.text = recordModel.name
            phoneLab.text = recordModel.phone
            headImgV.sd_setImage(with: URL.init(string: recordModel.profilePicUrl), placeholderImage: UIImage(named: "rider_head_def"))
            timeLab.text = recordModel.createTime
            sendTypeLab.text = recordModel.serviceCodeDesc
            addressLab.text = recordModel.areaAddress
//            vehicleLab.text = recordModel.vehicleType + "\n" + recordModel.numberplate
            vehicleLab.text = recordModel.authVehicleInfo
        }
    }
    //初次的申请模型
    var model : TRApplerRiderContainer? {
        didSet {
            guard let model = model else { return }
            vehicleLab.snp.remakeConstraints { make in
                make.top.equalTo(vehicleTipLab)
                make.left.equalTo(sendTypeTipLab.snp.right).offset(32)
                make.bottom.equalTo(bgView).inset(20)

            }
            
            timeTipLab.snp.removeConstraints()
            timeLab.snp.removeConstraints()
            timeLab.isHidden = true
            timeTipLab.isHidden = true
            
            nameLab.text = model.riderInfo.name
            phoneLab.text = TRTool.getData(key: "phone")! as! String
            
            headImgV.sd_setImage(with: URL.init(string: model.riderInfo.profilePicUrl), placeholderImage: UIImage(named: "rider_head_def"))
            if model.riderInfo.riderType.elementsEqual("GENERAL") {
                addressLab.text = "普通骑手"
            } else {
                addressLab.text = "专送骑手"
            }

            if model.riderInfo.serviceCode.elementsEqual("MALL") {
                sendTypeLab.text = "商城配送"
            } else if model.riderInfo.serviceCode.elementsEqual("LOCAL_FAST_DEL"){
                sendTypeLab.text = "同城跑腿"
            } else if model.riderInfo.serviceCode.elementsEqual("LOCAL_DEL_GOODS"){
                sendTypeLab.text = "同城送货"
            }
            
            addressLab.text = model.riderInfo.areaAddress
            vehicleLab.text = model.vehicleInfo.codeName + "\n" + model.vehicleInfo.numberplate
            
            if model.riderInfo.curAuthStatus.elementsEqual("UNAUDITED") {
                stateImgV.image = UIImage(named: "apply_sate_pending")
            } else if model.riderInfo.curAuthStatus.elementsEqual("REJECTED") {
                stateImgV.image = UIImage(named: "apply_state_fail")
            } else if model.riderInfo.curAuthStatus.elementsEqual("UNTRAINED") {
                //审核通过，为训练
                stateImgV.image = UIImage(named: "apply_state_success")
                
            } else if model.riderInfo.curAuthStatus.elementsEqual("UNSIGNED") {
                //审核通过，为qianyue
                stateImgV.image = UIImage(named: "apply_state_success")
                
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        bgView.trCorner(10)
        
        headImgV = TRFactory.imageViewWith(image: Net_Default_Head, mode: .scaleAspectFill, superView: bgView)
        headImgV.trCorner(8)
        
        nameLab = TRFactory.labelWith(font: .trBoldFont(22), text: "name", textColor: .txtColor(), superView: bgView)
        phoneLab = TRFactory.labelWith(font: .trMediumFont(16), text: "66556566", textColor: .txtColor(), superView: bgView)
        
        stateImgV = TRFactory.imageViewWith(image: UIImage(named: "apply_state_success"), mode: .scaleAspectFill, superView: bgView)

        
         sendTypeTipLab = TRFactory.labelWith(font: .trFont(16), text: "配送业务", textColor: .txtColor(), superView: bgView)
        sendTypeLab = TRFactory.labelWith(font: .trMediumFont(16), text: "商城骑手", textColor: .txtColor(), superView: bgView)
        let addressTipLab = TRFactory.labelWith(font: .trFont(16), text: "工作地点", textColor: .txtColor(), superView: bgView)
        addressLab = TRFactory.labelWith(font: .trMediumFont(16), text: "商城骑手", textColor: .txtColor(), superView: bgView)

        vehicleTipLab = TRFactory.labelWith(font: .trFont(16), text: "车辆信息", textColor: .txtColor(), superView: bgView)
        vehicleLab = TRFactory.labelWith(font: .trMediumFont(16), text: "商城骑手", textColor: .txtColor(), superView: bgView)
        vehicleLab.numberOfLines = 2
        
        timeTipLab = TRFactory.labelWith(font: .trFont(16), text: "申请时间", textColor: .txtColor(), superView: bgView)
        timeLab = TRFactory.labelWith(font: .trMediumFont(16), text: "---", textColor: .txtColor(), superView: bgView)
        
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(10)
        }
        headImgV.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(15)
            make.top.equalTo(bgView).offset(20)
            make.height.width.equalTo(82)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(headImgV.snp.right).offset(14)
            make.bottom.equalTo(headImgV.snp.centerY).offset(-4)
        }
        phoneLab.snp.makeConstraints { make in
            make.top.equalTo(headImgV.snp.centerY).offset(4)
            make.left.equalTo(nameLab)
        }
        stateImgV.snp.makeConstraints { make in
            make.top.right.equalTo(bgView)
            make.height.width.equalTo(112)
        }
        sendTypeTipLab.snp.makeConstraints { make in
            make.left.equalTo(headImgV)
            make.top.equalTo(headImgV.snp.bottom).offset(20)
        }
        sendTypeLab.snp.makeConstraints { make in
            make.centerY.equalTo(sendTypeTipLab)
            make.left.equalTo(sendTypeTipLab.snp.right).offset(32)
        }
        
        addressTipLab.snp.makeConstraints { make in
            make.left.equalTo(headImgV)
            make.top.equalTo(sendTypeLab.snp.bottom).offset(20)
        }
        addressLab.snp.makeConstraints { make in
            make.centerY.equalTo(addressTipLab)
            make.left.equalTo(sendTypeTipLab.snp.right).offset(32)
        }
        
        vehicleTipLab.snp.makeConstraints { make in
            make.left.equalTo(headImgV)
            make.top.equalTo(addressLab.snp.bottom).offset(20)

        }
        vehicleLab.snp.makeConstraints { make in
            make.top.equalTo(vehicleTipLab)
            make.left.equalTo(sendTypeTipLab.snp.right).offset(32)
        }
        
        timeTipLab.snp.makeConstraints { make in
            make.left.equalTo(headImgV)
            make.top.equalTo(vehicleLab.snp.bottom).offset(20)
        }
        timeLab.snp.makeConstraints { make in
            make.top.equalTo(timeTipLab)
            make.left.equalTo(sendTypeTipLab.snp.right).offset(32)
            make.bottom.equalTo(bgView).inset(20)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

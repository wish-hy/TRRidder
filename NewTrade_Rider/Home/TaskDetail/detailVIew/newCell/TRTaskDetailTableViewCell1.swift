//
//  TRTaskDetailTableViewCell1.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit
import RxCocoa
import RxSwift
// 新任务的cell
class TRTaskDetailTableViewCell1: UITableViewCell {
    var upView : UIView!
    var typeView : UIButton!
    var timeLab : UILabel!
    var priceLab : UILabel!
    
    var startDistanceLab : UILabel!
    var startNameLab : UILabel!
    var startLocLab : UILabel!
    
    var endDistanceLab : UILabel!
    var endNameLab : UILabel!
    
    var startLocBtn : UIButton!
    var endLocBtn : UIButton!
    
    var userInfoLab : UILabel!
    var bgView : UIView!
    var doneLab : UILabel!
    var fromLab : UILabel!
    var toLab : UILabel!
    private var df : DateFormatter!
    var model : TROrderModel? {
        didSet {
            guard let model = model else { return }
            timeLab.text = "\(model.estimateTime)分钟内"
            startNameLab.text = model.senderAddress
            startLocLab.text = model.senderAreaAddress
            

            
            startDistanceLab.text = model.storeDistance.replacingOccurrences(of: "km", with: "\nkm")
            endNameLab.text = model.receiverAddress
            userInfoLab.text = model.receiverName + " \(model.receiverPhone) "

            endDistanceLab.text = model.memberDistance.replacingOccurrences(of: "km", with: "\nkm")
            priceLab.text = model.deliverAmount
//            priceLab.text = "#" + model.currentDayReceiveOrderNum
            if model.deliveryType.elementsEqual("LOCAL_DEL_GOODS") {
                fromLab.text = "装货"
                toLab.text = "卸货"
            } else {
                fromLab.text = "取货"
                toLab.text = "送达"
            }
            if model.timelinessType.elementsEqual("RESERVE") {
                if model.deliveryType.elementsEqual("MALL") {
                    if model.estimateBeginTime.count > 18  && model.estimateEndTime.count > 18{
                        let st = (model.estimateBeginTime as NSString).substring(with: .init(location: 5, length: 11))
                        let et = (model.estimateEndTime as NSString).substring(with: .init(location: 5, length: 11))
                        
                        timeLab.text = st + "~" + et
                        
                    } else {
                        timeLab.text = model.estimateTime + "分钟内"
                    }
                } else {
                    if model.pickUpStartTime.count > 18  && model.pickUpEndTime.count > 18{
                        let st = (model.pickUpStartTime as NSString).substring(with: .init(location: 5, length: 11))
                        let et = (model.pickUpEndTime as NSString).substring(with: .init(location: 5, length: 11))
                        
                        timeLab.text = st + "~" + et
                    } else {
                        timeLab.text = model.estimateTime + "分钟内"
                    }
                }
                typeView.setTitle("预", for: .normal)
                typeView.setImage(nil, for: .normal)
                typeView.backgroundColor = .hexColor(hexValue: 0x23B1F5)
                timeLab.textColor = .hexColor(hexValue: 0x23B1F5)
                
            } else {
                
                typeView.setImage(UIImage(named: "home_time"), for: .normal)
                typeView.setTitle(nil, for: .normal)
                typeView.backgroundColor = .white
                if model.deliveryType.elementsEqual("MALL"){
                if !model.estimateTime.elementsEqual("0") {
                    timeLab.text = model.estimateTime + "分钟内"
                    timeLab.textColor = .hexColor(hexValue: 0xFF652F)
                } else {
                    let now = Date()
                    let endTime = df.date(from: model.estimateEndTime)
                    if endTime != nil {
                        var diff = endTime!.distance(to: now) / 60
                        if diff <= 0 {
                            diff = 1
                        }
                        timeLab.text = "已超时\((Int64)(diff))分钟"
                        doneLab.isHidden = true
                    } else {
                        timeLab.text = "已超时"
                        doneLab.isHidden = true
                    }
                    timeLab.textColor = .hexColor(hexValue: 0xFF652F)
                }
            }else{
                timeLab.text = "立即取货"
                doneLab.isHidden = true
                timeLab.textColor = UIColor.hexColor(hexValue: 0x141414)
            }
            }
        }
    }
    var block : Int_Block?
    var bag = DisposeBag()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        setupView()
        setAction()
    }
    private func setAction(){
        startLocBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self else { return }

            if block != nil {
                block!(1)
            }
        }).disposed(by: bag)
        
        endLocBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self else { return  }

            if block != nil {
                block!(2)
            }
        }).disposed(by: bag)
    }
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 13, height: 13))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer;
        contentView.addSubview(bgView)
        
        upView = UIView()
        upView.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        upView.layer.cornerRadius = 3
        upView.layer.masksToBounds = true
        bgView.addSubview(upView)
        
        typeView = UIButton()
        typeView.isEnabled = false
        typeView.setImage(UIImage(named: "home_time"), for: .normal)
        bgView.addSubview(typeView)
        
        timeLab = UILabel()
        timeLab.text = "--分钟内"
        timeLab.textColor = UIColor.hexColor(hexValue: 0xFF652F)
        timeLab.font = UIFont.trBoldFont(fontSize: 14)
        bgView.addSubview(timeLab)
        
        doneLab = UILabel()
        doneLab.text = "送达"
        doneLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        doneLab.font = UIFont.trFont(fontSize: 14)
        bgView.addSubview(doneLab)
        
        let priceUnitLab = UILabel()
        priceUnitLab.text = "¥"
        priceUnitLab.textColor = UIColor.hexColor(hexValue: 0xFF652F)
        priceUnitLab.font = UIFont.trBoldFont(fontSize: 14)
        bgView.addSubview(priceUnitLab)
        
        priceLab = UILabel()
        priceLab.text = "--"
        priceLab.textColor = UIColor.hexColor(hexValue: 0xFF652F)
        priceLab.font = UIFont.trBoldFont(fontSize: 23)
        bgView.addSubview(priceLab)
        
        let line = UIView()
        line.backgroundColor = .white
        bgView.addSubview(line)
        
        startDistanceLab = UILabel()
        startDistanceLab.text = "-\nkm"
        
        startDistanceLab.textAlignment = .center
        startDistanceLab.numberOfLines = 0
        startDistanceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        startDistanceLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(startDistanceLab)
        
        fromLab = UILabel()
        fromLab.text = "取货"
        fromLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        fromLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(fromLab)
        
        startNameLab = UILabel()
        startNameLab.text = "起送地址"
        startNameLab.numberOfLines = 0
        startNameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        startNameLab.font = UIFont.trBoldFont(fontSize: 17)
        bgView.addSubview(startNameLab)
        
        startLocLab = UILabel()
        startLocLab.text = "起送详细地址"
        startLocLab.numberOfLines = 0
        startLocLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        startLocLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(startLocLab)
        
        let distanceLine = UIView(frame: .zero)
        distanceLine.backgroundColor = UIColor.hexColor(hexValue: 0xD2D5D7)
        bgView.addSubview(distanceLine)
        
        endDistanceLab = UILabel()
        endDistanceLab.text = "-\nkm"
        endDistanceLab.numberOfLines = 0
        endDistanceLab.textAlignment = .center
        endDistanceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        endDistanceLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(endDistanceLab)
        
        toLab = UILabel()
        toLab.text = "送达"
        toLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        toLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(toLab)
        
        endNameLab = UILabel()
        endNameLab.text = "终点"
        endNameLab.numberOfLines = 0
        endNameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        endNameLab.font = UIFont.trBoldFont(fontSize: 17)
        bgView.addSubview(endNameLab)

        userInfoLab = UILabel()
        userInfoLab.text = "---"
        userInfoLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        userInfoLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(userInfoLab)
        
        startLocBtn = UIButton()
        startLocBtn.setImage(UIImage(named: "navigation_green"), for: .normal)
        startLocBtn.backgroundColor = UIColor.hexColor(hexValue: 0xDFFDEC)
        startLocBtn.layer.cornerRadius = 17
        startLocBtn.layer.masksToBounds = true
        contentView.addSubview(startLocBtn)
 
        endLocBtn = UIButton()
        endLocBtn.setImage(UIImage(named: "navigation_green"), for: .normal)
        endLocBtn.backgroundColor = UIColor.hexColor(hexValue: 0xDFFDEC)
        endLocBtn.layer.cornerRadius = 17
        endLocBtn.layer.masksToBounds = true
        contentView.addSubview(endLocBtn)
//        contentView.backgroundColor = .brown
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(0)
            make.left.right.equalTo(contentView).inset(0)
//            make.height.equalTo(236)
            make.bottom.equalTo(contentView)
        }
        upView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(bgView).offset(10)
            make.height.equalTo(5)
            make.width.equalTo(38)
        }
        typeView.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(14)
            make.top.equalTo(bgView).offset(38)
            make.height.width.equalTo(38)
        }
        timeLab.snp.makeConstraints { make in
            make.centerY.equalTo(typeView)
            make.left.equalTo(typeView.snp.right).offset(2)
        }
        doneLab.snp.makeConstraints { make in
            make.left.equalTo(timeLab.snp.right).offset(2)
            make.centerY.equalTo(typeView)
        }
        
        priceUnitLab.snp.makeConstraints { make in
            make.right.equalTo(priceLab.snp.left).offset(-2)
            make.centerY.equalTo(typeView).offset(4)
        }
        priceLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(21)
            make.centerY.equalTo(typeView)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(typeView.snp.bottom).offset(0)
            make.height.equalTo(1)
        }
        startDistanceLab.snp.makeConstraints { make in
            make.left.equalTo(line)
            make.top.equalTo(line.snp.bottom).offset(19)
        }
        fromLab.snp.makeConstraints { make in
            make.centerX.equalTo(startDistanceLab)
            make.top.equalTo(startDistanceLab.snp.bottom).offset(2)
        }
        startNameLab.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.right.equalTo(bgView).inset(85)
            make.left.equalTo(bgView).offset(60)
        }
        startLocLab.snp.makeConstraints { make in
            make.top.equalTo(startNameLab.snp.bottom).offset(5)
            make.right.equalTo(bgView).inset(85)
            make.left.equalTo(startNameLab)
        }
        
        endDistanceLab.snp.makeConstraints { make in
            make.left.equalTo(startDistanceLab)
            make.top.equalTo(fromLab.snp.bottom).offset(52)
        }
        endNameLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.right.equalTo(bgView).inset(85)
            make.top.equalTo(endDistanceLab)
        }
        toLab.snp.makeConstraints { make in
            make.left.equalTo(fromLab)
            make.top.equalTo(endDistanceLab.snp.bottom).offset(2)
        }
        

        distanceLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(fromLab.snp.bottom).offset(5)
            make.bottom.equalTo(endDistanceLab.snp.top).offset(-5)
            make.centerX.equalTo(fromLab)
        }

        userInfoLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.top.equalTo(endNameLab.snp.bottom).offset(7)
            make.bottom.equalTo(bgView).inset(13)
        }
        
        startLocBtn.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.right.equalTo(bgView).inset(16)
            make.top.equalTo(startNameLab)
        }
        endLocBtn.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.right.equalTo(bgView).inset(16)
            make.top.equalTo(endNameLab)
        }
        
        
//        contentView.layoutSubviews()
//        contentView.layoutIfNeeded()
//        distanceLine.drawDashLine(strokeColor: .red, lineWidth: 1, lineLength: 100, lineSpacing: 6)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

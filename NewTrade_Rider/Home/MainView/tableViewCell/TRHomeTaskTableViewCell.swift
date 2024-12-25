//
//  TRHomeTaskTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/6.
//

import UIKit
import RxCocoa
import RxSwift
class TRHomeTaskTableViewCell: UITableViewCell {
    
    var typeView : UIButton!
    var timeLab : UILabel!
    var priceLab : UILabel!
    
    var startDistanceLab : UILabel!
    var startNameLab : UILabel!
    var startLocLab : UILabel!
    
    var endDistanceLab : UILabel!
    var endNameLab : UILabel!
    
    var infoLab : UILabel!
    var infoLab1 : UILabel!
    var infoLab2 : UILabel!
    var fromLab : UILabel!
    var orderBtn : UIButton!
    
    var bgView : UIView!
    var doneLab : UILabel!
    
    private var df : DateFormatter!
    
    var model : TROrderModel? {
        didSet {
            guard let model = model else { return }
            startNameLab.text = model.senderName
            startLocLab.text = model.senderAddress
            endNameLab.text = model.receiverAreaAddress + model.receiverAddress
            
            let sd = Double.init(model.storeDistance)
            if sd == nil {
                startDistanceLab.text = model.storeDistance
            } else {
                
                if sd! < 10 {
                    startDistanceLab.text = "\(sd!)\nm"
                    if sd! <= 0 {
                        startDistanceLab.text = "<20m"
                    }
                } else {
                    startDistanceLab.text = String.init(format: "%.2f\nkm", sd! / 1000)
                }
            }
            
            let md = Double.init(model.memberDistance)
            if md == nil {
                endDistanceLab.text = model.memberDistance
            } else {
                if md! < 10 {
                    endDistanceLab.text = "\(md!)\nm"
                    if md! <= 0 {
                        endDistanceLab.text = "<20m"
                    }
                } else {
                    endDistanceLab.text = String.init(format: "%.2f\nkm", md! / 1000)
                }
            }
            priceLab.attributedText = TRTool.richText(str1: "¥", font1: .trBoldFont(14), color1: .hexColor(hexValue: 0xFF652F), str2: model.deliverAmount, font2: .trBoldFont(18), color2: .hexColor(hexValue: 0xFF652F))

            if model.deliveryType.elementsEqual("MALL"){
                // 商城
                fromLab.text = "取货"
                doneLab.text = "送达"
                infoLab.text = "商城配送"
                infoLab.backgroundColor = .themeColor()
            }else if model.deliveryType.elementsEqual("LOCAL_DEL_GOODS"){
                // 同城送货
                fromLab.text = "装货"
                doneLab.text = "卸货"
                infoLab.text = "同城送货"
            }else if model.deliveryType.elementsEqual("LOCAL_FAST_DEL"){
                // 同城跑腿
                fromLab.text = "取货"
                doneLab.text = "送达"
                infoLab.text = "同城跑腿"
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
                doneLab.isHidden = false
            } else {
                typeView.setImage(UIImage(named: "home_time"), for: .normal)
                typeView.setTitle(nil, for: .normal)
                typeView.backgroundColor = .white
                if model.deliveryType.elementsEqual("MALL") {
                    // 商场配送 显示时间
                    infoLab2.isHidden = false
                    infoLab1.text = " \(model.ptName) "
                    infoLab1.textColor = .white
                    infoLab1.backgroundColor = .hexColor(hexValue: 0xFA651F)
                    
                    infoLab2.backgroundColor = .white
                    infoLab2.textColor = UIColor.hexColor(hexValue: 0x23B1F5 )
                    infoLab2.layer.borderColor = UIColor.hexColor(hexValue: 0x23B1F5 ).cgColor
                    if model.weight < 1000 {
                        infoLab2.text = " \(model.weight)g "
                    } else {
                        infoLab2.text = String.init(format: " %.2fkg ", model.weight / 1000)
                    }
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
                }
                else if model.deliveryType.elementsEqual("LOCAL_FAST_DEL") {
                    // 同城跑腿  立即取货
                    infoLab.backgroundColor = .hexColor(hexValue: 0xFF652F)
                    infoLab2.isHidden = false
                    infoLab1.text = " \(model.ptName) "
                    infoLab1.textColor = .white
                    infoLab1.backgroundColor = .hexColor(hexValue: 0xFA651F)
                    
                    infoLab2.backgroundColor = .white
                    infoLab2.textColor = UIColor.hexColor(hexValue: 0x23B1F5 )
                    infoLab2.layer.borderColor = UIColor.hexColor(hexValue: 0x23B1F5 ).cgColor
                    if model.weight < 1000 {
                        infoLab2.text = " \(model.weight)g "
                    } else {
                        infoLab2.text = String.init(format: " %.2fkg ", model.weight / 1000)
                    }
                    timeLab.text = "立即取货"
                    timeLab.textColor = UIColor.hexColor(hexValue: 0x141414)
                } else {
                    timeLab.text = "立即取货"
                    timeLab.textColor = UIColor.hexColor(hexValue: 0x141414)
                    infoLab2.isHidden = false
                    infoLab1.backgroundColor = .hexColor(hexValue: 0xFA651F)
                    infoLab1.text = " \(model.ptName) "
                    infoLab1.textColor = .white
                    
                    infoLab2.backgroundColor = .white
                    infoLab2.textColor = UIColor.hexColor(hexValue: 0x23B1F5 )
                    infoLab2.layer.borderColor = UIColor.hexColor(hexValue: 0x23B1F5 ).cgColor
                    if model.weight < 1000 {
                        infoLab2.text = " \(model.weight)g "
                    } else {
                        infoLab2.text = String.init(format: " %.2fkg ", model.weight / 1000)
                    }
                }
            }

        }
    }
    
    
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
        orderBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self  = self  else { return  }
            let vc = TRTaskDetailViewController()
            vc.model = model
            vc.hidesBottomBarWhenPushed = true
            self.viewController()?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
    }
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 13
        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
        
        typeView = UIButton()
        typeView.titleLabel?.font = .trFont(12.5)
        typeView.trCorner(3)
        typeView.isEnabled = false
        typeView.setImage(UIImage(named: "home_time"), for: .normal)
        bgView.addSubview(typeView)
        
        timeLab = UILabel()
        timeLab.text = "20分钟内"
        timeLab.font = UIFont.trBoldFont(fontSize: 14)
        bgView.addSubview(timeLab)
        
        doneLab = UILabel()
        doneLab.text = ""
        doneLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        doneLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(doneLab)
        
//        let priceUnitLab = UILabel()
//        priceUnitLab.text = "¥"
//        priceUnitLab.textColor = UIColor.hexColor(hexValue: 0xFF652F)
//        priceUnitLab.font = UIFont.trBoldFont(fontSize: 14)
//        bgView.addSubview(priceUnitLab)
        
        priceLab = UILabel()
        priceLab.text = "999.9"
        priceLab.textColor = .hexColor(hexValue: 0xFF652F)
        priceLab.font = UIFont.trBoldFont(fontSize: 18)
        bgView.addSubview(priceLab)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        
        bgView.addSubview(line)
        startDistanceLab = UILabel()
        startDistanceLab.text = "10\nkm"
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
        startNameLab.text = "农批市场"
        startNameLab.numberOfLines = 0
        startNameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        startNameLab.font = UIFont.trBoldFont(fontSize: 17)
        bgView.addSubview(startNameLab)
        
        startLocLab = UILabel()
        startLocLab.text = "宝安区环球一路洪浪北社区999号D 栋4宝安区环球一路洪浪北社区999号D 栋4"
        startLocLab.numberOfLines = 0
        startLocLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        startLocLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(startLocLab)
        
        let distanceLine = UIView(frame: .zero)
        distanceLine.backgroundColor = UIColor.hexColor(hexValue: 0xD2D5D7)
        bgView.addSubview(distanceLine)
        
        endDistanceLab = UILabel()
        endDistanceLab.text = "8\nkm"
        endDistanceLab.numberOfLines = 0
        endDistanceLab.textAlignment = .center
        endDistanceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        endDistanceLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(endDistanceLab)
        
//        let toLab = UILabel()
//        toLab.text = "送达"
//        toLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
//        toLab.font = UIFont.trFont(fontSize: 12)
//        bgView.addSubview(toLab)
        
        endNameLab = UILabel()
        endNameLab.text = "南山区粤海街道东方科技大厦 2498"
        endNameLab.numberOfLines = 0
        endNameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        endNameLab.font = UIFont.trBoldFont(fontSize: 17)
        bgView.addSubview(endNameLab)
        
        
        infoLab = UILabel()
                
        infoLab.text = " 送建材 "
        infoLab.trCorner(f: 3)

        infoLab.backgroundColor = .themeColor()
//        infoLab1.layer.borderColor = UIColor.hexColor(hexValue: 0xFF652F).cgColor
//        infoLab1.layer.borderWidth = 0.5
        infoLab.textColor = .white
        infoLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(infoLab)
        
        infoLab1 = UILabel()
                
        infoLab1.text = " 送建材 "
        infoLab1.trCorner(f: 3)

        infoLab1.backgroundColor = .themeColor()
//        infoLab1.layer.borderColor = UIColor.hexColor(hexValue: 0xFF652F).cgColor
//        infoLab1.layer.borderWidth = 0.5
        infoLab1.textColor = .white
        infoLab1.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(infoLab1)
        
        infoLab2 = UILabel()
        infoLab2.text = " 约50kg "
        infoLab2.layer.cornerRadius = 3
        infoLab2.layer.masksToBounds = true
        infoLab2.layer.borderColor = UIColor.hexColor(hexValue: 0x23B1F5 ).cgColor
        infoLab2.layer.borderWidth = 0.5
        infoLab2.textColor = UIColor.hexColor(hexValue: 0x23B1F5 )
        infoLab2.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(infoLab2)
        
        orderBtn = UIButton()
        orderBtn.isUserInteractionEnabled = false
        orderBtn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        orderBtn.layer.cornerRadius = 23 * TRHeightScale
        orderBtn.layer.masksToBounds = true
        orderBtn.setTitleColor(.white, for: .normal)
        orderBtn.setTitle("抢单", for: .normal)

        orderBtn.titleLabel?.font = UIFont.trBoldFont(fontSize: 18)
        bgView.addSubview(orderBtn)
//        contentView.backgroundColor = .brown
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15 * TRWidthScale)
            make.left.right.equalTo(contentView).inset(15 * TRWidthScale)
            make.bottom.equalTo(contentView)
        }
        typeView.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(14)
            make.top.equalTo(bgView).offset(18)
            make.height.width.equalTo(18)
        }
        timeLab.snp.makeConstraints { make in
            make.centerY.equalTo(typeView)
            make.left.equalTo(typeView.snp.right).offset(2)
        }
        doneLab.snp.makeConstraints { make in
            make.left.equalTo(fromLab)
            make.top.equalTo(endDistanceLab.snp.bottom).offset(2)
        }
        
//        priceUnitLab.snp.makeConstraints { make in
//            make.right.equalTo(priceLab.snp.left).offset(-2)
//            make.centerY.equalTo(typeView).offset(4)
//        }
        priceLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(21)
            make.centerY.equalTo(typeView)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(typeView.snp.bottom).offset(20)
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
            make.right.equalTo(bgView).inset(18)
            make.left.equalTo(bgView).offset(60)
        }
        startLocLab.snp.makeConstraints { make in
            make.top.equalTo(fromLab)
            make.right.equalTo(bgView).inset(18)
            make.left.equalTo(startNameLab)
        }
        
        endDistanceLab.snp.makeConstraints { make in
            make.left.equalTo(startDistanceLab)
            make.top.equalTo(fromLab.snp.bottom).offset(52)
        }
        endNameLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.right.equalTo(bgView).inset(18)
            make.top.equalTo(endDistanceLab)
        }
//        toLab.snp.makeConstraints { make in
//            make.left.equalTo(fromLab)
//            make.top.equalTo(endDistanceLab.snp.bottom).offset(2)
//        }
        infoLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.top.equalTo(endNameLab.snp.bottom).offset(5)
            make.height.equalTo(18)
        }
        infoLab1.snp.makeConstraints { make in
            make.left.equalTo(infoLab.snp.right).offset(12)
            make.top.equalTo(infoLab)
            make.height.equalTo(18)
        }
        infoLab2.snp.makeConstraints { make in
            make.left.equalTo(infoLab1.snp.right).offset(12)
            make.top.equalTo(infoLab)
            make.height.equalTo(18)
        }
        distanceLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(fromLab.snp.bottom).offset(5)
            make.bottom.equalTo(endDistanceLab.snp.top).offset(-5)
            make.centerX.equalTo(fromLab)
        }
        orderBtn.snp.makeConstraints { make in
            make.left.right.equalTo(line)
            make.bottom.equalTo(bgView).inset(20)
            make.top.equalTo(infoLab2.snp.bottom).offset(20)
            make.height.equalTo(46 * TRHeightScale)
        }
        
//        contentView.layoutSubviews()
//        contentView.layoutIfNeeded()
//        distanceLine.drawDashLine(strokeColor: .red, lineWidth: 1, lineLength: 100, lineSpacing: 6)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

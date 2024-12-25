//
//  TRPickupTableViewCell1.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit
import RxCocoa
import RxSwift
// 待配送cell
class TRPickupTableViewCell1: UITableViewCell {
    
    var upView : UIView!
    
    var typeView : UIButton!
    var timeLab : UILabel!
    var priceLab : UILabel!
    
    var quLab : UILabel!
    var startNameLab : UILabel!
    var startLocLab : UILabel!
    
    var songLab : UILabel!
    var endNameLab : UILabel!
    
    var startLocBtn : UIButton!
    var endLocBtn : UIButton!

    var userInfoLab : UILabel!
    
    var  distanceLab : UILabel!
    
    //差价
    //专送标签
    var specDelView : UIView!
    var bgView : UIView!
    
    var doneLab : UILabel!
    private var df : DateFormatter!
    var block : Int_Block?
    var bag = DisposeBag()
    var model : TROrderModel? {
        didSet {
            guard let model = model else { return }
            startNameLab.text = model.senderAddress
            startLocLab.text = model.senderAreaAddress
            doneLab.isHidden = false
            if model.riderTypeDesc.elementsEqual("普通"){
                specDelView.isHidden = true
            }
            
            let dm = Double.init(model.deliveryDistance)
            if dm != nil {
                if dm! < 1000 {
                    distanceLab.text = "\(dm!)\nm"
                    if dm! <= 0 {
                        distanceLab.text = "<20\nm"
                    }
                } else {
                    distanceLab.text = String.init(format: "%.2f\nkm", dm! / 1000)
                }
            } else {
                    distanceLab.text = model.deliveryDistance
            }
            endNameLab.text = model.receiverAddress
            userInfoLab.text = model.receiverName + " \(model.receiverPhone) "
//            if model.memberDistance < 1000 {
//                endDistanceLab.text = "\(model.memberDistance)\nm"
//            } else {
//                endDistanceLab.text = String.init(format: "%.2f\nkm", model.memberDistance / 1000)
//            }
            
            
//            infoLab1.text = " \(model.ptName) "
//            if model.weight < 1000 {
//                infoLab2.text = " \(model.weight)g "
//            } else {
//                infoLab2.text = String.init(format: " %.2fkg ", model.weight / 1000)
//            }
            //商城外卖 MALL,LOCAL_FAST_DEL,LOCAL_DEL_GOODS
            if model.deliveryType.elementsEqual("MALL") {
                quLab.backgroundColor = .hexColor(hexValue: 0xFF652F)
                songLab.backgroundColor = .hexColor(hexValue: 0xEAECED)
                quLab.text = "取"
                songLab.text = "送"
            //同城送货
            } else if model.deliveryType.elementsEqual("LOCAL_DEL_GOODS") {
                quLab.backgroundColor = .hexColor(hexValue: 0x2044C9)
                songLab.backgroundColor = .hexColor(hexValue: 0xEAECED)
                quLab.text = "装"
                songLab.text = "卸"
            } else if model.deliveryType.elementsEqual("LOCAL_FAST_DEL") {
                quLab.backgroundColor = .hexColor(hexValue: 0xFF652F)
                songLab.backgroundColor = .hexColor(hexValue: 0xEAECED)
                quLab.text = "取"
                songLab.text = "送"
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
//                timeLab.textColor = .hexColor(hexValue: 0x23B1F5)
                
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
            
            if model.subType == 2 {
                priceLab.attributedText = TRTool.richText(str1: "补差价", font1: .trFont(14), color1: .txtColor(), str2: "¥" + model.subOrder.payAmount, font2: .trMediumFont(17), color2: .hexColor(hexValue: 0xF54444))
            } else {
//                priceLab.text = ""
                priceLab.text = "#" + model.currentDayReceiveOrderNum
            }
        }
    }
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
            guard let self = self else { return }

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
        timeLab.text = "20分钟内"
        timeLab.textColor = UIColor.hexColor(hexValue: 0xFF652F)
        timeLab.font = UIFont.trBoldFont(fontSize: 14)
        bgView.addSubview(timeLab)
        
        doneLab = UILabel()
        doneLab.text = "送达"
        doneLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        doneLab.font = UIFont.trFont(fontSize: 14)
        bgView.addSubview(doneLab)
        
        distanceLab = UILabel()
        distanceLab.text = "20\nKM"
        distanceLab.textAlignment = .center
        distanceLab.numberOfLines = 0
        distanceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        distanceLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(distanceLab)
        
        priceLab = UILabel()
        priceLab.text = "#01"
        priceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        priceLab.font = UIFont.trBoldFont(fontSize: 23)
        bgView.addSubview(priceLab)
        
        specDelView = configSpecView()
//        bgView.addSubview(specDelView)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        bgView.addSubview(line)
    
        
        quLab = UILabel()
        quLab.text = "取"
        quLab.trCorner(2)
        quLab.textAlignment = .center
        quLab.numberOfLines = 0
        quLab.textColor = .white
        quLab.backgroundColor = UIColor.hexColor(hexValue: 0xFF652F)
        quLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(quLab)
        
        let contactLab = UILabel()
        contactLab.text = "联系"
        contactLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        contactLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(contactLab)
        
        startNameLab = UILabel()
        startNameLab.text = "农批市场"
        startNameLab.numberOfLines = 0
        startNameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        startNameLab.font = UIFont.trBoldFont(fontSize: 20)
        bgView.addSubview(startNameLab)
        
        startLocLab = UILabel()
        startLocLab.text = "栋4宝安区环球一路洪浪北社区999号D 栋4"
        startLocLab.numberOfLines = 0
        startLocLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        startLocLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(startLocLab)
        
        let distanceLine = UIView(frame: .zero)
        distanceLine.backgroundColor = UIColor.hexColor(hexValue: 0xD2D5D7)
        bgView.addSubview(distanceLine)
        
        let distanceLine2 = UIView()
        distanceLine2.backgroundColor = UIColor.hexColor(hexValue: 0xD2D5D7)
        bgView.addSubview(distanceLine2)
        
        songLab = UILabel()
        songLab.text = "送"
        songLab.trCorner(2)
        songLab.numberOfLines = 0
        songLab.textAlignment = .center
        songLab.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        songLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        songLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(songLab)
        
        
        endNameLab = UILabel()
        endNameLab.text = "南山区粤海街道东方科技大厦 2498"
        endNameLab.numberOfLines = 0
        endNameLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        endNameLab.font = UIFont.trBoldFont(fontSize: 16)
        bgView.addSubview(endNameLab)
        
        userInfoLab = UILabel()
        
        userInfoLab.text = "刘**(女士)"
        userInfoLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        userInfoLab.font = UIFont.trFont(fontSize: 13)
        bgView.addSubview(userInfoLab)
        

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
        // width: 44, height: 18)
//        specDelView.snp.makeConstraints { make in
//            make.right.equalTo(priceLab)
//            make.centerY.equalTo(priceLab)
//            make.size.equalTo(CGSize(width: 44, height: 18))
//        }
        
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
            make.height.width.equalTo(18)
        }
        timeLab.snp.makeConstraints { make in
            make.centerY.equalTo(typeView)
            make.left.equalTo(typeView.snp.right).offset(2)
        }
        doneLab.snp.makeConstraints { make in
            make.left.equalTo(timeLab.snp.right).offset(2)
            make.centerY.equalTo(typeView)
        }
        
        
        priceLab.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(21)
            make.centerY.equalTo(typeView)
        }
        
        quLab.snp.makeConstraints { make in
            make.left.equalTo(line)
            make.height.width.equalTo(18)
            make.top.equalTo(line.snp.bottom).offset(19)
        }
        //横线
        line.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(typeView.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        distanceLab.snp.makeConstraints { make in
            make.centerX.equalTo(quLab)
            make.top.equalTo(quLab.snp.bottom).offset(26)
        }
 
        startNameLab.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.right.equalTo(bgView).inset(85)
            make.left.equalTo(bgView).offset(50)
        }
        startLocLab.snp.makeConstraints { make in
            make.top.equalTo(startNameLab.snp.bottom).offset(5)
            make.right.equalTo(bgView).inset(85)
            make.left.equalTo(startNameLab)
        }
        
        songLab.snp.makeConstraints { make in
            make.left.equalTo(quLab)
            make.height.width.equalTo(18)
            make.top.equalTo(startLocLab.snp.bottom).offset(26)
        }
        endNameLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.right.equalTo(bgView).inset(85)
            make.top.equalTo(startLocLab.snp.bottom).offset(26)
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
            make.top.equalTo(songLab)
        }
        
        distanceLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(quLab.snp.bottom).offset(3)
            make.bottom.equalTo(distanceLab.snp.top).offset(-3)
            make.centerX.equalTo(quLab)
        }
        distanceLine2.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(distanceLab.snp.bottom).offset(3)
            make.bottom.equalTo(songLab.snp.top).offset(-3)
            make.centerX.equalTo(quLab)
        }


    }
    
    private func configSpecView()->UIView{
        let layerView = UIView()
        layerView.trCorner(2)
        layerView.frame = CGRect(x: 0, y: 0, width: 44, height: 18)
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 0.92, green: 0.67, blue: 0.36, alpha: 1).cgColor, UIColor(red: 0.85, green: 0.44, blue: 0.26, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = layerView.bounds
        bgLayer1.startPoint = CGPoint(x: 0, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
        layerView.layer.addSublayer(bgLayer1)
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 44, height: 18), byRoundingCorners: [.topRight, .bottomLeft], cornerRadii: CGSize(width: 6, height: 6))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layerView.layer.mask = maskLayer;
        
        
        let icon = UIImageView(image: UIImage(named: "order_spec"))
        layerView.addSubview(icon)
        
        
        let lab = TRFactory.labelWith(font: .trFont(10), text: "专送", textColor: .hexColor(hexValue: 0xFFFAC7), superView: layerView)
        
        layerView.addSubview(lab)
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(layerView).offset(4)
            make.centerY.equalTo(layerView)
            make.height.width.equalTo(12)
        }
        lab.snp.makeConstraints { make in
            make.centerY.equalTo(layerView)
            make.left.equalTo(icon.snp.right).offset(1)
        }
        
        return layerView
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

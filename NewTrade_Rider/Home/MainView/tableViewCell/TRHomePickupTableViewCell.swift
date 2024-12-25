//
//  TRHomePickupTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit
import RxCocoa
import RxSwift
class TRHomePickupTableViewCell: UITableViewCell {
    
    var typeView : UIButton!
    var timeLab : UILabel!
    var priceLab : UILabel!
    
    var quLab : UILabel!
    var startNameLab : UILabel!
    var startLocLab : UILabel!
    
    var songLab : UILabel!
    var endNameLab : UILabel!

    var distanceLab : UILabel!
    var contactBtn : UIButton!
    var dhBtn : UIButton!
    
    var infoLab : UILabel!
    var infoLab1 : UILabel!
    var infoLab2 : UILabel!
    
    var pickupBtn : UIButton!
    var startPoint : AMapNaviPoint?
    var bgView : UIView!
    var doneLab : UILabel!
    private var df : DateFormatter!
    var bag = DisposeBag()
    var model : TROrderModel? {
        didSet {
            guard let model = model else { return }
            startNameLab.text = model.senderName
            startLocLab.text = model.senderAddress
            endNameLab.text = model.receiverAreaAddress + model.receiverAddress
            doneLab.isHidden = false
//            if model.deliveryDistance < 1000 {
//                distanceLab.text = "\(model.deliveryDistance)\nm"
//                if model.deliveryDistance <= 0 {
//                    distanceLab.text = "<20m"
//                }
//            } else {
//                distanceLab.text = String.init(format: "%.2f\nkm", model.deliveryDistance / 1000)
//            }
            
            let dd = Double.init(model.deliveryDistance)
            if dd == nil {
                distanceLab.text = model.deliveryDistance
            } else {
                
                if dd! < 10 {
                    distanceLab.text = "\(dd!)\nm"
                    if dd! <= 0 {
                        distanceLab.text = "<20m"
                    }
                } else {
                    distanceLab.text = String.init(format: "%.2f\nkm", dd! / 1000)
                }
            }
            
            
//            priceLab.attributedText = TRTool.richText(str1: "¥", font1: .trBoldFont(14), color1: .hexColor(hexValue: 0xFF652F), str2: model.currentDayReceiveOrderNum, font2: .trBoldFont(18), color2: .hexColor(hexValue: 0xFF652F))
            priceLab.text = "#" + model.currentDayReceiveOrderNum
            

            // LOCAL_FAST_DEL LOCAL_DEL_GOODS MALL

            if model.deliveryType.elementsEqual("MALL") {
                quLab.text = "取"
                songLab.text = "送"
                quLab.backgroundColor = UIColor.hexColor(hexValue: 0xFF652F )
                songLab.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED )
                infoLab2.isHidden = false
                infoLab.backgroundColor = .themeColor()
                infoLab.text = " 商城配送 "
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
                
            } else if model.deliveryType.elementsEqual("LOCAL_FAST_DEL") {
                quLab.text = "取"
                songLab.text = "送"
                quLab.backgroundColor = UIColor.hexColor(hexValue: 0xFF652F )
                songLab.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED )
                infoLab.backgroundColor = .hexColor(hexValue: 0xFF652F)

                infoLab2.isHidden = false
                infoLab.backgroundColor = .themeColor()
                infoLab.text = " 同城跑腿 "
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
            } else {
                //送货
                quLab.text = "装"
                songLab.text = "卸"
                quLab.backgroundColor = UIColor.hexColor(hexValue:0x2044C9 )
                infoLab.text = " 同城送货 "
                infoLab.backgroundColor = .hexColor(hexValue: 0x2044C9)
                
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
            
            /*
             0:可以补差价
             1:不可以补差价
             2:补差价待支付

             */
            if model.subType == 2 {
                pickupBtn.setTitle("等待用户支付差价", for: .normal)
                pickupBtn.backgroundColor = .hexColor(hexValue: 0xF1F3F4)
                pickupBtn.setTitleColor(.hexColor(hexValue: 0xF54444), for: .normal)
            } else {
                pickupBtn.setTitle("取货", for: .normal)
                pickupBtn.backgroundColor = .hexColor(hexValue: 0xFA651F)
                pickupBtn.setTitleColor(.white, for: .normal)
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
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
        pickupBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self  = self  else { return  }
            let vc = TRTaskDetailViewController()
            let model = model
            vc.model = model
            vc.type = 2
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
        typeView.isEnabled = false
        typeView.titleLabel?.font = .trFont(12.5)
        typeView.trCorner(3)
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
        distanceLab.numberOfLines = 0
        distanceLab.textAlignment = .center
        distanceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        distanceLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(distanceLab)
        
        priceLab = UILabel()
        priceLab.text = "¥0.1"
        priceLab.textColor = .txtColor()
        priceLab.font = UIFont.trBoldFont(fontSize: 18)
        bgView.addSubview(priceLab)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        bgView.addSubview(line)
    
        
        quLab = UILabel()
        quLab.text = "取"
        quLab.trCorner(3)
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
        startLocLab.text = "宝安区环球一路洪浪北社区999号D 栋4宝安区环球一路洪浪北社区999号D 栋4"
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
        songLab.trCorner(3)
        songLab.numberOfLines = 0
        songLab.textAlignment = .center
        songLab.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        songLab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        songLab.font = UIFont.trBoldFont(fontSize: 13)
        bgView.addSubview(songLab)
        
        let dhLab = UILabel()
        dhLab.text = "导航"
        dhLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        dhLab.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(dhLab)
        
        endNameLab = UILabel()
        endNameLab.text = "南山区粤海街道东方科技大厦 2498"
        endNameLab.numberOfLines = 0
        endNameLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
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
        // 0xFA651F
        infoLab1.layer.borderColor = UIColor.hexColor(hexValue: 0xFA651F ).cgColor
        infoLab1.layer.borderWidth = 0.5
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
        infoLab2.trCorner(3)
        infoLab2.layer.borderColor = UIColor.hexColor(hexValue: 0x23B1F5 ).cgColor
        infoLab2.layer.borderWidth = 0.5
        infoLab2.textColor = UIColor.hexColor(hexValue: 0x23B1F5 )
        infoLab2.font = UIFont.trFont(fontSize: 12)
        bgView.addSubview(infoLab2)
        
        contactBtn = UIButton()
        contactBtn.addTarget(self, action: #selector(concactAction), for: .touchUpInside)
        contactBtn.setImage(UIImage(named: "home_phone"), for: .normal)
        bgView.addSubview(contactBtn)
        
        dhBtn = UIButton()
        dhBtn.addTarget(self, action: #selector(dhAction), for: .touchUpInside)
        dhBtn.setImage(UIImage(named: "home_dh"), for: .normal)
        bgView.addSubview(dhBtn)
        
        pickupBtn = UIButton()
        pickupBtn.isUserInteractionEnabled = false
        pickupBtn.backgroundColor = UIColor.hexColor(hexValue: 0xFA651F)
        pickupBtn.layer.cornerRadius = 23 * TRHeightScale
        pickupBtn.layer.masksToBounds = true
        pickupBtn.setTitleColor(.white, for: .normal)
        pickupBtn.setTitle("取货", for: .normal)

        pickupBtn.titleLabel?.font = UIFont.trBoldFont(fontSize: 18)
        bgView.addSubview(pickupBtn)
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
            make.right.equalTo(bgView).inset(18)
            make.left.equalTo(bgView).offset(50)
        }
        startLocLab.snp.makeConstraints { make in
            make.top.equalTo(startNameLab.snp.bottom).offset(5)
            make.right.equalTo(bgView).inset(18)
            make.left.equalTo(startNameLab)
        }
        
        songLab.snp.makeConstraints { make in
            make.left.equalTo(quLab)
            make.height.width.equalTo(18)
            make.top.equalTo(distanceLab.snp.bottom).offset(26)
        }
        endNameLab.snp.makeConstraints { make in
            make.left.equalTo(startNameLab)
            make.right.equalTo(bgView).inset(18)
            make.top.equalTo(songLab)
        }
     
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
        contactBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(bgView).offset(25)
            make.top.equalTo(pickupBtn)
        }
        dhBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(contactBtn.snp.right).offset(33)
            make.top.equalTo(contactBtn)
        }
        dhLab.snp.makeConstraints { make in
            make.centerX.equalTo(dhBtn)
            make.top.equalTo(dhBtn.snp.bottom).offset(2)
        }
        contactLab.snp.makeConstraints { make in
            make.centerX.equalTo(contactBtn)
            make.top.equalTo(contactBtn.snp.bottom).offset(2)
        }
        pickupBtn.snp.makeConstraints { make in
            make.right.equalTo(line)
            make.left.equalTo(dhBtn.snp.right).offset(33)
            make.bottom.equalTo(bgView).inset(20)
            make.top.equalTo(infoLab1.snp.bottom).offset(15)
            make.height.equalTo(46 * TRHeightScale)
        }
        
//        contentView.layoutSubviews()
//        contentView.layoutIfNeeded()
//        distanceLine.drawDashLine(strokeColor: .red, lineWidth: 1, lineLength: 100, lineSpacing: 6)
    }
    @objc func dhAction(){
        //
        let point = model!.senderLongLat
        if point.isEmpty || !point.contains(",") {
            SVProgressHUD.showInfo(withStatus: "获取商家/取货点位置失败")
            return
        }
        let arr = point.components(separatedBy: ",")
        let lat  = Double.init(arr.last ?? "0")
        let lon = Double.init(arr.first ?? "0")
        if lat == 0 || lat == nil || lon == nil || lon == 0 {
            SVProgressHUD.showInfo(withStatus: "获取商家/取货点位置失败")
            return
        }
        let ep = AMapNaviPoint.location(withLatitude: lat!, longitude: lon!)!
        
        let vc = TRTimeNavViewController()
        var startArr : [String] = []
        if !TRDataManage.shared.curLongLat.isEmpty {
            startArr = TRDataManage.shared.curLongLat.components(separatedBy: ",")
            if startArr.count != 2 {
                SVProgressHUD.showInfo(withStatus: "位置信息异常")
                return
            }
        }
        if let startLatString = startArr.last, let startLat = Double(startLatString),
           let startLonString = startArr.first, let startLon = Double(startLonString) {
            vc.startPoint = AMapNaviPoint.location(withLatitude: startLat, longitude: startLon)
        } else {
            vc.startPoint = ep
        }
        vc.endPoint = ep
        if TRDataManage.shared.riderModel.pathType.elementsEqual("DRIVEWAY") {
            vc.type = .hud
        } else {
            vc.type = .ride
        }
        vc.hidesBottomBarWhenPushed = true
        self.iq.viewContainingController()?.navigationController?.pushViewController(vc , animated: true)
//        SVProgressHUD.show()
//        TRRoutePlan.shared.navBlock = {[weak self] in
//            SVProgressHUD.dismiss()
//            guard let self  = self  else { return }
//            DispatchQueue.main.async {
//               
//            }
//        }
    }
    @objc func concactAction(){
//        TRTool.callPhone(model!.senderPhone)
   
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

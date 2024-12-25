//
//  TRMapView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//
import UIKit
import RxCocoa
import RxSwift
import MapKit
enum navType {
    case walk
    case ride
    case hud
}
class JMPolyline: MAPolyline {
    var uniqueIdentifier: String
    
    init(coordinates: [CLLocationCoordinate2D], count: Int, uniqueIdentifier: String) {
        self.uniqueIdentifier = uniqueIdentifier
//        super.init(coordinates: coordinates, count: UInt(count))
    }
}
class TRMapView: UIView,MAMapViewDelegate,CLLocationManagerDelegate  {
    var contentView : UIView!
    
    var tipbgView : UIView!
    var tipIconImgV : UIImageView!
    var tipLab : UILabel!
    
    var trafficBgView : UIView!
    var footerBtn : UIButton!
    var eleBtn : UIButton!
    var carBtn : UIButton!
    
    var locBtn : UIButton!
    var refreshBtn : UIButton!
    var mapView : MAMapView!
    var startRoute : AMapNaviRoute!
    var selectablePolyLine : SelectableOverlay!
    var endselectablePolyLine : SelectableOverlay!
    
    private let store_ann = TRIconPin()  // 显示距离商户多远和时间
    private let user_ann  = TRIconPin()   // 显示距离用户多远和时间
    var storeView : TRPIin_RiderView!
    //是否定位成功
    var hasLoction : Bool = false
    //1 取 2 送
    var order : TROrderModel! {
        didSet {
            if order.senderLongLat.isEmpty || order.receiverLongLat.isEmpty {
                return
            }
            let sendLoc = order.senderLongLat
            let sendArr = sendLoc.components(separatedBy: ",")
            let sendEp = AMapNaviPoint.location(withLatitude: Double.init(sendArr.last!)!, longitude: Double.init(sendArr.first!)!)!
            
            let receLoc = order.receiverLongLat
            let receArr = receLoc.components(separatedBy: ",")
            let receEp = AMapNaviPoint.location(withLatitude: Double.init(receArr.last!)!, longitude: Double.init(receArr.first!)!)!
            // 原来显示一条路线 lsatpoint 代表第一条路线的终点  现在新增一条路线 startpoint 代表第一条路线的终点 lastpoint代表第二条路线的终点
            mp = sendEp
            ep = [sendEp,receEp]
            startPoint = sendEp
            lastPoint = receEp
        }
    }
    var navType : Int = 1
    var sp : AMapNaviPoint = AMapNaviPoint.location(withLatitude: 22.59449, longitude: 113.96434)!
    var mp : AMapNaviPoint = AMapNaviPoint.location(withLatitude: 22.59449, longitude: 113.96434)!
    var ep : [AMapNaviPoint] = [AMapNaviPoint.location(withLatitude: 32.58949, longitude: 113.95134)!]
    private var lastPoint : AMapNaviPoint = AMapNaviPoint.location(withLatitude: 32.58949, longitude: 113.95134)!
    private var startPoint : AMapNaviPoint = AMapNaviPoint.location(withLatitude: 32.58949, longitude: 113.95134)!
    let bag = DisposeBag()
    var type : navType = .ride {
        didSet {
            footerBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
            eleBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
            carBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
            if type == .walk {
                footerBtn.tintColor = .lightThemeColor()
            } else if type == .ride {
                eleBtn.tintColor = .lightThemeColor()
            } else if type == .hud {
                carBtn.tintColor = .lightThemeColor()
            }
            if !hasLoction {
                SVProgressHUD.showInfo(withStatus: "正在定位...")
                return
            }
            if type == .walk {
                if order.status.elementsEqual("NEW"){
                    TRRoutePlan.shared.walkNavPlan(sp: sp,mp: startPoint, ep: lastPoint)
                }else if order.status.elementsEqual("WAITING_TAKE"){
                    TRRoutePlan.shared.walkNavPlan(sp: sp,mp: startPoint, ep:nil)
                }else{
                    TRRoutePlan.shared.walkNavPlan(sp: sp,mp: lastPoint, ep:nil)
                }
                TRRoutePlan.shared.walkBlock = {[weak self](nav,secnav) in
                    guard let self  = self  else { return }
                    if nav == nil {
                        SVProgressHUD.showInfo(withStatus: "路线规划失败")
                    } else {
                        SVProgressHUD.dismiss()
                        dealPath(route: nav, endroute: secnav)
                    }
                }
            } else if type == .ride {
                SVProgressHUD.show()
                if order.status.elementsEqual("NEW"){
                    TRRoutePlan.shared.ridePlan(sp: sp,mp: startPoint, ep: lastPoint)
                }else if order.status.elementsEqual("WAITING_TAKE"){
                    TRRoutePlan.shared.ridePlan(sp: sp,mp: startPoint, ep:nil)
                }else{
                    TRRoutePlan.shared.ridePlan(sp: sp,mp: lastPoint, ep:nil)
                }
                TRRoutePlan.shared.rideBlock = {[weak self](nav,secnav) in
                    guard let self  = self  else { return }
                    if nav == nil {
                        SVProgressHUD.showInfo(withStatus: "路线规划失败")
                    } else {
                        SVProgressHUD.dismiss()
                        dealPath(route: nav, endroute: secnav)
                    }
                }
            } else if type == .hud {
                if order.status.elementsEqual("NEW"){
                    TRRoutePlan.shared.driveNavPlan(sp: sp,mp: startPoint, ep: lastPoint)
                }else if order.status.elementsEqual("WAITING_TAKE"){
                    TRRoutePlan.shared.driveNavPlan(sp: sp,mp: startPoint, ep:nil)
                }else{
                    TRRoutePlan.shared.driveNavPlan(sp: sp,mp: lastPoint, ep:nil)
                }
                SVProgressHUD.show()
                TRRoutePlan.shared.dirveBlock = {[weak self](nav,secnav) in
                    guard let self  = self  else { return }
                    if nav == nil {
                        SVProgressHUD.showInfo(withStatus: "路线规划失败")
                    } else {
                        SVProgressHUD.dismiss()
                        dealPath(route: nav, endroute: secnav)
                    }
                }
            }
        }
    }
    
    var typeBlock : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = UIView()
        contentView.backgroundColor = .bgColor()
        self.addSubview(contentView)
        configMapView()
        setupView()
    }

    //添加取送点
    func dealAnnotations(){
        mapView.removeAnnotations(mapView.annotations)
        let senderSp = ep.first!
        let receiveSp = ep.last!
        let beginAnnotation = NaviPointAnnotation.init()
        beginAnnotation.coordinate = .init(latitude: senderSp.latitude, longitude: senderSp.longitude)
        beginAnnotation.title = "取"
        beginAnnotation.navPointType = .start
        
        
        
//        let time = String.init(format: "大约%02zd分 %02zd秒", (startRoute.routeTime/60)%60, startRoute.routeTime%60)
        let endAnnotation = NaviPointAnnotation.init()
        endAnnotation.coordinate = .init(latitude: receiveSp.latitude, longitude: receiveSp.longitude)
        endAnnotation.title = "送"
//        endAnnotation.subtitle = "距送\(order.storeDistance)米"
        endAnnotation.navPointType = .end
        mapView.addAnnotations([beginAnnotation, endAnnotation])
        
    }
    func addPolyLine(){
        
    }
    
    func dealPath(route : AMapNaviRoute? ,endroute :AMapNaviRoute?){
        guard let route = route else { return }
        startRoute = route
        mapView.removeAnnotations([store_ann,user_ann])
        mapView.removeOverlays(mapView.overlays)
        let count = route.routeCoordinates.count
        let coords = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: count)
        for i in 0...count - 1 {
            let coordinate = route.routeCoordinates[i]
//            var time =  route.routeLength
//            var distance = route.routeTime
            coords[i] = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        let line = MAPolyline(coordinates: coords, count: UInt(count))
        selectablePolyLine = SelectableOverlay(overlay: line)
        selectablePolyLine?.mapTitle = "start"

        guard let endroute = endroute else {
            mapView.addAnnotation(store_ann)
            store_ann.coordinate = CLLocationCoordinate2D(latitude: route.routeEndPoint.latitude, longitude: route.routeEndPoint.longitude)
            var storeView = TRPIin_RiderView(frame: .init(x: 0, y: 0, width: 100, height: 40))
//            let time = String.init(format: "%02zd分%02zd秒", (route.routeTime/60)%60, route.routeTime%60)
            if order.status.elementsEqual("NEW") || order.status.elementsEqual("WAITING_TAKE"){
                storeView.waitLab.text = "距取\(route.routeLength)米"
            }else{
                storeView.waitLab.text = "距送\(route.routeLength)米"
            }
            store_ann.customView = storeView
//            mapView.showAnnotations([store_ann], edgePadding: .init(top: 50, left: 40, bottom: 120, right: 240),animated: true)
            mapView.addOverlays([selectablePolyLine as Any])
            mapView.showOverlays(mapView.overlays, edgePadding: .init(top: StatusBar_Height + 44 + 15, left: 50, bottom: (IS_IphoneX ? 100.0 : 70.0) + 80, right: 80), animated: true)
            return
        }
        let endcount = endroute.routeCoordinates.count
        let endcoords = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: endcount)
        for i in 0...endcount - 1 {
            let endcoordinate = endroute.routeCoordinates[i]
            endcoords[i] = CLLocationCoordinate2D(latitude: endcoordinate.latitude, longitude: endcoordinate.longitude)
        }
        let endline = MAPolyline(coordinates: endcoords, count: UInt(endcount))
        endselectablePolyLine = SelectableOverlay(overlay: endline)
        endselectablePolyLine?.mapTitle = "end"
        
        mapView.addAnnotations([store_ann,user_ann])
        user_ann.coordinate = CLLocationCoordinate2D(latitude: endroute.routeEndPoint.latitude, longitude: endroute.routeEndPoint.longitude)
        var userView = TRPIin_RiderView(frame: .init(x: 0, y: 0, width: 100, height: 40))
//        let time = String.init(format: "%02zd分%02zd秒", (endroute.routeTime/60)%60, endroute.routeTime%60)
        userView.waitLab.text = "距送\(endroute.routeLength)米"
        user_ann.customView = userView
        mapView.addOverlays([selectablePolyLine as Any,endselectablePolyLine as Any])
        mapView.showOverlays(mapView.overlays, edgePadding: .init(top: StatusBar_Height + 44 + 15, left: 50, bottom: (IS_IphoneX ? 100.0 : 70.0) + 80, right: 80), animated: true)
        return
    }
    
    @objc func switchPlanType(sender : UIButton) {
        let tag = sender.tag - 70000;
        footerBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
        eleBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
        carBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
        sender.tintColor = .hexColor(hexValue: 0x13D066)
        if tag == 1 {
            self.type = .walk
        } else if tag == 2 {
            self.type = .ride
        } else if tag == 3 {
            self.type = .hud
        }
        if typeBlock != nil {
            typeBlock!(tag)
        }
    }
    private func configMapView(){
        
        MAMapView.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        MAMapView.updatePrivacyAgree(.didAgree)
        mapView = MAMapView(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        mapView.userTrackingMode = .follow
        mapView.showsUserLocation = true
        mapView.customMapStyleEnabled = true
//        mapView.setCustomMapStyleOptions(opt)
        mapView.delegate = self
        self.addSubview(mapView)
        
    }
    @objc private func locationAction(){
        SVProgressHUD.show()
        TRLocation.shared.startObserving {[weak self] (loc,_) in
            guard let self = self else {return}
            sp = AMapNaviPoint.location(withLatitude: loc!.coordinate.latitude, longitude: loc!.coordinate.longitude)!
//            ep = AMapNaviPoint.location(withLatitude: loc.coordinate.latitude + 0.01, longitude: loc.coordinate.longitude - 0.02)
            mapView.setCenter(.init(latitude: sp.latitude, longitude: sp.longitude), animated: true)
            
            hasLoction = true
            if type == .walk {
                SVProgressHUD.show()
                if order.status.elementsEqual("NEW"){
                    TRRoutePlan.shared.walkNavPlan(sp: sp,mp: startPoint, ep: lastPoint)
                }else if order.status.elementsEqual("WAITING_TAKE"){
                    TRRoutePlan.shared.walkNavPlan(sp: sp,mp: startPoint, ep:nil)
                }else{
                    TRRoutePlan.shared.walkNavPlan(sp: sp,mp: lastPoint, ep:nil)
                }
                TRRoutePlan.shared.walkBlock = {[weak self](nav,secnav) in
                    guard let self = self  else { return }
                    if nav == nil {
                        SVProgressHUD.showInfo(withStatus: "路线规划失败")
                    } else {
                        SVProgressHUD.dismiss()
                        dealPath(route: nav, endroute: secnav)
                    }
                }
            } else if type == .ride {
                SVProgressHUD.show()
                if order.status.elementsEqual("NEW"){
                    TRRoutePlan.shared.ridePlan(sp: sp,mp: startPoint, ep: lastPoint)
                }else if order.status.elementsEqual("WAITING_TAKE"){
                    TRRoutePlan.shared.ridePlan(sp: sp,mp: startPoint, ep:nil)
                }else{
                    TRRoutePlan.shared.ridePlan(sp: sp,mp: lastPoint, ep:nil)
                }
                TRRoutePlan.shared.rideBlock = {[weak self](nav,secnav) in
                    guard let self  = self  else { return }
                    if nav == nil {
                        SVProgressHUD.showInfo(withStatus: "路线规划失败")
                    } else {
                        SVProgressHUD.dismiss()
                        dealPath(route: nav, endroute: secnav)
                    }
                }
            } else if type == .hud {
                SVProgressHUD.show()
                if order.status.elementsEqual("NEW"){
                    TRRoutePlan.shared.driveNavPlan(sp: sp,mp: startPoint, ep: lastPoint)
                }else if order.status.elementsEqual("WAITING_TAKE"){
                    TRRoutePlan.shared.driveNavPlan(sp: sp,mp: startPoint, ep:nil)
                }else{
                    TRRoutePlan.shared.driveNavPlan(sp: sp,mp: lastPoint, ep:nil)
                }
                TRRoutePlan.shared.dirveBlock = {[weak self](nav,secnav) in
                    guard let self  = self  else { return }
                    if nav == nil {
                        SVProgressHUD.showInfo(withStatus: "路线规划失败")
                    } else {
                        SVProgressHUD.dismiss()
                        dealPath(route: nav, endroute: secnav)
                    }

                }
            }
            dealAnnotations()
        }
    }
    private func setupView(){
        
        let startAnnotation = MKPointAnnotation()
        mapView.showAnnotations([startAnnotation], animated: true)
        tipbgView = UIView()
        tipbgView.backgroundColor = UIColor.hexColor(hexValue: 0xFA651F).withAlphaComponent(0.15)
        mapView.addSubview(tipbgView)
        
        tipLab = UILabel()
        tipLab.text = "取送路线提示非导航规划，请遵守交通规则"
        tipLab.adjustsFontSizeToFitWidth = true
        tipLab.layer.cornerRadius = 4
        tipLab.layer.masksToBounds = true
        tipLab.textColor = UIColor.hexColor(hexValue: 0xFA651F)
        tipLab.font = UIFont.trFont(fontSize: 12)
        tipbgView.addSubview(tipLab)
        
        tipIconImgV = UIImageView()
        tipIconImgV.image = UIImage(named: "notification")
        tipbgView.addSubview(tipIconImgV)
        
        trafficBgView = UIView()
        trafficBgView.backgroundColor = .white
        trafficBgView.frame = CGRect(x: 16, y: 290, width: 50, height: 148)
        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = CGRect(x: 0, y: 0, width: 50, height: 148)
        bgLayer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        trafficBgView.layer.addSublayer(bgLayer1)
        // shadowCode
        trafficBgView.layer.shadowColor = UIColor(red: 0.27, green: 0.29, blue: 0.32, alpha: 0.2).cgColor
        trafficBgView.layer.shadowOffset = CGSize(width: 0, height: 2)
        trafficBgView.layer.shadowOpacity = 1
        trafficBgView.layer.shadowRadius = 12
        mapView.addSubview(trafficBgView)
    
        footerBtn = UIButton()
        footerBtn.setImage(UIImage(named: "traffic_footer_gray")?.withRenderingMode(.alwaysTemplate), for: .normal)
        footerBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
        footerBtn.tag = 70001
        footerBtn.addTarget(self, action: #selector(switchPlanType), for: .touchUpInside)
        trafficBgView.addSubview(footerBtn)
        
        eleBtn = UIButton()
        eleBtn.setImage(UIImage(named: "traffic_electrocar_gray")?.withRenderingMode(.alwaysTemplate), for: .normal)
        eleBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
        eleBtn.addTarget(self, action: #selector(switchPlanType), for: .touchUpInside)
        eleBtn.tag = 70002
        trafficBgView.addSubview(eleBtn)
        
        carBtn = UIButton()
        carBtn.addTarget(self, action: #selector(switchPlanType), for: .touchUpInside)
        carBtn.tag = 70003
        carBtn.setImage(UIImage(named: "traffic_car_gray")?.withRenderingMode(.alwaysTemplate), for: .normal)
        carBtn.tintColor = .hexColor(hexValue: 0xC6C9CB)
        trafficBgView.addSubview(carBtn)
        
        locBtn = UIButton()
        locBtn.layer.cornerRadius = 10
        locBtn.layer.masksToBounds = true
        locBtn.backgroundColor = .white
        locBtn.setImage(UIImage(named: "map_loc"), for: .normal)
        locBtn.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
        mapView.addSubview(locBtn)
        
        refreshBtn = UIButton()
        refreshBtn.layer.cornerRadius = 10
        refreshBtn.layer.masksToBounds = true
        refreshBtn.backgroundColor = .white
        locBtn.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
        refreshBtn.setImage(UIImage(named: "map_refresh"), for: .normal)
        mapView.addSubview(refreshBtn)
        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        tipbgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(28)
        }
        tipIconImgV.snp.makeConstraints { make in
            make.left.equalTo(tipbgView).offset(9)
            make.centerY.equalTo(tipbgView)
            make.width.height.equalTo(16)
        }
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(tipIconImgV.snp.right).offset(5)
            make.centerY.equalTo(tipbgView)
        }
        
        trafficBgView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).inset(200 * APP_Scale)
            make.width.equalTo(50)
            make.height.equalTo(148)
        }
        
        footerBtn.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(trafficBgView)
            make.top.equalTo(trafficBgView).offset(13)
        }
        eleBtn.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(trafficBgView)
            make.top.equalTo(footerBtn.snp.bottom).offset(13)
        }
        carBtn.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(trafficBgView)
            make.top.equalTo(eleBtn.snp.bottom).offset(13)
        }
        
        refreshBtn.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(trafficBgView)
        }
        
        locBtn.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(refreshBtn.snp.top).offset(-20)
        }

        locationAction()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    didAddAnnotationViews
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
            // 当获得授权时，计算并添加距离
        let startLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // 起点经纬度
        let distance = startLocation.distance(from: manager.location!) // 使用当前位置和起点计算距离
                        
        let time = distance / 1000 / 60 * 4 // 假设平均行驶速度为每小时4公里
//        let timeString = distanceFormatter.string(from: NSNumber(value: time), numberStyle: .decimal)
//                        
//        let distanceString = distanceFormatter.string(from: NSNumber(value: distance), numberStyle: .decimal)
        // 更新起点注释，添加距离和时间
        let startAnnotation = mapView.annotations?.first as? MKPointAnnotation
        startAnnotation?.subtitle = "Distance: 500米 in about 60s minutes"
    }
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
       
    }
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
    }
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: NaviPointAnnotation.self) {
            let idStr = "NaviPointAnnotationIdentifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: idStr) as? MAPinAnnotationView
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: idStr)
            }
            annotationView!.canShowCallout = false
            annotationView!.animatesDrop = false
            annotationView!.isDraggable = false
            let navAnnotaion = annotation as! NaviPointAnnotation
            if navAnnotaion.navPointType == .start {
                annotationView?.image = UIImage(named: "nav_qu_1")
            } else if navAnnotaion.navPointType == .end {
                annotationView?.image = UIImage(named: "nav_song_1")
            }
            return annotationView
        }
        else if annotation is TRIconPin {
            let reuserID = "TRICONPIN"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuserID)
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: reuserID)
            }
            
            if let customAnnotation = annotation as? TRIconPin {
                if let cv = customAnnotation.customView {
                    annotationView?.addSubview(cv)
                }
            }
            
            return annotationView
        }
        return nil
    }
    // 视图渲染
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay.isKind(of: SelectableOverlay.self) {
            let over = overlay as! SelectableOverlay
//            print(over.mapTitle)
            if over.mapTitle  == "start"{
                print("xzy99999start")
                let selectableOverlay = overlay as! SelectableOverlay
                let actualOverlay = selectableOverlay.overlay
                let polylineRenderer = MAPolylineRenderer(polyline: actualOverlay as? MAPolyline)
                //            polylineRenderer.tex
                polylineRenderer?.lineWidth = 15
                polylineRenderer?.strokeImage = UIImage(named: "map_oo")
                //            polylineRenderer?.loadTexture(UIImage(named: "map_oo")!)
                //            polylineRenderer?.strokeColor = selectableOverlay.isSelected ? selectableOverlay.selectedColor : selectableOverlay.regularColor
                return polylineRenderer
            } else if over.mapTitle  == "end"{
                print("xzy8888start")
                let selectableOverlay = overlay as! SelectableOverlay
                let actualOverlay = selectableOverlay.overlay
                let polylineRenderer = MAPolylineRenderer(polyline: actualOverlay as? MAPolyline)
                polylineRenderer?.lineWidth = 15
                polylineRenderer?.strokeImage = UIImage(named: "map_green")
                return polylineRenderer
            }else {
                print("xzy7777start")
                let selectableOverlay = overlay as! SelectableOverlay
                let actualOverlay = selectableOverlay.overlay
                let polylineRenderer = MAPolylineRenderer(polyline: actualOverlay as? MAPolyline)
                polylineRenderer?.lineWidth = 15
                polylineRenderer?.strokeImage = UIImage(named: "map_oo")
                return polylineRenderer
            }
        }
        return nil
    }
}

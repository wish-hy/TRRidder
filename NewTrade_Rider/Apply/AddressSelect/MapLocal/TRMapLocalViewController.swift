//
//  TRMapLocalViewController.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/12.
//

import UIKit
import MapKit
import AMapSearchKit
//import MAMapKit
class MapFlag: NSObject, MKAnnotation {
    // 标题
    let title: String?
    // 副标题
    let subtitle: String?
    // 经纬度
    let coordinate: CLLocationCoordinate2D
    // 附加信息
    let urlString: String

    var hasLoc : Bool = false
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D, urlString: String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.urlString = urlString
    }
}


class TRMapLocalViewController: BasicViewController, MAMapViewDelegate, AMapSearchDelegate {
    var mapView : MAMapView!
    var bottomView : TRSearchLocView!
    var infoArr : [TRPointAnnotation] = []
    
    //需要判断时，外界传来的原始参数
    var serviceCode : String = "MALL"
    // 大头针未使用，固定在地图中间
    private var pinImgV : UIImageView!
    private var isSpan : Bool = false
    
    private var geoCoder : CLGeocoder!
    private var hasUserLoc : Bool = false
    private var naturalLanguageQuery : String?
    private var lastCoordinate : CLLocationCoordinate2D?
    private var searchAPI : AMapSearchAPI?
    
    private var keySearchAPI : AMapPOIKeywordsSearchRequest?
    
    private var currentAnnontaion : TRPointAnnotation?
    //是否需要poi搜索
    var isNeedSearch : Bool = true

    //确认时 是否需要判断此区域是否开通
    var needAdjustHasOpening : Bool = false
    
    var anni_block : Annotation_Block?
    //    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        startLocation()
//    }
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        TRLocation.shared.stopObserving()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        costomNav()
        
        AMapSearchAPI.updatePrivacyAgree(.didAgree)
        AMapSearchAPI.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        searchAPI = AMapSearchAPI.init()
        startLocation()
        configMapView()

        pinImgV = UIImageView(image: UIImage(named: "location_ann"))
        pinImgV.frame = CGRect(x: 0, y: 0, width: 24 * 1.5 * TRWidthScale, height: 32 * 1.5 * TRWidthScale)
        pinImgV.center = mapView.center
        self.view.addSubview(pinImgV)
        // Do any additional setup after loading the view.
    }
    
    private func configMapView(){
        geoCoder = CLGeocoder()
//        [MAMapView updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
//        [MAMapView updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
        mapView = MAMapView(frame: .init(x: 0, y: Nav_Height, width: Screen_Width, height: Screen_Height - Nav_Height - Screen_Height / 2))
        mapView.zoomLevel = 17.5
       
        mapView.delegate = self
        mapView.showsUserLocation = true
        
//        mapView.delegate = self
//        mapView.showsScale = true
//        mapView.showsUserLocation = true
        self.view.addSubview(mapView)
        
        bottomView = TRSearchLocView(frame: .zero)
        self.view.addSubview(bottomView)
        

        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.height.equalTo(Screen_Height / 2)
        }
        bottomView.searchBlock = {[weak self] (str) in
            guard let self = self else {return}
            searchLocation(str)
        }
        bottomView.selectBlock = {[weak self] (index) in
            guard let self = self else { return }
            isNeedSearch = false
            let ann = infoArr[index]
            mapView.setCenter(ann.coordinate, animated: true)
            currentAnnontaion = ann
        }
    }
    private func startLocation(){
        TRLocation.shared.startObserving {[weak self] (loc,_) in
            guard let self = self else {return}
//            mapView.camera.altitude = 1000
//            mapView.camera.centerCoordinate = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
//            let ann = TRAnnation(coordinate: loc.coordinate)
//            mapView.addAnnotation(ann)
            mapView.setCenter(CLLocationCoordinate2D(latitude: loc!.coordinate.latitude, longitude: loc!.coordinate.longitude), animated: true)
        }
    }
    private func searchLocation(_ key : String) {
        if keySearchAPI == nil {
            
            keySearchAPI = AMapPOIKeywordsSearchRequest()
//            keySearchAPI!.types = "商务住宅|餐饮服务|生活服务"
            keySearchAPI!.offset = 25
        }
        keySearchAPI!.keywords = key
        searchAPI!.aMapPOIKeywordsSearch(keySearchAPI)
        
//        let api = AMapInputTipsSearchRequest()
//
//        api.keywords = key
//        searchAPI!.aMapInputTipsSearch(api)
      
    }
    func onInputTipsSearchDone(_ request: AMapInputTipsSearchRequest!, response: AMapInputTipsSearchResponse!) {
        
    }
    
    
    private func getAroundInfo(coordinate : CLLocationCoordinate2D){
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = naturalLanguageQuery
//        request.region = region
//        
//        let search = MKLocalSearch(request: request)
//        search.start { response , err in
//            guard let response = response else {return}
//            self.infoArr = response.mapItems
//            self.bottomView.items = response.mapItems
//        }
        
    
        searchAPI?.delegate = self
        let request = AMapPOIAroundSearchRequest()
        
        request.location = AMapGeoPoint.location(withLatitude: coordinate.latitude, longitude: coordinate.longitude)
        request.keywords = naturalLanguageQuery
        searchAPI?.aMapPOIAroundSearch(request)
    }
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        
    }
    func onRoutePOISearchDone(_ request: AMapRoutePOISearchRequest!, response: AMapRoutePOISearchResponse!) {
        
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        if response.count == 0 {
            return
        }
        
        var annos = Array<TRPointAnnotation>()
        
        for aPOI in response.pois {
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(aPOI.location.latitude), longitude: CLLocationDegrees(aPOI.location.longitude))
            let anno = TRPointAnnotation()
            anno.proCode = aPOI.pcode
            if aPOI.adcode.count > 4 {
                anno.cityCode =  (aPOI.adcode! as NSString).substring(to: 4) + "00"//aPOI.citycode
            } else {
                anno.cityCode = aPOI.citycode
            }
            anno.disCode = aPOI.adcode
            anno.province = aPOI.province
            anno.city = aPOI.city
            anno.district = aPOI.district
            anno.coordinate = coordinate
            anno.title = aPOI.name
            anno.subtitle = aPOI.address
            annos.append(anno)
        }
        bottomView.items = annos
        infoArr = annos
        currentAnnontaion = infoArr.first
    }
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!) {
        if !hasUserLoc {
            mapView.setCenter(userLocation.coordinate, animated: true)
            hasUserLoc = true
        }
    }
    func mapView(_ mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
                let coordinate = mapView.convert(mapView.center, toCoordinateFrom: mapView)
        
                pinImgV.center = CGPoint.init(x: mapView.center.x, y: mapView.center.y - 15)
                UIView.animate(withDuration: 0.2) {
                    self.pinImgV.center = mapView.center
                } completion: { _ in
                    UIView.animate(withDuration: 0.05) {
                        self.pinImgV.transform = .init(scaleX: 1, y: 0.8)
                    } completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.pinImgV.transform = .identity
                        }
                    }
                }
        if isNeedSearch {
            geoConvert(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
        isNeedSearch = true
    }

    private func geoConvert(_ coordinate : CLLocationCoordinate2D){
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { placemarks , err in
            if err == nil {
                DispatchQueue.main.async {

                    self.lastCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    self.getAroundInfo(coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))

                }
            }
        }
    }
    
    private func costomNav(){
        configNavBar()
        configNavTitle(title: "地址定位")
        configNavLeftBtn()
        let saveBtn = TRFactory.buttonWithCorner(title: "保存", bgColor: .hexColor(hexValue: 0x2C96FF ), font: .trMediumFont(13), corner: 14)
        saveBtn.frame = .init(x: 0, y: 0, width: 60, height: 28)
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        navBar?.rightView = saveBtn
    }
    @objc func saveAction(){
        guard let annontaion = currentAnnontaion else {
            SVProgressHUD.showInfo(withStatus: "未获取到定位信息")
            return
        }
        
        if needAdjustHasOpening {
            //判断当前区域是否开通
            var pars : [String : Any] = [
               
                "codeDistrict" : annontaion.disCode,
                "serviceCode" : serviceCode
            ]
            
                TRNetManager.shared.post_no_lodding(url: URL_Adjust_Area_HasOpened, pars: pars) {[weak self] dict in
                    guard let self  = self  else { return }
                    guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
                    if codeModel.exceptionCode == 0 {
                        let ret = codeModel.data as? Bool ?? false
                        if ret {
                            if self.anni_block != nil {
                                self.anni_block!(annontaion)
                                self.navigationController?.popViewController(animated: true)
                            }
                        } else {
                            let openView = TRNotOpenView(frame: .zero)
                            openView.addressLab.text = annontaion.province + annontaion.city + annontaion.district
                            openView.addToWindow()
//                            openView.open
                        }
                    } else {
                        SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
                    }
            }

        } else {
            if self.anni_block != nil {
                self.anni_block!(annontaion)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  TRLocation.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/12.
//

import UIKit
import AMapLocationKit
class TRLocation: NSObject {
    static var shared = TRLocation()
    
    private let locManager = AMapLocationManager()
    private var updateLocationBlock: ((CLLocation?,AMapLocationReGeocode?)->Void)?
    
    
    
    func startObserving(_ needGEO : Bool = false,doThisWhenMoved: @escaping (CLLocation?,AMapLocationReGeocode?)->Void) {
//        locManager.stopUpdatingLocation()
        locManager.delegate = self
        locManager.locationTimeout = 2
        locManager.reGeocodeTimeout = 2
        
        locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        if updateLocationBlock == nil {
            updateLocationBlock = doThisWhenMoved
//        }
//        locManager.des
    
        locManager.requestLocation(withReGeocode:needGEO) { loc, geo, err in
            if err != nil{
                self.startObserving(doThisWhenMoved: doThisWhenMoved)
                return
            }
            self.updateLocationBlock?(loc,geo)
//            self.locManager.startUpdatingLocation()
        }
    }
    
    func startUpdatingObserving(){
        locManager.delegate = self
//        locManager.allowsBackgroundLocationUpdates = true
        locManager.startUpdatingLocation()
    }
    
    
    func stopObserving() {
        locManager.stopUpdatingLocation()
        updateLocationBlock = nil
    }
    
    func restart() {
        guard let tmp = updateLocationBlock else {
            fatalError()
        }
        
        stopObserving()
        
        TRLocation.shared = TRLocation()
        
        TRLocation.shared.startObserving(doThisWhenMoved: tmp)
        
    }
}

extension TRLocation: AMapLocationManagerDelegate {
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print("\(self): location manager authorization changed")
//
//        locManager.distanceFilter = 10// meters
//        locManager.desiredAccuracy = 4
//        locManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]) {
//        guard let loc = didUpdateLocations.last else {
//            return
//        }
//
//        updateLocationBlock?(loc)
//    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        TRDataManage.shared.curCoordinate = location.coordinate
        TRDataManage.shared.curLongLat = "\(location.coordinate.longitude),\(location.coordinate.latitude)"

    }
}

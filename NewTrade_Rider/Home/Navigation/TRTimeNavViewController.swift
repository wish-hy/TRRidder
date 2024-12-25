//
//  TRTimeNavViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/3/22.
//

import UIKit

class TRTimeNavViewController: UIViewController, AMapNaviRideViewDelegate, AMapNaviWalkViewDelegate, AMapNaviDriveViewDelegate,AMapNaviDriveManagerDelegate,AMapNaviRideManagerDelegate,AMapNaviWalkManagerDelegate {
   
    var rideManager : AMapNaviRideManager?
    var walkManager : AMapNaviWalkManager?
    var driveManager : AMapNaviDriveManager?
    var startPoint : AMapNaviPoint?
    var endPoint : AMapNaviPoint?
    var type : navType?{
        didSet {
            if type == .hud {
                hudNav()
            }else if type == .ride {
                rideNav()
            }else if type == .walk {
                walkNav()
            }
            calculateDriveRoute()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func hudNav(){
//        let config = AMapNaviCompositeUserConfig.init()
        let v = AMapNaviDriveView(frame: self.view.bounds)
        v.showTrafficLights =  true
        v.showMode = .carPositionLocked
        v.delegate = self
        v.trackingMode = .carNorth
        if rideManager != nil{
            rideManager = nil
            _ = AMapNaviRideManager.destroyInstance()
        }
        if walkManager != nil{
            walkManager = nil
            _ = AMapNaviWalkManager.destroyInstance()
        }
        
        if driveManager == nil {
            driveManager = AMapNaviDriveManager.sharedInstance()
        }
        driveManager?.setBroadcastMode(.detailed)
        driveManager?.addDataRepresentative(v)
        driveManager?.delegate = self
        driveManager?.recalculateDriveRoute(with: AMapNaviDrivingStrategy.drivingStrategySingleDefault)
        self.view.addSubview(v)
    }
    func rideNav(){
        let v = AMapNaviRideView(frame: self.view.bounds)
//        v.showMoreButton = true
//        v.showSensorHeading = true
//        v.showGreyAfterPass = true
//        v.showTurnArrow = true
//        v.showMode = .carPositionLocked
        v.delegate = self
        v.showMode = .carPositionLocked
        v.showCompass = true
        v.trackingMode = .carNorth
        if walkManager != nil{
            walkManager = nil
            _ = AMapNaviWalkManager.destroyInstance()
        }
        if driveManager != nil{
            driveManager = nil
            _ = AMapNaviDriveManager.destroyInstance()
        }
        if rideManager == nil {
            rideManager = AMapNaviRideManager.sharedInstance()
        }
        rideManager?.addDataRepresentative(v)
        rideManager?.delegate = self
        rideManager?.recalculateRideRoute()
        self.view.addSubview(v)
    }
    func walkNav(){
        let v = AMapNaviWalkView(frame: self.view.bounds)
//        v.showSensorHeading = true
//        v.showGreyAfterPass = true
        v.showMoreButton = true
//        v.showTrafficLights = true
//        v.showMode = .carPositionLocked
        v.showMode = .carPositionLocked
        v.trackingMode = .carNorth
        v.delegate = self
        if rideManager != nil{
            rideManager = nil
            _ = AMapNaviRideManager.destroyInstance()
        }
        if driveManager != nil{
            driveManager = nil
            _ = AMapNaviDriveManager.destroyInstance()
        }
        
        if walkManager == nil {
            walkManager = AMapNaviWalkManager.sharedInstance()
            walkManager!.delegate = self
        }
        walkManager?.addDataRepresentative(v)
        
//        walkManager?.calculateWalkRoute(withStart: [startPoint!], end: [endPoint!])
        walkManager?.recalculateWalkRoute()
//        walkManager?.isUseInternalTTS = true
        self.view.addSubview(v)
    }
    func calculateDriveRoute(){
        if type == .hud {
            driveManager?.calculateDriveRoute(withStart: [startPoint!], end: [endPoint!], wayPoints: nil, drivingStrategy: .drivingStrategySingleDefault)
        }else if type == .ride {
            rideManager?.calculateRideRoute(withStart: startPoint!, end: endPoint!)
        }else if type == .walk {
            walkManager?.calculateWalkRoute(withStart: [startPoint!], end: [endPoint!])
        }
    }
    
    func driveManager(_ driveManager: AMapNaviDriveManager, onCalculateRouteSuccessWith type: AMapNaviRoutePlanType) {
        print("路线规划成功")
        // 算路成功后开始GPS导航
        driveManager.startGPSNavi()
    }
    func driveManager(_ driveManager: AMapNaviDriveManager, playNaviSound soundString: String, soundStringType: AMapNaviSoundType) {
        SpeechSynthesizer.shared().speak(soundString)
    }
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        print("路线规划成功")
        // 算路成功后开始GPS导航
        walkManager.startGPSNavi()
    }
    func walkManager(_ walkManager: AMapNaviWalkManager, playNaviSound soundString: String, soundStringType: AMapNaviSoundType) {
        SpeechSynthesizer.shared().speak(soundString)
    }
    func rideManager(onCalculateRouteSuccess rideManager: AMapNaviRideManager) {
        print("路线规划成功")
        // 算路成功后开始GPS导航
        rideManager.startGPSNavi()
    }
    func rideManager(_ rideManager: AMapNaviRideManager, playNaviSound soundString: String, soundStringType: AMapNaviSoundType) {
        SpeechSynthesizer.shared().speak(soundString)
    }
//    func driv(_ manager: AMapNaviDriveManager, onCalculateRouteSuccessWithType type: AMapNaviRoutePlanType) {
//        print("路线规划成功")
//        // 算路成功后开始GPS导航
//        driveManager?.startGPSNavi()
//    }
    
    func rideViewCloseButtonClicked(_ rideView: AMapNaviRideView) {
        rideManager?.stopNavi()
        SpeechSynthesizer.shared().stopSpeak()
        self.navigationController?.popViewController(animated: true)
    }
    
    func walkViewCloseButtonClicked(_ walkView: AMapNaviWalkView) {
        walkManager?.stopNavi()
        SpeechSynthesizer.shared().stopSpeak()
        self.navigationController?.popViewController(animated: true )
    }
    func driveViewCloseButtonClicked(_ driveView: AMapNaviDriveView) {
        driveManager?.stopNavi()
        SpeechSynthesizer.shared().stopSpeak()
        self.navigationController?.popViewController(animated: true )
    }
    func onDriveEnd(_ isEnd: Bool) {
        if isEnd {
            driveManager?.stopNavi()
            SpeechSynthesizer.shared().stopSpeak()
            self.navigationController?.popViewController(animated: true )
        }
    }
    func onWalkEnd(_ isEnd: Bool) {
        if isEnd {
            walkManager?.stopNavi()
            SpeechSynthesizer.shared().stopSpeak()
            self.navigationController?.popViewController(animated: true )
        }
    }
    func onRideEnd(_ isEnd: Bool) {
        if isEnd {
            rideManager?.stopNavi()
            SpeechSynthesizer.shared().stopSpeak()
            self.navigationController?.popViewController(animated: true )
        }
    }
    func deinitManager(){
        AMapNaviWalkManager.destroyInstance()
        AMapNaviDriveManager.destroyInstance()
        AMapNaviEleBikeManager.destroyInstance()
    }
}

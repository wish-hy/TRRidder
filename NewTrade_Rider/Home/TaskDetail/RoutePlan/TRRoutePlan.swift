//
//  TRRoutePlan.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/3/22.
//

import UIKit




//将三种导航放在一起，主要处理导航代理
class TRRoutePlan: NSObject, AMapNaviWalkManagerDelegate, AMapNaviRideManagerDelegate, AMapNaviDriveManagerDelegate {
//    var currentRoutePlan: RoutePlan?
//    var walkroutePlans
    
    static let shared = TRRoutePlan()
    var rideManager : AMapNaviRideManager?
    var walkManager : AMapNaviWalkManager?
    var driveManager : AMapNaviDriveManager?
    var sharedSpeechSynthesizer : SpeechSynthesizer?
    
    var walkBlock : AMapNaviRoute_Block?
    var rideBlock : AMapNaviRoute_Block?
    var dirveBlock : AMapNaviRoute_Block?
    
    
    var firstRoute :AMapNaviRoute?
    var secondRoute :AMapNaviRoute?
    //是否需要直接导航
    private var isNeedNav : Bool = false
    var navBlock : Void_Block?
    var secondSP : AMapNaviPoint?
    var secondEP : AMapNaviPoint?
    
    //规划成功后直接导航，不需要绘制路线
    private override init() {
        sharedSpeechSynthesizer = SpeechSynthesizer.shared()
    }
    
    //只算路，不直接导航
    func walkNavPlan(sp : AMapNaviPoint, mp : AMapNaviPoint,ep : AMapNaviPoint?){
        isNeedNav = false
        secondEP = nil
        secondSP = nil
        firstRoute = nil
        secondRoute = nil
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
            walkManager?.isUseInternalTTS = true
        }
        walkManager?.calculateWalkRoute(withStart: [sp], end: [mp])
        if ep != nil {
            secondSP = mp
            secondEP = ep
        }
    }
    func driveNavPlan(sp : AMapNaviPoint, mp : AMapNaviPoint,ep : AMapNaviPoint?){
        isNeedNav = false
        secondEP = nil
        secondSP = nil
        firstRoute = nil
        secondRoute = nil
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
            driveManager!.delegate = self
        }
        driveManager?.calculateDriveRoute(withStart: [sp], end: [mp], wayPoints: nil, drivingStrategy: .drivingStrategySingleDefault)
        if ep != nil {
            secondSP = mp
            secondEP = ep
        }
    }
    func ridePlan(sp : AMapNaviPoint, mp : AMapNaviPoint,ep : AMapNaviPoint?){
        isNeedNav = false
        secondEP = nil
        secondSP = nil
        firstRoute = nil
        secondRoute = nil
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
            rideManager!.delegate = self
        }
        rideManager?.calculateRideRoute(withStart: sp , end: mp)
        if ep != nil {
            secondSP = mp
            secondEP = ep
        }
    }
    
    // MARK: 直接进入导航界面的
    func navRiderPlan(ep : AMapNaviPoint) {
        isNeedNav = true
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
            rideManager!.delegate = self
        }
        rideManager?.calculateRideRoute(withEnd: ep)
    }
    
    func navWalkPlan(ep : AMapNaviPoint) {
        isNeedNav = true
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
        walkManager?.calculateWalkRoute(withEnd: [ep])
    }
    func navDrivePlan(ep : AMapNaviPoint) {
        isNeedNav = true
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
            driveManager!.delegate = self
        }
        driveManager?.calculateDriveRoute(withEnd: [ep], wayPoints: nil, drivingStrategy: .drivingStrategySingleDefault)
    }
    //退出导航模块调用
    func deinitManager(){
        AMapNaviWalkManager.destroyInstance()
        AMapNaviDriveManager.destroyInstance()
        AMapNaviEleBikeManager.destroyInstance()
    }
    // MARK: - 步行导航
    func secondWakl(){
        walkManager?.calculateWalkRoute(withStart: [secondSP!], end: [secondEP!])
    }
    func walkManager(_ walkManager: AMapNaviWalkManager, error: Error) {
        //发生错误
    }
    func walkManager(_ walkManager: AMapNaviWalkManager, update gpsSignalStrength: AMapNaviGPSSignalStrength) {
        print("开始了xzy222")
    }
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        if walkManager.naviRoutes().count > 0 {
            print("一条路xzy111")
            
            // 获取第一条路线
            let currentRoute = walkManager.naviRoutes().first
            
            let (routeKey, route) = walkManager.naviRoutes().first!
                    
            if firstRoute == nil {
                firstRoute = route
                print("firstRoute ==  \(firstRoute)")
            }else{
                if secondRoute == nil {
                    secondRoute = route
                    print("secondRoute == \(secondRoute)")
                }
            }
            
            // 判断是否有第二条路径的起点且没有第二条路径
            if secondSP != nil && secondRoute == nil {
                secondWakl()
            }
            // 检查两个路线是否都已设置
            if firstRoute != nil && secondRoute != nil, let walkBlock = walkBlock {
                walkBlock(firstRoute!, secondRoute!)
            }else{
                walkBlock!(firstRoute!,nil)
            }
        }
        if isNeedNav {
                   if navBlock != nil {
                       navBlock!()
                   }
               }
    }

//    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
//        if walkManager.naviRoutes().count > 0{
//            print("一条路xzy111")
//            if firstRoute == nil {
//                firstRoute = walkManager.naviRoute
//                print("firstRoute == \(firstRoute)")
//            }
//            // 判断有第二条路径的起点 且没有第二条路径
//            if secondSP != nil && secondRoute == nil{
//                secondWakl()
//            }
//            if firstRoute != nil{
//                secondRoute = walkManager.naviRoute
//                print("secondRoute == \(secondRoute)")
//                if walkEndBlock != nil {
//                    walkEndBlock!(firstRoute!,secondRoute!)
//                }
//            }
//        }
//        //是否直接去导航
//        if isNeedNav {
//            if navBlock != nil {
//                navBlock!()
//            }
//        }
//        
//    }
    func walkManager(_ walkManager: AMapNaviWalkManager, playNaviSound soundString: String, soundStringType: AMapNaviSoundType) {
        print("开始了xzy222")
        SpeechSynthesizer.shared().speak(soundString)
    }
    func walkManagerNeedRecalculateRoute(forYaw walkManager: AMapNaviWalkManager) {
        SpeechSynthesizer.shared().speak("您已偏航，将重新规划路线")
    }
    func walkManager(_ walkManager: AMapNaviWalkManager, onCalculateRouteFailure error: Error) {
        //发生错误
        SVProgressHUD.showInfo(withStatus: error.localizedDescription)

        if walkBlock != nil {
            walkBlock!(nil,nil)
        }
    }
    func walkManager(onArrivedDestination walkManager: AMapNaviWalkManager) {
        walkManager.stopNavi()
        SpeechSynthesizer.shared().stopSpeak()
    }
    // MARK: - 骑行导航
    func secondRide(){
        rideManager?.calculateRideRoute(withStart: secondSP!, end: secondEP!)
    }
    func rideManager(_ rideManager: AMapNaviRideManager, update gpsSignalStrength: AMapNaviGPSSignalStrength) {
        //卫星信号弱
        print("开始了xzy111")
    }
    func rideManager(onArrivedDestination rideManager: AMapNaviRideManager) {
        //到达目的地
        SpeechSynthesizer.shared().speak("您已到目的地附近，导航结束")
        rideManager.stopNavi()
    }
    func rideManager(onCalculateRouteSuccess rideManager: AMapNaviRideManager) {
        if rideManager.naviRoutes().count > 0 {
            let currentRoute = rideManager.naviRoutes().first
            let (routeKey, route) = rideManager.naviRoutes().first!
            if firstRoute == nil {
                firstRoute = route
            }else{
                if secondRoute == nil {
                    secondRoute = route
                }
            }
            // 判断是否有第二条路径的起点且没有第二条路径
            if secondSP != nil && secondRoute == nil {
                secondRide()
            }
            // 检查两个路线是否都已设置
            if firstRoute != nil && secondRoute != nil, let rideBlock = rideBlock {
                rideBlock(firstRoute!, secondRoute!)
            }
            else{
                rideBlock!(firstRoute!,nil)
            }
        }
        //是否直接去导航
        if isNeedNav {
            if navBlock != nil {
                navBlock!()
            }
        }
    }
    func rideManager(_ rideManager: AMapNaviRideManager, onCalculateRouteFailure error: Error) {
        //规划失败
        SVProgressHUD.showInfo(withStatus: error.localizedDescription)
        if rideBlock != nil {
            rideBlock!(nil,nil)
        }
    }
    func rideManagerNeedRecalculateRoute(forYaw rideManager: AMapNaviRideManager) {
    }
    func rideManager(_ rideManager: AMapNaviRideManager, playNaviSound soundString: String, soundStringType: AMapNaviSoundType) {
        print("开始了xzy222")
        SpeechSynthesizer.shared().speak(soundString)
    }
    func rideManager(_ rideManager: AMapNaviRideManager, didStartNavi naviMode: AMapNaviMode) {
        print("开始了xzy111")
    }
    
    // MARK: - hud导航
    func secondDrive(){
        driveManager?.calculateDriveRoute(withStart: [secondSP!], end: [secondEP!], wayPoints: nil, drivingStrategy: .drivingStrategySingleDefault)
    }
    func driveManager(_ driveManager: AMapNaviDriveManager, update gpsSignalStrength: AMapNaviGPSSignalStrength) {
        if gpsSignalStrength == .weak {
            SpeechSynthesizer.shared().speak("卫星信号弱")
        }
    }
    func driveManager(_ manager: AMapNaviDriveManager?, onUpdateNaviSpeedLimitSection speed: Int) {
        if speed != 0 {
            SpeechSynthesizer.shared().speak("前方限速")
        }
    }
    func driveManager(onArrivedDestination driveManager: AMapNaviDriveManager) {
        SpeechSynthesizer.shared().speak("您已到目的地附近，导航结束")
        driveManager.stopNavi()
        SpeechSynthesizer.shared().stopSpeak()
    }
    func driveManager(_ driveManager: AMapNaviDriveManager, onCalculateRouteFailure error: Error) {
        //规划失败
        SVProgressHUD.showInfo(withStatus: error.localizedDescription)

        if dirveBlock != nil {
            dirveBlock!(nil,nil)
        }
    }
    func driveManager(_ driveManager: AMapNaviDriveManager, playNaviSound soundString: String, soundStringType: AMapNaviSoundType) {
        SpeechSynthesizer.shared().speak(soundString)
    }
    func driveManagerNeedRecalculateRoute(forYaw driveManager: AMapNaviDriveManager) {
        SpeechSynthesizer.shared().speak("您已偏航，将重新规划路线")
    }
    func driveManagerIsNaviSoundPlaying(_ driveManager: AMapNaviDriveManager) -> Bool {
        return SpeechSynthesizer.shared().isSpeaking()
    }
    func driveManager(_ manager: AMapNaviDriveManager, onCalculateRouteSuccess route: AMapNaviRoute, with routeID: String) {
        // 获取路径规划结果中的线段

    }
    func driveManager(_ driveManager: AMapNaviDriveManager, onCalculateRouteSuccessWith type: AMapNaviRoutePlanType) {
        if let firstElement = driveManager.naviRoutes?.first {
            let (routeKey, route) = firstElement
            if firstRoute == nil {
                firstRoute = route
            }else{
                if secondRoute == nil {
                    secondRoute = route
                }
            }
                   
            // 判断是否有第二条路径的起点且没有第二条路径
            if self.secondSP != nil && self.secondRoute == nil {
                secondDrive()
            }
            // 检查两个路线是否都已设置
            if firstRoute != nil && secondRoute != nil, let dirveBlock = dirveBlock {
                dirveBlock(firstRoute, secondRoute!)
            }
            else{
                dirveBlock!(firstRoute!,nil)
            }
        }
            
        //是否直接去导航
        if isNeedNav {
            if navBlock != nil {
                navBlock!()
            }
        }
    }
}

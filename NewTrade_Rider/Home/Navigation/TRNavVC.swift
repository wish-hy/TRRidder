//
//  TRNavVC.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/3/21.
//

import UIKit
import AMapNaviKit

class TRNavVC: UIViewController, AMapNaviRideViewDelegate, AMapNaviRideManagerDelegate {
    var rideManager: AMapNaviRideManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        rideManager = AMapNaviRideManager.sharedInstance()
        rideManager?.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let startPoint = AMapNaviPoint.location(withLatitude: 39.989614, longitude: 116.481763) // 起点坐标
//        let endPoint = AMapNaviPoint.location(withLatitude: 39.983456, longitude: 116.315495) // 终点坐标
//        
//        // 配置导航参数
//        let naviDrivingStrategy = AMapNaviDrivingStrategy.multipleAvoidHighwayAndCongestion // 导航策略
//        driveManager?.setDrivingStrategy(naviDrivingStrategy)
//        
//        // 发起导航请求
//        driveManager?.calculateDriveRoute(withStart: [startPoint], end: [endPoint], wayPoints: nil, drivingStrategy: naviDrivingStrategy)
//        
//        let strategy = AMapNaviTravelStrategy(rawValue: 1001)!
//        rideManager?.setTTSPlaying(true)
//        rideManager?.calculateRideRoute(withStart: startPoint!, end: endPoint!)
//        rideManager?.startGPSNavi()
//        let riderView = AMapNaviRideView(frame: self.view.bounds)
//        riderView.delegate = self
//        riderView.rideManager(rideManager!, update: .GPS)
//        self.view.addSubview(riderView)
            
    }

    private func driveManager(onCalculateRouteSuccess driveManager: AMapNaviDriveManager) {
        // 创建导航视图控制器
  
        
        // 开始导航
        
    }
    
    // 导航过程中的回调方法
    func driveManager(_ driveManager: AMapNaviDriveManager, onNaviInfoUpdate naviInfo: AMapNaviInfo) {
        // 导航信息更新，可以根据需要处理导航信息
    }
    
    
}

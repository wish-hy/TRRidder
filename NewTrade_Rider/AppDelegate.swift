//
//  AppDelegate.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/3.
//

import UIKit
import NotificationCenter
import Alamofire
import MZRSA_Swift
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate, JPUSHRegisterDelegate,WXApiDelegate {
    func jpushNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (Int) -> Void) {
        DispatchQueue.main.async {
            
        }
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) -> Int {
        return 1
    }
    
   
    
   
  
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    

    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification) {
        
    }
    
    func jpushNotificationAuthorization(_ status: JPAuthorizationStatus, withInfo info: [AnyHashable : Any]?) {
        
    }

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0.0
            UITableView.appearance().sectionHeaderTopPadding = CGFLOAT_MIN
        } else {
            // Fallback on earlier versions
        }
        NotificationCenter.default.addObserver(self, selector: #selector(getRiderInfo), name: .init("loginSuccess"), object: nil)
        let token = TRTool.getData(key: Save_Key_Token) as? String
        if TRTool.isNullOrEmplty(s: token) {
            TRTool.saveData(value: "", key: Save_Key_Token)
        }

        SVProgressHUD.setBackgroundColor(.black.withAlphaComponent(0.8))
        SVProgressHUD.setForegroundColor(.white)
        
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        
        let entity = JPUSHRegisterEntity()
        entity.types = 1 << 0 | 1 << 1 | 1 << 2
        
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        let userSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                            categories: nil)
        JPUSHService.register(forRemoteNotificationTypes: userSettings.types.rawValue,
                                          categories: nil)
        JPUSHService.setup(withOption: launchOptions, appKey: "36bd52161bc7a34ba1ff0ac7", channel: "channel", apsForProduction: false)
        // wxc35a9ea4949a5d45
        AMapServices.shared().apiKey = "fb6a80f98bc591bb925b0e8f8788e5fb"
        Bugly.start(withAppId: "8848b2e464")
        WXApi.registerApp("wxc35a9ea4949a5d45", universalLink: "https://fmyunwei.com/rider/")

        
        let newToken = TRTool.getData(key: Save_Key_Token) as! String
        if newToken.isEmpty {
            let loginController = TRLoginViewController()
            let loginNavVC = BasicNavViewController(rootViewController: loginController)
            window?.rootViewController = loginNavVC;
        } else {
            getRiderInfo()
         
        }

        // 接收消息
        NotificationCenter.default.addObserver(self, selector: #selector(receiveMsg), name: .init(Notification_Name_Receive_Message), object: nil)
        
        IQKeyboardManager.shared.isEnabled = true

        //网络检测
        let manager = NetworkReachabilityManager()
        manager?.startListening(onUpdatePerforming: { state in
            switch state {
            case .notReachable:
                SVProgressHUD.showInfo(withStatus: "网络未连接")
                NotificationCenter.default.post(name: NSNotification.Name(Notification_Name_Net_DisConnect), object: nil)

            case .unknown:
                break
            case .reachable(_):
                NotificationCenter.default.post(name: NSNotification.Name(Notification_Name_Net_Connect), object: nil)
                //此处要重新登录IM
                if !TRDataManage.shared.userModel.imToken.isEmpty {
                    ChatClient.sharedInstance.loginWithToken(TRDataManage.shared.userModel.imToken as NSString) { dict in
                        
                    }
                } else {
                    let temToken = TRTool.getData(key: Save_Key_Token) as? String

                    if !TRTool.isNullOrEmplty(s: temToken) {
                        self.getRiderInfo()
                    }
                }
                break
            }
        })
        
        return true
    }

    private func getIMInfo(){
        ChatClient.sharedInstance.configHost(host: Chat_IP,port: Chat_Port)
        TRNetManager.shared.get_no_lodding(url: URL_IM_Chat_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRUserManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                model.data.scPictureUrl = model.data.pictureUrl
                TRDataManage.shared.userModel = model.data
                ChatClient.sharedInstance.loginWithToken(TRDataManage.shared.userModel.imToken as NSString) {[weak self] dict in
                    guard let self = self else { return }
                }
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    
    @objc func getRiderInfo(){
//        var i = 2
//        if i == 2 {
//            let beginVC = TRHomeViewController()
//            let navVC = BasicNavViewController(rootViewController: beginVC)
//            
//            window?.rootViewController = navVC
//            return
//        }
        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Apply_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                guard let model = TRApplerRiderManange.deserialize(from: dict) else {return}
                let riderMode = model.data
                riderMode.dealNetModel()
//                TRDataManage.shared.curLongLat = model.data.cu
                
//                riderMode.riderInfo.curAuthStatus = "TRAINED"
//                riderMode.curWorkStatus = "ONLINE"
                
                TRDataManage.shared.applyModel = riderMode
                let state = riderMode.riderInfo.curAuthStatus           
                //审核中
                if state.elementsEqual("TRAINED") {
                    //只有骑手申请成功后，采取获取IM信息
                    getIMInfo()
                    TRDataManage.shared.riderModel = riderMode.riderInfo
                    if riderMode.curWorkStatus.elementsEqual("OFFLINE") {
                        let beginVC = TRHomeBeginVC()
                        let navVC = BasicNavViewController(rootViewController: beginVC)
                        window?.rootViewController = navVC
                    } else {
                        let homeVC = TRHomeViewController()
                        
                        let navVC = BasicNavViewController(rootViewController: homeVC)
                        window?.rootViewController = navVC
                    }
               
                } else if state.elementsEqual("UNSIGNED") || state.elementsEqual("SIGNED"){
                    getIMInfo()

                    let vc = TRRiderTrainViewController()
                    riderMode.dealNetModel()
                    vc.model = riderMode
                    let navVC = BasicNavViewController(rootViewController: vc)
                    window?.rootViewController = navVC
                } else if state.elementsEqual("REJECTED") {
                    getIMInfo()

                    let vc = TRAddRiderVViewController()
                    riderMode.dealNetModel()
                    vc.model = riderMode
                    let navVC = BasicNavViewController(rootViewController: vc)
                    window?.rootViewController = navVC
                } else if state.elementsEqual("UNAUDITED") {
                    getIMInfo()

                    let vc = TRAddRiderVViewController()
                    riderMode.dealNetModel()
                    vc.model = riderMode
                    let navVC = BasicNavViewController(rootViewController: vc)
                    window?.rootViewController = navVC
                } else if state.elementsEqual("UNTRAINED") {
                    getIMInfo()

                    let vc = TRRiderApplyStateViewController()
                    riderMode.dealNetModel()
                    vc.model = riderMode
                    let navVC = BasicNavViewController(rootViewController: vc)
                    window?.rootViewController = navVC
                }
            } else if codeModel.exceptionCode == Net_Code_RIDER_Not_Exist {
                let vc = TRAddRiderVViewController()
                let navVC = BasicNavViewController(rootViewController: vc)
                window?.rootViewController = navVC
            } else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
                let loginController = TRLoginViewController()
                let loginNavVC = BasicNavViewController(rootViewController: loginController)
                window?.rootViewController = loginNavVC;
                //取消所有请求
                TRNetManager.shared.cancelAllQuery()
            }
            
        }
    }

    //收到一条消息,目前只会接受别人的消息
    @objc func receiveMsg(noti : Notification){
        //updateList
        let cc = ChatClient.sharedInstance
        let mm = noti.object as! ChatMsgModel
        //更新信息 更新会话
        let session = cc.getSession(sessionID: mm.sessionID)
        if session == nil {
            //创建一个会话
            createNewSession(mm: mm)
        } else {
            //更新会话
            cc.insertMessageList(sessionID: mm.sessionID, data: [mm])
            session!.lastMessage = mm.msgContent
            session!.lastMessageType = mm.type
            session!.lastMessageTime = mm.sendTime
            session!.unread = session!.unread + 1
            session!.scUserId = TRDataManage.shared.userModel.scUserId
            cc.updateSessionMsg(newSession: session!)
            //此处要通知 消息页面更新 当会话不存在是 不会有消息页
            NotificationCenter.default.post(name: .init(Notification_Name_Update_Message), object: nil)
        }
        ChatUtil.shared.playMessageComeVoice()

    }
    //根据消息，，，，，，拉取会话
    private func createNewSession(mm : ChatMsgModel){
        let cc = ChatClient.sharedInstance
        cc.pullNewSession(sessionID: "\(mm.sessionID)") {[weak self] ret in
            guard let self = self else {return}
            if ret == 1 {
                let session = cc.getSession(sessionID: mm.sessionID)
                session!.lastMessage = mm.msgContent
                session!.lastMessageType = mm.type
                session!.lastMessageTime = mm.sendTime
                session!.scUserId = TRDataManage.shared.userModel.scUserId
                cc.insertMessageList(sessionID: mm.sessionID, data: [mm])
                cc.updateSessionMsg(newSession: session!)
                //刷新列表
//                refreshSessionList()
                NotificationCenter.default.post(name: .init(Notification_Name_Update_Message), object: nil)

            }
        }
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        [JPUSHService registerDeviceToken:deviceToken];
        JPUSHService.registerDeviceToken(deviceToken)
        
        
//        let vc = UIAlertController(title: "registerID", message: JPUSHService.registrationID(), preferredStyle: .alert)
//        let action = UIAlertAction(title: "复制", style: .default) { _ in
//            UIPasteboard.general.string = JPUSHService.registrationID()
//        }
//        vc.addAction(action)
//        self.window?.rootViewController?.present(vc, animated: true)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        //
        
        return WXApi.handleOpenUniversalLink(userActivity, delegate: self)
    }


    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // str    String    "fanmiao.gamma.mall://backfromalipay?errCode=9999&errStr=%E8%AE%A2%E5%8D%95%E5%B7%B2%E6%94%AF%E4%BB%98"
        //str    String    "fanmiao.gamma.mall://backfromalipay?errCode=0000&errStr=%E6%94%AF%E4%BB%98%E6%88%90%E5%8A%9F"
        let str = url.absoluteString
        
        if str.hasPrefix("fanmiao.gamma.rider://") {
            if str.contains("backfromalipay") {
                //支付宝
                UMSPPPayUnifyPayPlugin.aliMiniPayHandleOpen(url)
                let url = URL.init(string: str)

                guard let components = URLComponents(url: url!, resolvingAgainstBaseURL: true) else {return true}
                guard let queryItems = components.queryItems else { return true}
                
                queryItems.reduce(into: [String : String].self) { partialResult, item in
                    if item.name.elementsEqual("errCode") {
                        let code = item.value ?? ""
                        if code.elementsEqual("1003") {
                            SVProgressHUD.showInfo(withStatus: "请安装支付宝客户端")
                        } else if code.elementsEqual("1000") {
                            SVProgressHUD.showInfo(withStatus: "取消支付")
                        } else if code.elementsEqual("1002") {
                            SVProgressHUD.showInfo(withStatus: "网络连接错误")
                        } else if code.elementsEqual("1001") {
                            SVProgressHUD.showInfo(withStatus: "参数错误")
                        } else if code.elementsEqual("2003") {
                            SVProgressHUD.showInfo(withStatus: "订单支付失败")
                        } else if code.elementsEqual("9999") {
                            SVProgressHUD.showInfo(withStatus: "其他支付错误")
                        } else if code.elementsEqual("2002") {
                            SVProgressHUD.showInfo(withStatus: "订单号重复")
                        } else if code.elementsEqual("2001") || code.elementsEqual("0000"){
                            NotificationCenter.default.post(name: .init(Notification_Name_Pay_Suceess), object: nil)
                        } else {
                            
                        }
                    }
                }
            } else {
                //微信 需要确定返回的内容
               
                return  WXApi.handleOpen(url, delegate: self)
            }
        }
        return WXApi.handleOpen(url, delegate: self)
    }
    func onReq(_ req: BaseReq) {
        print("1    ")
    }
    func onResp(_ resp: BaseResp) {
        if resp.isKind(of: WXLaunchMiniProgramResp.self) {
            let res = resp as! WXLaunchMiniProgramResp;
            let code = res.extMsg ?? ""
            if code.elementsEqual("1003") {
                SVProgressHUD.showInfo(withStatus: "请安装支付宝客户端")
            } else if code.elementsEqual("1000") {
                SVProgressHUD.showInfo(withStatus: "取消支付")
            } else if code.elementsEqual("1002") {
                SVProgressHUD.showInfo(withStatus: "网络连接错误")
            } else if code.elementsEqual("1001") {
                SVProgressHUD.showInfo(withStatus: "参数错误")
            } else if code.elementsEqual("2003") {
                SVProgressHUD.showInfo(withStatus: "订单支付失败")
            } else if code.elementsEqual("9999") {
                SVProgressHUD.showInfo(withStatus: "其他支付错误")
            } else if code.elementsEqual("2002") {
                SVProgressHUD.showInfo(withStatus: "订单号重复")
            } else if code.elementsEqual("2001") || code.elementsEqual("0000"){
                NotificationCenter.default.post(name: .init(Notification_Name_Pay_Suceess), object: nil)
            } else {
                
            }
            
            
        }
    }
    
    
}


//
//  TRTaskDetailViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit
import RxCocoa
import RxSwift
class TRTaskDetailViewController: BasicViewController, JYPulleyDrawerDelegate, AMapNaviCompositeManagerDelegate {
    var mapView : TRMapView!
    var detailView : TRTaskDetailView!
    var bottomView : TRTaskDetailBottomView!
    var compositeManager : AMapNaviCompositeManager!
    var rideManager :AMapNaviEleBikeManager!
    var pickupBottomView : TRPickupDetailBottomView!
    
    var doneBottomView : TRDoneDetailBottomView!
    let bag = DisposeBag()
    
    let bottomH = IS_IphoneX ? 100.0 : 70.0
    // 1 抢单 2 取货 3 配送中
    //
    var type : Int = 1
    
    //: navType = .ride
    var trafficType : navType = .ride
    private var doneCode : String = ""
    var model : TROrderModel?
    
    //正在上报异常
    private var isReporting : Bool = false
    deinit {
        print("aaa")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        TRRoutePlan.shared.deinitManager()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //补差价的订单通知
        NotificationCenter.default.addObserver(self, selector: #selector(configNetData), name: .init(Notification_Name_Patch_Order), object: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        _ = configNavLeftBtn()
        if type == 1 {
            configNavTitle(title: "任务详情")
        }else if type == 2 {
            configNavTitle(title: "取货详情")
        } else if type == 3 {
            configNavTitle(title: "配送详情")
        }else{
            configNavTitle(title: "任务详情")
        }
        self.compositeManager = AMapNaviCompositeManager.init()
        self.compositeManager.delegate = self
        navBar?.backgroundColor = .white
        let innerRect = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - bottomH - Nav_Height)
        
        let rect = CGRect(x: 0, y: Nav_Height, width: Screen_Width, height: Screen_Height - bottomH - Nav_Height)
        mapView = TRMapView(frame: innerRect)
       
        mapView.typeBlock = {[weak self] (type) in
            guard let self  = self  else { return }
            if type == 1 {
                trafficType = .walk
            } else if type == 2 {
                trafficType = .ride
            } else if type == 3 {
                trafficType = .hud
            }
        }
        detailView = TRTaskDetailView(frame: innerRect)

        detailView.block = {[weak self] (qos, type) in
            guard let self  = self else { return }
            let shared = TRRoutePlan.shared
            if shared.driveManager == nil && shared.walkManager == nil && shared.rideManager == nil {
                SVProgressHUD.showInfo(withStatus: "请选择交通方式")
                return
            }
            var nav : navType = trafficType
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
            var ep = AMapNaviPoint.location(withLatitude: lat!, longitude: lon!)!
            //取
            if qos == 2 {
                let point = model!.receiverLongLat
                if point.isEmpty || !point.contains(",") {
                    SVProgressHUD.showInfo(withStatus: "获取用户/送货点位置失败")
                    return
                }
                let arr = point.components(separatedBy: ",")
                let lat  = Double.init(arr.last ?? "0")
                let lon = Double.init(arr.first ?? "0")
                if lat == 0 || lat == nil || lon == nil || lon == 0 {
                    SVProgressHUD.showInfo(withStatus: "获取用户/送货点位置失败")
                    return
                }
                ep = AMapNaviPoint.location(withLatitude: lat!, longitude: lon!)!
            }
            
            if trafficType == .walk {
                nav = .walk
                shared.navWalkPlan(ep: ep)
            } else if trafficType == .ride {
                nav = .ride
                shared.navRiderPlan(ep: ep)
            } else {
                nav = .hud
                shared.navDrivePlan(ep: ep)
            }
//            let config = AMapNaviCompositeUserConfig.init()
//            config.setRoutePlanPOIType(AMapNaviRoutePlanPOIType.end, location:ep, name: "", poiId: nil)  //传入终点
//            config.setStartNaviDirectly(true) //直接进入导航界面
//           
//            self.compositeManager.presentRoutePlanViewController(withOptions: config)
            let vc = TRTimeNavViewController()
            vc.startPoint = mapView.sp
            vc.endPoint = ep
            vc.type = nav
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc , animated: true)
//                shared.navBlock = {
//                    SVProgressHUD.dismiss()
//                    DispatchQueue.main.async {
//                      
//                    }
//                }
            
            
            
        }
        let pullView = JYPulleyContentView(frame: rect)
        
        pullView.drawerDelegate = self
        pullView.configMainView(mapView, subView: detailView)
        self.view.addSubview(pullView)
        if type == 1 {
            configBottomView()
        } else if type == 2 {
            configPickupBottomView()
        } else if type == 3 {
            configDoneBottomView()
        }
        
        configNetData()
        detailView.type = type
        detailView.model = model
        detailView.vc = self
        mapView.order = self.model
    }

    @objc private func configNetData(){
        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Order_Detail, pars: ["orderNo": model!.orderNo]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TROrderContainer.deserialize(from: dict) else {return}
            //处理remark
            model.data.dealRemark()
            self.model = model.data
            detailView.model = self.model
            mapView.order = self.model
            if TRDataManage.shared.riderModel.pathType.elementsEqual("DRIVEWAY") {
                mapView.type = .hud
            } else {
                mapView.type = .ride
            }
            if type == 2 {
                pickupBottomView.model = self.model
            }
        }
    }
    private func acceptOrder(order : TROrderModel) {
        let countDownView = TRCountDownPopView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        countDownView.addToWindow()
        countDownView.suceBlock = { (x) in
            let pop = TRPopView(frame: .zero)
            pop.icon.image = UIImage(named: "pop_success")
            pop.lab.text = "抢单成功"
            pop.addToWindow()
        }
        countDownView.cancelBlock = { (x) in
            let pop = TRPopView(frame: .zero)
            pop.icon.image = UIImage(named: "pop_fail")
            pop.lab.text = "抢单失败"
            pop.addToWindow()
        }
        
        SVProgressHUD.show()
        TRNetManager.shared.post_no_lodding(url: URL_Order_Action_Accept, pars: ["orderNo":order.orderNo]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[self] in

                    countDownView.successAction()
                    NotificationCenter.default.post(name: .init(Notification_Name_Order_Accept), object: nil)
                    self.navigationController?.popViewController(animated:true)
                }
            } else {
//                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
                countDownView.failAction()

            }
        }
    }
    private func doneAction(order : TROrderModel) {
        var pars = ["orderNo" : order.orderNo]
        if order.hasCode {
            pars["receiverCode"] = doneCode
        }
        TRNetManager.shared.put_no_lodding(url: URL_Order_Action_Done, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "已送达")
                NotificationCenter.default.post(name: .init(Notification_Name_Order_Done), object: nil)
                self.navigationController?.popViewController(animated:true)
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    private func takeAction(order : TROrderModel) {

        let pickupView = TRPickupView(frame: .zero)
        pickupView.addToWindow()
        pickupView.block = {[weak self] _ in
            guard let self  = self  else { return }
            let pars = ["orderNo" : order.orderNo]
    //            SVProgressHUD.show()
            TRNetManager.shared.put_no_lodding(url: URL_Order_Action_Take, pars: pars) {[weak self] dict in
                guard let self = self else {return}
                guard let model = TRCodeModel.deserialize(from: dict) else {return}
                if model.code == 1 {
                    SVProgressHUD.showSuccess(withStatus: "取货完成")
                    NotificationCenter.default.post(name: .init(Notification_Name_Order_Pickup), object: nil)
                    self.navigationController?.popViewController(animated:true)
                } else {
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                }
            }
        }

    }
    private func getPrivacyPhone(model : TROrderModel){
        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Order_Privacy_Phone, pars: ["orderNo":model.orderNo]) {[weak self] dict in
            guard let self = self else {return}
            guard let manage = TRPrivacyConcactManage.deserialize(from: dict) else {return}
            if manage.code == Net_Code_Success {
                contactPhone(model: model, contactModel : manage.data)
            } else {
                SVProgressHUD.showInfo(withStatus: manage.exceptionMsg)
            }
        }
    }
    private func contactPhone(model : TROrderModel,contactModel : TRPrivacyConcactModel) {
        let contactView = TRContactBottomView(frame: .zero)
        //发短信的高度 74
        contactView.contentHeight = 358 + 10 - (IS_IphoneX ? 0 : 35)
        contactView.addToWindow()
        contactView.openView()
        //        contactView.type = type
        //        contactView.order = model
        // // 1 抢单 2 取货 3 配送中
        contactView.type = self.type
        contactView.order = model
        contactView.contactModel = contactModel
        contactView.block = {[weak self](index) in
            guard let self  = self  else { return }
            if index == 1 {
                contactView.closeView()
                TRTool.callPhone(contactModel.phoneNo)

            } else if index == 2 {
                contactView.closeView()
                TRTool.callPhone(contactModel.phoneNo)

            } else {
                var uid = model.scStoreUserId
                if type == 2 {
                    uid = model.scStoreUserId
                } else {
                    uid = model.scMemberUserId
                }
                ChatClient.sharedInstance.createNewSession(receiveID: uid) { code in
                    if code == 0 {
                        SVProgressHUD.showInfo(withStatus: "暂时无法聊天，请电话联系")
                    } else {
                        contactView.closeView()
                        let cc = ChatClient.sharedInstance.getSession(sessionID: "\(code)")
                        if cc != nil {
                            let chatVC = TRChatViewController()
                            chatVC.sessionModel = cc
                            chatVC.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(chatVC , animated: true)
                        }
                    }
                }
                
            }
        }
    }
   
    // 获取异常原因编码列表
    private func reportAction() {
        //1 抢单 2 取货 3 配送中
        var url = URL_Order_Reason_Taking
        if type == 2 {
            url = URL_Order_Reason_Taking
        } else {
            url = URL_Order_Reason_Delivery
        }
        TRNetManager.shared.get_no_lodding(url: url,pars: ["deliveryType":model!.deliveryType]) {[weak self] dict in
            guard let self = self else {return}
            guard let reasonModel = TROrderReasonManage.deserialize(from: dict) else {return}
            if reasonModel.code == 1 {
                if !reasonModel.data.isEmpty {
                    let reportView = TRBottomReportPopVIew(frame: .zero)
                    reportView.orderModel = self.model
                    reportView.viewController = self
                    if type == 2 {
                        reportView.contentHeight = 415 + (IS_IphoneX ? 25 : 0)
                    } else {
                        reportView.contentHeight = 375 + (IS_IphoneX ? 25 : 0)
                    }
                    reportView.type = type;
                    reportView.reasonList = reasonModel.data
                    reportView.addToView(v: self.view)
                    reportView.openView()
                    
                    reportView.block = {[weak self] in
                        guard let self = self  else { return }
                        uploadException(model: model!,reportView : reportView)
                        
                    }
                } else {
                    SVProgressHUD.showInfo(withStatus: "异常原因未配置")
                }
            } else {
                SVProgressHUD.showInfo(withStatus: reasonModel.exceptionMsg)
            }
        }
    }
    //异常上报
    private func uploadException(model : TROrderModel, reportView : TRBottomReportPopVIew) {
        if isReporting {
            return
        }
        var url = ""
        if type == 2 {
            // 取货异常
            url = URL_Order_Action_Take_Report
        } else {
            // 配送异常
            url = URL_Order_Action_Delivering_Report
        }
        let reportM = reportView.currentReason!
        let pars = ["deliveryOrderNo" : model.orderNo,
                    "reportResource": reportView.netLocImgModel.getName(),
                    "hasCancel" : reportM.hasCanCancel,
                    "configId" : reportM.id,
                    "exceptionDesc" : reportM.exceptionReason,
                    "code" : reportM.code] as [String : Any]
        isReporting = true
        TRNetManager.shared.post_no_lodding(url: url, pars: pars as [String : Any]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "上报成功")
                reportView.closeView()
                isReporting = false
                //要取消订单
                if reportM.hasCanCancel {
                    NotificationCenter.default.post(name: .init(Notification_Name_Order_Cancel), object: nil)
                    self.navigationController?.popViewController(animated:true)
                }
            } else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
            }
        }
    }
    private func patchAmountAction(){
        //
        let patchView = TRPatchAmountPopView(frame: .zero)
        patchView.model = model!
        patchView.contentHeight = 447
        patchView.addToWindow()
        patchView.openView()
        
        
        
    }
    private func configBottomView(){
        bottomView = TRTaskDetailBottomView(frame: .zero)
        bottomView.priceLab.text = model!.deliverAmount
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(bottomH)
        }
        
        bottomView.qdBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            acceptOrder(order: model!)
        }).disposed(by: bag)
    }
    private func configPickupBottomView(){
        pickupBottomView = TRPickupDetailBottomView(frame: .zero)
//        pickupBottomView.priceLab.text = model!.deliverAmount
        pickupBottomView.model = self.model
        self.view.addSubview(pickupBottomView)
        pickupBottomView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(bottomH)
        }
        
        pickupBottomView.contactBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self else { return }
            guard let model = model else {
                SVProgressHUD.showInfo(withStatus: "正在获取订单信息")
                return
            }
           getPrivacyPhone(model: model)
            
        }).disposed(by: bag)
        
        pickupBottomView.questionBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return  }
            
            reportAction()
            
        }).disposed(by: bag)
        
        pickupBottomView.traOrderBtn.rx.tap.subscribe(onNext : {[weak self] in
            let transOrderView =  TRBottomTransOrderPopVIew(frame: .zero)
            transOrderView.contentHeight = 421 + 56 - (IS_IphoneX ? 0 : 35)
            transOrderView.addToWindow()
            transOrderView.openView()
            
        }).disposed(by: bag)
        
        pickupBottomView.patchAmountBtn.rx.tap.subscribe (onNext : {[weak self] in
            guard let self = self else {return}
            patchAmountAction()
        }).disposed(by: bag)
        pickupBottomView.pickupBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self else { return }
            // 2:补差价待支付
            if model!.subType != 2 {
                takeAction(order: model!)
            }
            
        }).disposed(by: bag)
        
    }
    private func configDoneBottomView(){
        doneBottomView = TRDoneDetailBottomView(frame: .zero)
        self.view.addSubview(doneBottomView)
        doneBottomView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(IS_IphoneX ? 100 : 75)
        }
        
        doneBottomView.contactBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self = self  else { return  }
            guard let model = model else {
                SVProgressHUD.showInfo(withStatus: "正在获取订单信息")
                return
            }
//            let contactView = TRContactBottomView(frame: .zero)
//            contactView.contentHeight = 358 + 84 - (IS_IphoneX ? 0 : 35)
//            contactView.addToWindow()
//            contactView.openView()
            getPrivacyPhone(model: model)

        }).disposed(by: bag)
        
        doneBottomView.questionBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return  }
            reportAction()
           
        }).disposed(by: bag)
        
        doneBottomView.doneBtn.rx.tap.subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            if !model!.hasCode {
                let pickupView = TRPickupView(frame: .zero)
                pickupView.tipLab.text = "是否确认送达"
                pickupView.tipLab.text = "提示：您当前已到达送达区域附近"
                pickupView.sureBtn.setTitle("确认送达", for: .normal)
                pickupView.addToWindow()
                pickupView.block = {[weak self] (ret) in
                    guard let self  = self else { return  }
                    doneAction(order: model!)
                }
                return
            }
                
                
            
            //开启收货码
            let pickupView = TRPickupCodePopVIew(frame: .zero)
            pickupView.contentHeight = 217 + 37 - (IS_IphoneX ? 0 : 35)
            pickupView.addToWindow()
            pickupView.openView()
            
            pickupView.block = {[weak self] code  in
                guard let self = self  else { return }
                self.doneCode = code
                pickupView.closeViewWithAction {[weak self] (ret) in
                    let pickupView = TRPickupView(frame: .zero)
                    pickupView.tipLab.text = "是否确认送达"
                    pickupView.tipLab.text = "提示：您当前已到达送达区域附近"
                    pickupView.sureBtn.setTitle("确认送达", for: .normal)
                    pickupView.addToWindow()
                    pickupView.block = {[weak self] (ret) in
                        guard let self  = self else { return  }
                        doneAction(order: model!)
                    }
                }
            }
            
        }).disposed(by: bag)
        
    }

   
    
    func pulleyContentView(_ pulleyContentView: JYPulleyContentView, didChange status: JYPulleyStatus) {
        if status == .expand {
            detailView.tableView.isScrollEnabled = true
        } else {
            detailView.tableView.isScrollEnabled = false
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

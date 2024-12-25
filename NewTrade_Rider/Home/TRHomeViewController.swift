//
//  TRHomeViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/3.
//

import UIKit
import RxCocoa
import RxSwift
import AMapSearchKit
class TRHomeViewController: BasicViewController {
    var homeBar : TRHomeNavBar!
    
    //导航
    var navTipBtn : UIButton!
    var navStateView : TRHomeStateView!
    var navMessageBtn : UIButton!
    //设置
    var setView : TRHomeBeginSetView!
    var selectView : TRHomeStateSelView!
    
    //菜单
    var menuView : TRScrollMenuView!
    var locBtn : UIButton!
    //
    var mainView : TRHomeMainView!
    let bag = DisposeBag()
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AMapSearchAPI.updatePrivacyAgree(.didAgree)
        AMapSearchAPI.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        //        configBeginView()
        
        configHeader()
        configMainView()
        
        
        configNav()
        //        navMessageBtn.setImage(UIImage(named: "home_message_white"), for: .normal)
        //        navBar?.leftView = self.navStateView
        
        NotificationCenter.default.addObserver(self, selector: #selector(riderOrderStaticsInfo), name: .init(Notification_Name_Order_Accept), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(riderOrderStaticsInfo), name: .init(Notification_Name_Order_Pickup), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(riderOrderStaticsInfo), name: .init(Notification_Name_Order_Cancel), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(riderOrderStaticsInfo), name: .init(Notification_Name_Order_Done), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(riderOrderStaticsInfo), name: .init(Notification_Name_Location_Update), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(riderOrderStaticsInfo), name: .init(Notification_Home_refresh), object: nil)
        
    }
    
    
    //主视图
    private func configMainView(){
        mainView = TRHomeMainView(frame: .zero)
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(170 * APP_Scale)
        }
        
        mainView.indexChangeBlock = {index in
            self.menuView.currentSel = index
        }
        TRGCDTimer.share.createTimer(withName: "uploc", timeInterval: 60, queue: .global(), repeats: true) {[self] in
            uploadRiderLocation()
        }
        
    }
    //骑手订单统计
    @objc private func riderOrderStaticsInfo(){
        /*
         "lat": "22.580266102819525",
         "lon": "113.92285578505573"
         */
        var arr : [String] = []
        if !TRDataManage.shared.curLongLat.isEmpty {
            arr = TRDataManage.shared.curLongLat.components(separatedBy: ",")
            if arr.count != 2 {
                SVProgressHUD.showInfo(withStatus: "位置信息异常")
                return
            }
        }
        let subPars = [
            "lat": arr.last ?? "22.583632",
            "lon": arr.first ?? "113.917587"
        ] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Order_Count_Statistics, pars: subPars) {[weak self] dict in
            guard let self = self else {return}
            guard let manage = TROrderCountManage.deserialize(from: dict) else {return}
            if manage.code == Net_Code_Success {
                menuView.model = manage.data
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.riderOrderStaticsInfo()
//        TKPermissionLocationAlways.auth(withAlert: true) {[weak self] ret in
//            guard let self = self else {return}
//            if ret {
//                TRLocation.shared.startObserving { loc,_  in
//                    TRDataManage.shared.curLongLat = "\(loc!.coordinate.longitude),\(loc!.coordinate.latitude)"
//                    self.riderOrderStaticsInfo()
        NotificationCenter.default.post(name: .init(Notification_Name_Location_Update), object: nil)
//        self.mainView.collectionView.reloadData()
//                }
//            }
//        }
        //开启定位，一直开启
        //        DispatchQueue.global(priority: .default).asyncAfter(deadline: .now() + 10, execute: .init(block: {
        //            TKPermissionLocationAlways.auth(withAlert: true) { ret in
        //
        //                TRLocation.shared.startUpdatingObserving()
        //            }
        //        }))
        
        
        
        
    }
    
    //开工准备 之前的开工逻辑 不用了
    private func configBeginView(){
        let beginView = TRBeginView(frame: .zero)
        beginView.vc = self
        view.addSubview(beginView)
        self.view.backgroundColor = .bgColor()
        beginView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(15)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.bottom.equalTo(self.view)
        }
        
        beginView.block = {_ in
            //
            self.configHeader()
            self.configMainView()
            self.navMessageBtn.setImage(UIImage(named: "home_message_white"), for: .normal)
            self.navBar?.leftView = self.navStateView
            self.view.bringSubviewToFront(self.navBar!)
        }
    }
    
    private func configNav(){
        homeBar = TRHomeNavBar(frame: .zero)
        self.view.addSubview(homeBar)
        homeBar.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(Nav_Height)
        }
        
        
        //        configNavBar()
        //        navTipBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 28))
        //        navTipBtn.setTitle("准备开工接单！", for: .normal)
        //        navTipBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        //        navTipBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        //        navBar?.leftView = navTipBtn
        //
        //        navMessageBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        //        navMessageBtn.setImage(UIImage(named: "message"), for: .normal)
        //
        //        navBar?.rightView = navMessageBtn
        //        navStateView = TRHomeStateView(frame: CGRect(x: 0, y: 0, width: 113, height: 38))
        homeBar.stateView.block = {_ in
            if (self.selectView == nil) {
                self.selectView = TRHomeStateSelView(frame: self.view.bounds)
                self.view.addSubview(self.selectView)
                self.selectView.isHidden = true
                self.selectView.block = {[weak self] type in
                    guard let self  = self else { return }
                    homeBar.stateView.state = type
                    if type == 1 {
                        let beginVC = TRHomeBeginVC()
                        let navVC = BasicNavViewController(rootViewController: beginVC)
                        
                        UIApplication.shared.keyWindow?.rootViewController = navVC
                    }
                }
            }
            
            self.selectView.isHidden = !self.selectView.isHidden
        }
        
        homeBar.mesBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self  else { return }
            let vc = TRMessageViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
    }
    
    private func configHeader(){
        let bgImgV = UIImageView()
        bgImgV.image = UIImage(named: "home_nav_bg")
        view.addSubview(bgImgV)
        bgImgV.isUserInteractionEnabled = true
        bgImgV.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 170 * APP_Scale)
        
        
        menuView = TRScrollMenuView(frame: .zero)
        
        bgImgV.addSubview(menuView)
        
        locBtn = UIButton()
        locBtn.isHidden = true
        locBtn.setImage(UIImage(named: "home_loc"), for: .normal)
        locBtn.setTitle("路线", for: .normal)
        bgImgV.addSubview(locBtn)
        locBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImgV).inset(16)
            make.width.equalTo(70)
            make.height.equalTo(26)
            make.bottom.equalTo(bgImgV).inset(12)
        }
        menuView.snp.makeConstraints { make in
            make.left.equalTo(bgImgV)
            make.bottom.equalTo(bgImgV)
            make.height.equalTo(38)
            make.right.equalTo(locBtn)
        }
        
        menuView.block = {index in
            self.mainView.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        }
        // MARK: - 暂时隐藏
        //        locBtn.isHidden = true
        locBtn.rx.tap.subscribe(onNext: {[weak self] in
            //            SVProgressHUD.showInfo(withStatus: "暂不支持路径规划")
            //            if TRDataManage.shared.hasOrder {
            //                let vc = TRNavigationViewController()
            //                vc.hidesBottomBarWhenPushed = true
            //                self?.navigationController?.pushViewController(vc, animated: true)
            //            } else {
            //                SVProgressHUD.showInfo(withStatus: "没有进行中的订单")
            //            }
        }).disposed(by: bag)
    }
    
    
    //开工设置
    open func openSetView(){
        TRNetManager.shared.get_no_lodding(url: URL_Me_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRUserManage.deserialize(from: dict) else {return}
            setView = TRHomeBeginSetView(frame: .zero)
            setView.vc = self
            setView.setModel = model.data
            setView.addToWindow()
            setView.openView()
            
            //            userModel = model.data
            //            userModel.dealNetData()
            //            collectionView.reloadData()
        }
    }
    
    
    //上报骑手位置
    func uploadRiderLocation(){
        
        //        if TRDataManage.shared.curLongLat.isEmpty {
        //            return
        //        }
        
        TKPermissionLocationAlways.auth(withAlert: false) {[weak self] ret in
            guard let self = self else {return}
            if ret {
                TRLocation.shared.startObserving { loc,_  in
                    TRDataManage.shared.curLongLat = "\(loc!.coordinate.longitude),\(loc!.coordinate.latitude)"
                    //                    self.riderOrderStaticsInfo()
                    //                    NotificationCenter.default.post(name: .init(Notification_Name_Location_Update), object: nil)
                    TRNetManager.shared.put_no_lodding(url: URL_UpLoction, pars: ["curLongLat":TRDataManage.shared.curLongLat]) {[weak self] dict in
                        guard let self = self else {return}
                        guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
                        if codeModel.code == Net_Code_Success {
                            
                        } else {
                            
                        }
                    }
                    
                }
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

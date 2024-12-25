//
//  TRNavigationViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit
import RxCocoa
import RxSwift
class TRNavigationViewController: BasicViewController, JYPulleyDrawerDelegate {
    var mapView : TRMapView!
    var detailView : TRNaigationDetailView!
    var bottomView : TRNavigationBottomView!
    var type : navType = .hud {
        didSet {
            mapView.type = type
        }
    }
    //1 取 2 送
    var navType : Int = 1
    var order : TROrderModel!
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configNavBar()
//        configNavTitle(title: "路线详情")
//        configNavLeftBtn()
//        navBar?.backgroundColor = .white
//        configBottomView()
//        configMapView()
//        configDetailView()
        if order == nil {
            SVProgressHUD.showInfo(withStatus: "没有订单信息")
            self.navigationController?.popViewController(animated: true)
            return
        }
        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "路线详情")
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
//        btn.setTitle("GO", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
//        navBar?.rightView = btn
//        btn.addTarget(self, action: #selector(gogog), for: .touchUpInside)
        
        navBar?.backgroundColor = .white
        let innerRect = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - Nav_Height)
        
        let rect = CGRect(x: 0, y: Nav_Height, width: Screen_Width, height: Screen_Height - Nav_Height)
        mapView = TRMapView(frame: innerRect)
        mapView.order = order
        mapView.typeBlock = {[weak self](index) in
            guard let self  = self else { return }
            if index == 1 {
                self.type = .walk
            } else if index == 2 {
                self.type = .ride
            } else if index == 3 {
                self.type = .hud
            }
        }
        
        detailView = TRNaigationDetailView(frame: innerRect)
        detailView.order = order
        detailView.nagType = navType
//        detailView.model = model
//        detailView.type = type
//        detailView.vc = self
//
        detailView.navBlock = {[weak self] in
            guard let self  = self  else { return  }
            let vc = TRTimeNavViewController()
            vc.type = type
            self.navigationController?.pushViewController(vc , animated: true)
        }
        let pullView = JYPulleyContentView(frame: rect)
        
        pullView.drawerDelegate = self
        pullView.configMainView(mapView, subView: detailView)
        self.view.addSubview(pullView)
        self.type = .ride
        mapView.eleBtn.tintColor = .hexColor(hexValue: 0x13D066)
    }

    deinit {
        TRRoutePlan.shared.deinitManager()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
         self.startPoint = [AMapNaviPoint locationWithLatitude:22.59449 longitude:113.96434];
         self.endPoint   = [AMapNaviPoint locationWithLatitude:22.58949 longitude:113.95134];
         */
        
    }
 
    private func configDetailView(){
        detailView = TRNaigationDetailView(frame: .zero)
        self.view.addSubview(detailView)
        detailView.vc = self
        detailView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(bottomView.snp.top).offset(0)
            make.top.equalTo(self.view).offset(Nav_Height)
        }
    }
    private func configMapView(){
        mapView = TRMapView(frame: .zero)
        self.view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.bottom.equalTo(bottomView.snp.top).offset(-35)
        }
    }
    private func configBottomView(){
        bottomView = TRNavigationBottomView(frame: .zero)
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(IS_IphoneX ? 100 : 75)
        }
        
        bottomView.pickupBtn.rx.tap.subscribe(onNext : {[weak self] in
       
            
            
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

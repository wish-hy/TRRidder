//
//  TRPickupDetailViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit
import RxCocoa
import RxSwift
class TRPickupDetailViewController: BasicViewController, JYPulleyDrawerDelegate {
    var mapView : TRMapView!
    var detailView : TRPickupDetailView!
    var bottomView : TRPickupDetailBottomView!
    
    let bag = DisposeBag()
    let bottomH = IS_IphoneX ? 100.0 : 70.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavBar()
        configNavLeftBtn()
        navBar?.backgroundColor = .white
        configNavTitle(title: "取货详情")
        
        let innerRect = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - bottomH - Nav_Height)

        let rect = CGRect(x: 0, y: Nav_Height, width: Screen_Width, height: Screen_Height - bottomH - Nav_Height)
        mapView = TRMapView(frame: innerRect)

        detailView = TRPickupDetailView(frame: innerRect)
        detailView.vc = self
        
        let pullView = JYPulleyContentView(frame: rect)
        
        pullView.drawerDelegate = self
        pullView.configMainView(mapView, subView: detailView)
        self.view.addSubview(pullView)
        
        configBottomView()
        
    }
    

    private func configBottomView(){
        bottomView = TRPickupDetailBottomView(frame: .zero)
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(bottomH)
        }
        
        bottomView.contactBtn.rx.tap.subscribe(onNext : {[weak self] in
            let contactView = TRContactBottomView(frame: .zero)
            contactView.contentHeight = 358 + 84 - (IS_IphoneX ? 0 : 35)
            contactView.addToWindow()
            contactView.openView()
        }).disposed(by: bag)
        
        bottomView.questionBtn.rx.tap.subscribe(onNext : {[weak self] in
            
            let reportView = TRBottomReportPopVIew(frame: .zero)
            reportView.viewController = self

            reportView.contentHeight = 415 + 30 - (IS_IphoneX ? 0 : 35)
            reportView.addToWindow()
            reportView.openView()
            
        }).disposed(by: bag)
        
        bottomView.traOrderBtn.rx.tap.subscribe(onNext : {[weak self] in
            let transOrderView =  TRBottomTransOrderPopVIew(frame: .zero)
            transOrderView.contentHeight = 421 + 56 - (IS_IphoneX ? 0 : 35)
            transOrderView.addToWindow()
            transOrderView.openView()
            
        }).disposed(by: bag)
        
        bottomView.pickupBtn.rx.tap.subscribe(onNext : {[weak self] in
            let pickupView = TRPickupView(frame: .zero)
            pickupView.addToWindow()
            
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

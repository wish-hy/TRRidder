//
//  TRMineViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/3.
//

import UIKit
import RxCocoa
import RxSwift
class TRMineViewController: BasicViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let bag = DisposeBag()
    var collectionView : UICollectionView!
    
    let moreFuncTitles = ["我的统计", "接单设置", "车辆管理","申请骑手", "邀请骑手", /*"充电桩", "邀请骑手", "骑手保险", */"服务中心", "设置"]
    let moreFuncImageTitles = ["func_tongji", "func_orderSetting", "func_trafficnManage","func_trafficnManage", "func_yq",/*"func_recharge", "func_yq", "func_bx",*/"func_service_center", "func_setting"]
    
    private var userModel : TRUserModel = TRUserModel()
    private var statisticsModel : TRStatisticsModel = TRStatisticsModel()
    private var commonFunctionsModel : CommonFunctionsModel = CommonFunctionsModel()
    private var walletModel = TRWalletModel()
    //处理返回按钮
    private var navBackBtn : UIButton!
    private var isTop : Bool = true {
        didSet {
            if isTop {
                navBar?.backgroundColor = .clear
                navBackBtn.setImage(UIImage(named: "nav_back_white"), for: .normal)
            } else {
                navBar?.backgroundColor = .white
                navBackBtn.setImage(UIImage(named: "nav_back"), for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configMainView()
        
        configNavBar()
        navBar?.backgroundColor = .clear
        navBackBtn = configNavLeftBtn()
        navBackBtn.setImage(UIImage(named: "nav_back_white"), for: .normal)

        NotificationCenter.default.addObserver(self, selector: #selector(configNetData), name: .init("loadAccountInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(configNetData), name: .init("login_success"), object: nil)
        
    }
    private func configMainView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .bgColor()
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.register(TRMineInfoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(TRMineInfoTitleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "titleHeader")
        collectionView.register(TRMineInfoFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        //分割线
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer0")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header0")
        collectionView.register(TRMineCommonFuncCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(TRMineBannerCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(TRMineMoreFuncCollectionViewCell.self, forCellWithReuseIdentifier: "cell3")
//        collectionView.register(TRMineInfoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "header")

        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(0)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNetData()
    }
    @objc private func configNetData(){
        let group = DispatchGroup()
        let groupQueue = DispatchQueue(label: "me_requst")
        group.enter()
        TRNetManager.shared.get_no_lodding(url: URL_Me_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRUserManage.deserialize(from: dict) else {return}
            if model.code == Net_Code_Success {
                userModel = model.data
                userModel.dealNetData()
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
            group.leave()
        }
        
        group.enter()
        TRNetManager.shared.get_no_lodding(url: URL_Me_RiderFrequentFeature, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = CommonFunctionsManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                commonFunctionsModel = model.data
            }
            group.leave()
        }
        group.enter()
        TRNetManager.shared.get_no_lodding(url: URL_Me_Statistics, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRStatisticsManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                statisticsModel = model.data
            }
            group.leave()
        }
        group.enter()
        TRNetManager.shared.get_no_lodding(url: URL_Me_Wallet_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRWalletManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                walletModel = model.data
            }
            group.leave()
        }
        
        group.notify(queue: groupQueue) {
            DispatchQueue.main.async { [self] in
                statisticsModel.avaAmount = walletModel.avaAmount
                collectionView.reloadData()
            }
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        } else if section == 2 {//banner
            return 1
        } else if section == 3 {
            return 8
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: Screen_Width, height: 188 + Nav_Height + 25)
        } else if section == 1 {
            return CGSize(width: Screen_Width, height: 55)
        } else if section == 2 {
            return CGSize(width: Screen_Width, height: 0)
        } else if section == 3 {
            return CGSize(width: Screen_Width, height: 55)

        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        } else if section == 1 {
            return CGSize(width: Screen_Width, height: 35)
        } else if section == 2 {
            return CGSize(width: Screen_Width, height: 15)
        } else if section == 3 {
            return CGSize(width: Screen_Width, height: 35)

        }
        
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: Screen_Width, height: 84 * 2 + 20)
        } else if indexPath.section == 2 {
            return CGSize(width: Screen_Width, height: 106 + 30)
        } else if indexPath.section == 3 {
            return CGSize(width: (Screen_Width - 32) / 4, height: 58)

        }
        
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! TRMineInfoHeader
            view.orderBtn.numLab.text = statisticsModel.todayCompleteOrderNumber
        
            view.incomeBtn.numLab.attributedText = TRTool.richText(str1: "¥", font1: .trBoldFont(18), color1: .hexColor(hexValue: 0xFA651F), str2: statisticsModel.totalExpectIncome, font2: .trBoldFont(26), color2: .hexColor(hexValue: 0xFA651F))
            view.model = userModel
            //事件在里面不响应，待查
            view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer()
            view.addGestureRecognizer(tap)
            tap.rx.event.subscribe(onNext:{[weak self] _ in
                guard let self  = self  else { return }
                let vc = TRMineDetailViewController()
                vc.userModel = userModel
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: view.bag)
            view.orderBtn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self  = self else { return }
                let vc = TRWebViewController()
                vc.type = .rider_history_order
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc , animated: true)
            }).disposed(by: view.bag)
//            view.block = {[weak self] index in
//                guard let self  = self  else { return }
//                if index == 1 {
//                    let vc = TRMineDetailViewController()
//                    vc.userModel = userModel
//                    vc.hidesBottomBarWhenPushed = true
//                    self.navigationController?.pushViewController(vc, animated: true)
//                } else if index == 2 {
//                    let vc = TRWebViewController()
//                    vc.type = .rider_statics
//                    vc.hidesBottomBarWhenPushed = true
//                    self.navigationController?.pushViewController(vc , animated: true)
//                }
//            }
            return view
        } else if indexPath.section == 1 {
            if kind == UICollectionView.elementKindSectionHeader {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "titleHeader", for: indexPath) as! TRMineInfoTitleHeader
                view.titleLab.text = "常用功能"
                return view
            } else {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
                return view
            }
        } else if indexPath.section == 2 {
            if kind == UICollectionView.elementKindSectionHeader {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header0", for: indexPath)
                view.backgroundColor = .bgColor()
                return view
            } else {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer0", for: indexPath)
                view.backgroundColor = .bgColor()
                
                return view
            }
 
        } else if indexPath.section == 3 {
            if kind == UICollectionView.elementKindSectionHeader {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "titleHeader", for: indexPath) as! TRMineInfoTitleHeader
                view.titleLab.text = "更多功能"
                return view
            } else {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
                
                return view
            }
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            //     let moreFuncTitles = ["我的统计", "接单设置", "车辆管理", /*"充电桩", "邀请骑手", "骑手保险", */"服务中心", "设置"]

            var title = ""
            if indexPath.row < moreFuncTitles.count {
                title = moreFuncTitles[indexPath.row]
            }
            if title.elementsEqual("我的统计") {
//                let vc = TRStatisticViewController()
//                vc.hidesBottomBarWhenPushed = true
//                self.navigationController?.pushViewController(vc, animated: true)
                let vc = TRWebViewController()
                vc.type = .rider_statics
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc , animated: true)
            }  else if title.elementsEqual("接单设置") {
                let vc = TRPickeupSetViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else if title.elementsEqual("车辆管理") {
                
                let vc = TRWebViewController()
                vc.type = .traffic_manage
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
//                let vc = TRMineTrafficViewController()
//                vc.hidesBottomBarWhenPushed = true
//                self.navigationController?.pushViewController(vc , animated: true)
            }  else if title.elementsEqual("邀请骑手") {
                let vc = TRInviteRiderViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else if title.elementsEqual("服务中心") {
                let vc = TRServiceCenterViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else if title.elementsEqual("设置") {
                let vc = TRMineSettingViewController()
                vc.model = userModel
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else if title.elementsEqual("申请骑手") {
                let vc = TRMineApplyVC()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc , animated: true)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        } else if section == 3 {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        }
        
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TRMineCommonFuncCell
            cell.commonFunctionsModel = commonFunctionsModel
            return cell;
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
            return cell;
        } else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! TRMineMoreFuncCollectionViewCell
            if indexPath.row < moreFuncTitles.count {
                cell.btn.lab.text = moreFuncTitles[indexPath.row]
                cell.btn.imgV.image = UIImage(named: moreFuncImageTitles[indexPath.row])
            } else {
                cell.btn.imgV.image = nil
                cell.btn.lab.text = ""
            }
            return cell;
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell;    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
            if !isTop {
                self.isTop = true
            }
        } else {
            if isTop {
                self.isTop = false
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

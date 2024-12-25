//
//  TRHomeBeginVC.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/2.
//

import UIKit
import RxSwift
import RxCocoa
class TRHomeBeginVC: BasicViewController, YNPageViewControllerDataSource, YNPageViewControllerDelegate {
    func pageViewController(_ pageViewController: YNPageViewController!, pageFor index: Int) -> UIScrollView! {
        let vc = pageViewController.controllersM[index] as! TRNewsSubViewController
        return vc.tableView
    }
    
//    - (void)pageViewController:(YNPageViewController *)pageViewController
//            didAddButtonAction:(UIButton *)button;
    func pageViewController(_ pageViewController: YNPageViewController!, didAddButtonAction button: UIButton!) {
        print("xzy111")
    }
    
    func pageViewController(_ pageViewController: YNPageViewController!, contentOffsetY: CGFloat, progress: CGFloat) {
        if contentOffsetY <= -288 {
            if barType == 1 {
                beginBar.backgroundColor = .clear
                topBgImgV.isHidden = false
                beginBar.helloLab.text = "Hi！\(TRDataManage.shared.userModel.nickName)"
                beginBar.helloLab.snp.remakeConstraints { make in
                    make.left.equalTo(beginBar.headImgV.snp.right).offset(9)
                    make.top.equalTo(beginBar.headImgV)
                }
                beginBar.tipLab.isHidden = false
                barType = 0
            }
        } else {
            if barType == 0 {
                beginBar.backgroundColor = .white
                topBgImgV.isHidden = true
                beginBar.helloLab.text = "嘉马配送"
                beginBar.tipLab.isHidden = true
                beginBar.helloLab.snp.remakeConstraints { make in
                    make.centerY.equalTo(beginBar.headImgV)
                    make.centerX.equalTo(beginBar)
                }
                barType = 1
            }
        }
        }
    var beginBar : TRHomeBeginBar!
    
    var bottomBar : TRHomeBeginBottomBar!
    
    var url_Order = URL_Order_Create
    var bag = DisposeBag()
    
    //bar类型 0 显示名字 1 显示标题
    private var barType = 0
    private var header : TRHomeBeginHeader!
    private var topBgImgV : UIImageView!
    
    private var isLoadingPaymentState : Bool = false
    //保证金状态
    private var paymentStateModel : TRRiderPaymentModel?
    var pageVC : YNPageViewController!
    
    private var tempOrderNo : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        
        topBgImgV = TRFactory.imageViewWith(image: UIImage(named: "begin_top_bg"), mode: .scaleAspectFill, superView: self.view)
        
        beginBar = TRHomeBeginBar(frame: .zero)
        self.view.addSubview(beginBar)
        beginBar.block = {[weak self] (index) in
            guard let self = self else { return }
            if index == 0 {
                let vc = TRMineViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc , animated: true)
            } else if index == 1 {
                let vc = TRMessageViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc , animated: true)
            }
        }
        //支付成功 需要重新请求状态
        NotificationCenter.default.addObserver(self, selector: #selector(configPaymentState), name: .init(Notification_Name_Pay_Suceess), object: nil)
        bottomBar = TRHomeBeginBottomBar(frame: .zero)
        bottomBar.setBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self else { return }
            openSetView()
            
        }).disposed(by: bag)
        bottomBar.beginBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self  else { return }
            onLineAction()
          
        }).disposed(by: bag)
        bottomBar.backgroundColor = .white
        self.view.addSubview(bottomBar)
        
        topBgImgV.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(Screen_Width * (160.0 / 375.0))
        }
        beginBar.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(StatusBar_Height + 64)
        }
        
        bottomBar.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        configNetData()
    }
    //开工设置
     func openSetView(){
//         SVProgressHUD.s
         bottomBar.setBtn.isUserInteractionEnabled = false
        TRNetManager.shared.get_no_lodding(url: URL_Me_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRUserManage.deserialize(from: dict) else {return}
            
            if model.code == Net_Code_Success {
                let setView = TRHomeBeginSetView(frame: .zero)
                setView.vc = self
                setView.setModel = model.data
                setView.addToWindow()
                setView.openView()
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
            
            bottomBar.setBtn.isUserInteractionEnabled = true
        }
    }
    //开工
    private func normalOpenAction(){
        TKPermissionLocationAlways.auth(withAlert: true) { ret in
            if ret {
                SVProgressHUD.show()
                TRNetManager.shared.put_no_lodding(url: URL_Home_State_Changed, pars: ["workStatus" : "ONLINE"]) { dict in
                    guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
                    if codeModel.code == Net_Code_Success {
                        let homeVC = TRHomeViewController()
                        let navVC = BasicNavViewController(rootViewController: homeVC)
                        UIApplication.shared.keyWindow?.rootViewController = navVC
                    } else {
                        SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
                    }
                }
            } 
           
        }
        

    }
    //保证金
    private func depositPaymentAction(){
        let paymentView = TRRiderDepositPaymentPopView(frame: .zero)
        paymentView.model = paymentStateModel

        paymentView.contentHeight = IS_IphoneX ? 388 + 35 : 388
        paymentView.titleLab.text = "接单保证金"
        paymentView.addToView(v: self.view)
        paymentView.openView()
        paymentView.block = {[weak self] in
            guard let self = self else { return }
            creatOrder(popView : paymentView)
        }
        paymentView.agreementBlock = {[weak self] in
            guard let self = self  else { return }
            let webVC = TRWebViewController()
            webVC.type = .txt_margin
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    //授信金额
    private func creitPaymentAction(){
        let creditpaymentView = TRRiderCreditPaymentView(frame: .zero)
        creditpaymentView.model = paymentStateModel
        creditpaymentView.contentHeight = IS_IphoneX ? 388 + 35 : 388
        creditpaymentView.titleLab.text = "接单授信余额不足提醒"
        creditpaymentView.addToWindow()
        creditpaymentView.openView()
        
        creditpaymentView.block = {[weak self] in
            guard let self = self  else { return }
            creatOrder(popView : creditpaymentView)
        }
    }
    
    private func creatOrder(popView : TRBottomPopBasicView){
        // 可用值:DEPOSIT,CREDIT
        var type = ""
        if paymentStateModel!.status == 1 {
            // 保证金
            url_Order = URL_Order_Create
        } else if paymentStateModel!.status == 2 {
            // 授信金
            type = "CREDIT"
        }
        let pars = [
                "rechargeAmount": paymentStateModel!.payAmount,
                "rechargeType": type
        ] as [String : Any]
        
        TRNetManager.shared.post_no_lodding(url: url_Order, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRRiderOrderPaymentManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                popView.closeView()
                let vc = TROrderPayViewController()
                tempOrderNo = model.data.orderNo
                let so = TRSimpleOrderInfo()
                so.payTotalAmount = paymentStateModel!.payAmount
                so.orderNo = model.data.orderNo
                vc.simpleOrder = so
                self.navigationController?.pushViewController(vc , animated: true)
                
            } else if model.exceptionCode == 0 {
                popView.closeView()
                let vc = TROrderPayViewController()
                let so = TRSimpleOrderInfo()
                so.payTotalAmount = paymentStateModel!.payAmount
                so.orderNo = tempOrderNo
                vc.simpleOrder = so
                self.navigationController?.pushViewController(vc , animated: true)
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
   
    func onLineAction(){
        if isLoadingPaymentState {
            SVProgressHUD.showInfo(withStatus: "正在加载，请等待")
            return
        }
        if paymentStateModel == nil {
            SVProgressHUD.showInfo(withStatus: "正在加载，请等待")
            configPaymentState()
            return
        }
        
        if paymentStateModel!.status == 0 {
            //正常开工
            normalOpenAction()
        } else if paymentStateModel!.status == 1 {
            //交授信金
            depositPaymentAction()
        } else if paymentStateModel!.status == 2 {
            //交保证金
            creitPaymentAction()
        } else {
            SVProgressHUD.showInfo(withStatus: "未知状态，请重新登录")
        }

        
    }
    private func configNetData(){
        TRNetManager.shared.get_no_lodding(url: URL_Home_Statistics, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRRiderStaticsManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                header.riderSatitView.staticsModel = model.data
            }

        }
        
        configPaymentState()
    }
    
    @objc private func configPaymentState(){
        // 0=正常开工,1=需要缴纳保证金,2=需要缴纳授信金额
        if isLoadingPaymentState {
            return
        }
        isLoadingPaymentState = true
        SVProgressHUD.show()
        
        TRNetManager.shared.get_no_lodding(url: URL_Home_GetRiderStatus, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let manage = TRRiderPaymentManage.deserialize(from: dict) else {
                isLoadingPaymentState = false
                return
            }
            if manage.code == 1 {
                paymentStateModel = manage.data
            } else {
                SVProgressHUD.showInfo(withStatus: manage.exceptionMsg)
            }
            isLoadingPaymentState = false
        }
    }
    
    func setConfig(){
        /*
         
         */
        let config = YNPageConfigration()
        config.pageStyle = .suspensionTop
        config.headerViewScaleMode = .top
        
        config.showNavigation = false
        //        config.pageScrollEnabled = false
        config.showTabbar = true
        config.aligmentModeCenter = false
        config.lineWidthEqualFontWidth = false
        config.aligmentModeCenter = true
        //        config.normalItemColor =
        config.showBottomLine = false
        config.showScrollLine = false
        config.lineColor = UIColor.lightThemeColor()
        config.lineHeight = 4
        config.lineCorner = 2
        config.lineBottomMargin = 12
        config.lineLeftAndRightMargin = 20
        config.showScrollImageLine = false
        config.lineImageHeight = 6
        //        config.suspenOffsetY = Nav_Height
        config.scrollViewBackgroundColor = .bgColor()
        config.limitScroll = true
        config.menuHeight = 48
        config.scrollViewBackgroundColor = .white
        // 9B9C9C
        config.normalItemColor = UIColor.hexColor(hexValue: 0x97989A)
        config.selectedItemColor = .txtColor()
        config.itemFont = UIFont.trFont(fontSize: 16)
        config.selectedItemFont = UIFont.trBoldFont(16)
//        config.lineImageName = "menu_bottom_img"
//        config.showScrollImageLine = true

        config.aligmentModeCenter = false
        config.addButtonHightImageName = "store_more"
        config.addButtonNormalImageName = "store_more"
        
        config.showAddButton = true
        config.addButtonBackgroundColor = .bgColor()
        
        let titles :[String] = ["全部动态","通知公告","平台功能"]
        
        var vcArr = Array<BasicViewController>()
        for _ in 0...titles.count - 1 {
            let vc = TRNewsSubViewController()
            vcArr.append(vc)
        }
        let h = 240.0
        header = TRHomeBeginHeader(frame: .init(x: 0, y: 0, width: Screen_Width, height: h))
        header!.backgroundColor = .clear
        pageVC = YNPageViewController(controllers: vcArr, titles: titles, config: config)
        pageVC.headerView = header
        pageVC.dataSource = self
        pageVC.delegate = self
        
        
        //
        self.addChild(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
        pageVC.view.frame = CGRect(x: 0, y: StatusBar_Height + 64, width: Screen_Width, height: Screen_Height - Nav_Height)
        
        //        configNetData()
        
        //        refresh = AndroidRefresh(panView: self.view)!
        //        refresh!.setMarginTop(Nav_Height)
        //        refresh!.addTarget(self, action: #selector(configNetData), for: .valueChanged)
        //        refresh!.colors = [UIColor.lightThemeColor()]
        //        self.view.addSubview(refresh!)
        
        
    }
}

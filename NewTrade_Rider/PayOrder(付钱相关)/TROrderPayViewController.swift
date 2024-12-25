//
//  TROrderPayViewController.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/10/9.
//

import UIKit
enum OrderPayType : String{
    case ALI_PAY = "ALI_PAY"
    case WX_PAY = "WX_PAY"
    case WALLET_PAY = "WALLET_PAY"
}
class TROrderPayViewController: BasicViewController {
    
    private var priceLab : UILabel!
    private var timeLab : UILabel!
    var simpleOrder : TRSimpleOrderInfo?
    private var payType : OrderPayType = .WX_PAY
    
    private var payTransactionNo : String = ""
    private var isPaySuccess : Bool = false
    deinit {
    
        TRGCDTimer.share.destoryTimer(withName: "orderTime")
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configNav()
        
        configMainView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(paySuccess), name: .init(Notification_Name_Pay_Suceess), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(queryOrderInfo), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        if simpleOrder!.SimpleOrderType == .mall {
            mallOrderTimeAction()
        } else if simpleOrder!.SimpleOrderType == .tips {
            tipsOrderTimeAction()
        }
        
 
        
    }
    private func tipsOrderTimeAction(){

        var leftTime = 60

        TRGCDTimer.share.createTimer(withName: "TROrderPayViewController", timeInterval: 1, queue: .main, repeats: true) {[self] in
            leftTime -= 1
            if leftTime <= 0 {
                timeLab.text = "订单已超时"
                TRGCDTimer.share.destoryTimer(withName: "TROrderPayViewController")
            } else {
                let time = String.init(format: "支付剩余：%02zd分 %02zd秒", (leftTime/60)%60, leftTime%60)

                timeLab.text = time
            }
        }
    }
    
    private func mallOrderTimeAction(){
        let so = simpleOrder!.payTimeOut
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = df.date(from: so)
        var leftTime = 120
        if date != nil {
            let time = TRTool.dateToLongTime(date: date!) / 1000
            let now = TRTool.currentLongTime() / 1000
            leftTime = Int((time - now))
        }
        TRGCDTimer.share.createTimer(withName: "TROrderPayViewController", timeInterval: 1, queue: .main, repeats: true) {[self] in
            leftTime -= 1
            if leftTime <= 0 {
                timeLab.text = "订单已超时"
                TRGCDTimer.share.destoryTimer(withName: "TROrderPayViewController")
            } else {
                let time = String.init(format: "支付剩余：%02zd分 %02zd秒", (leftTime/60)%60, leftTime%60)

                timeLab.text = time
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //销毁此计时器
        TRGCDTimer.share.destoryTimer(withName: "TROrderPayViewController")

    }
    @objc func paySuccess(){
        self.navigationController?.popViewController(animated: true)
//        if simpleOrder!.SimpleOrderType == .mall {
//            let rootVC = self.navigationController?.viewControllers[0]
//            self.navigationController?.popViewController(animated: false)
//            let vc = TRPaySucessViewController()
//            simpleOrder!.payType = payType
//            vc.simpleOrder = simpleOrder!
//            rootVC?.navigationController?.pushViewController(vc , animated: true)
//        } else if simpleOrder!.SimpleOrderType == .tips {
//            let vcs = self.navigationController?.viewControllers
//            if vcs != nil && vcs!.count > 3 {
//                self.navigationController?.popToViewController(vcs![vcs!.count - 3], animated: true)
//            }
//        }
    }
    @objc func queryOrderInfo(){
        if isPaySuccess {
            return
        }
        if payTransactionNo.isEmpty {
            return
        }
        let pm = payType == .ALI_PAY ? "ALI_PAY" : "WX_PAY"

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {[weak self] in
            guard let self = self else {return}
            TRNetManager.shared.post_no_lodding(url: URL_MALL_Order_Pay_Result, pars: ["payTransactionNo" : payTransactionNo, "payChannel" : "APP", "payMethod" : pm]) {[weak self] dict in
                guard let self = self else {return}
                guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
                if codeModel.code == 1 && codeModel.data as? Bool ?? false {
                    isPaySuccess = true
                   paySuccess()
                } else {
                    queryOrderInfo()
                }
            }
        }
        
        
        
    }
    @objc func payAction(){
       
            payMallOrderAction()
        
    }
    
 
    
    
    private func payMallOrderAction(){
        guard let simpleOrder = simpleOrder else {
            SVProgressHUD.showInfo(withStatus: "未获取订单信息")
            return }
        var proPars : [String : Any] = [:]
        proPars["orderNo"] = simpleOrder.orderNo
        proPars["payChannel"] = "APP"
        proPars["payMethod"] = payType.rawValue
        // redPacketIds   couponIds
        SVProgressHUD.show()
        TRNetManager.shared.post_no_lodding(url: URL_Order_Pay, pars: proPars) {[weak self] dict in
            guard let self = self else { return }
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1{
                let tempDic = model.data as? [String : Any]
                if tempDic != nil {
                    payTransactionNo = tempDic!["payTransactionNo"] as? String ?? ""
                }
                if payType == .ALI_PAY {
                    aliPay(pars: dict!)
                } else if payType == .WX_PAY {
                    wxPay(pars: dict!)
                }
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }

    }
    private func wxPay(pars : [String : Any]) {
        if !WXApi.isWXAppInstalled() {
            SVProgressHUD.showInfo(withStatus: "请安装微信客户端")
            return
        }
        
        let oriData = pars["data"] as! [String : Any]
        var appPayVo : [String : Any] = [:]
        appPayVo = oriData["appPayVo"] as! [String : Any]
        var frontendParam = appPayVo["frontendParam"] as! [String : Any]
        frontendParam["client"] = "IOS"
        frontendParam["money"] = self.simpleOrder!.payTotalAmount
 
        let data : NSData! = try? JSONSerialization.data(withJSONObject: frontendParam, options: []) as NSData?
        
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
//        let jstr =
        if JSONString != nil {
            TRTool.openPayMiniPro(pars: JSONString! as String)
        } else {
            SVProgressHUD.showInfo(withStatus: "支付信息异常，请重新下单")
        }
    }
    
    
    private func aliPay(pars : [String : Any]){
        let oriData = pars["data"] as! [String : Any]
        var appPayVo : [String : Any] = [:]

        appPayVo = oriData["appPayVo"] as! [String : Any]
        
        var frontendParam = appPayVo["frontendParam"] as! [String : Any]
        frontendParam["appScheme"] = "fanmiao.gamma.rider"
        let jsonStr = try! JSONSerialization.data(withJSONObject: frontendParam, options: .prettyPrinted)
        let data = String.init(data: jsonStr, encoding: .utf8)
        
        UMSPPPayUnifyPayPlugin.pay(withPayChannel: CHANNEL_ALIMINIPAY, payData: data) { code, error in

            guard let code = code else {return}
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
            } else if code.elementsEqual("2001") {
//                SVProgressHUD.showSuccess(withStatus: "支付成功")
            }
            
        }
        

    }
  
    private func configMainView(){
        var price = simpleOrder?.payTotalAmount
        if TRTool.isNullOrEmplty(s: price) {
            price = "0"
        }
        priceLab = UILabel()
        priceLab.text = "9.2"
        priceLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        priceLab.font = UIFont.trBoldFont(fontSize: 32)
        priceLab.attributedText = TRTool.richText(str1: "￥", font1: UIFont.trFont(fontSize: 16), color1: UIColor.hexColor(hexValue: 0x333333), str2: "\(price!)", font2: UIFont.trBoldFont(fontSize: 32), color2: UIColor.hexColor(hexValue: 0x333333))
        self.view.addSubview(priceLab)
        
        timeLab = UILabel()
        timeLab.text = "支付剩余时间 29:59"
        timeLab.textColor = UIColor.hexColor(hexValue: 0x67686A)
        timeLab.font = UIFont.trFont(fontSize: 13)
        self.view.addSubview(timeLab)
        
        let typeLab = UILabel()
        typeLab.text = "支付方式"
        typeLab.textColor = UIColor.hexColor(hexValue: 0x9B9C9C)
        typeLab.font = UIFont.trFont(fontSize: 12)
        self.view.addSubview(typeLab)
        
        let payView = TROrderPayMethodView(frame: .zero)
        payView.layer.cornerRadius = 10
        payView.layer.masksToBounds = true
        payView.backgroundColor = .white
        self.view.addSubview(payView)
        
        let layerView = UIView()
        layerView.layer.cornerRadius = 24
        layerView.layer.masksToBounds = true
        layerView.frame = CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 48)
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.49, blue: 0.35, alpha: 1).cgColor, UIColor(red: 0.99, green: 0.2, blue: 0.2, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = layerView.bounds
        bgLayer1.startPoint = CGPoint(x: 0, y: 0)
        bgLayer1.endPoint = CGPoint(x: 0.91, y: 0.91)
        layerView.layer.addSublayer(bgLayer1)
        self.view.addSubview(layerView)
        
        let btn = UIButton()
        btn.setTitle("立即支付", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.trBoldFont(fontSize: 18)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(payAction), for: .touchUpInside)
        priceLab.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height + 20)
        }
        timeLab.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(priceLab.snp.bottom).offset(3)
        }
        
        typeLab.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(16)
            make.top.equalTo(timeLab.snp.bottom).offset(41)
        }
        
        payView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(16)
            make.top.equalTo(typeLab.snp.bottom).offset(10)
            make.height.equalTo(168 / 3 * 2)
        }
        
        layerView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(16)
            make.top.equalTo(payView.snp.bottom).offset(30)
            make.height.equalTo(48)
        }
        btn.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(layerView)
        }
//        var count = 60 * 30
//        TRGCDTimer.share.createTimer(withName: "zf", timeInterval: 1, queue: .main, repeats: true) {[weak self] in
//            if self == nil {
//                TRGCDTimer.share.destoryTimer(withName: "zf")
//                return
//            }
//            
//            count -= 1
//            if count <= 0 {
//                TRGCDTimer.share.destoryTimer(withName: "zf")
//                return
//            }
//            let m = count / 60
//            let s = count % 60
//           
//            self?.timeLab.text =  String.init(format: "支付剩余时间 %02d：%02d", m , s)
//
//        }
        
        
        payView.block = {[weak self](index) in
            guard let self = self else {return}
            if index == 1 {
                payType = .WX_PAY
            } else if index == 2 {
                payType = .ALI_PAY
            } else if index == 3 {
                payType = .WALLET_PAY
            }
        }
        
    }
    private func configNav(){
        configNavBar()
        navBar?.contentView.backgroundColor = .clear
        configNavTitle(title: "订单支付")
        configNavLeftBtn()

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

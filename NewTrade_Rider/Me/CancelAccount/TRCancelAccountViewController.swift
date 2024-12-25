//
//  TRCancelAccountViewController.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/4/26.
//

import UIKit
let appName = "嘉马骑手"

class TRCancelAccountViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    var bottomView : TRBottomButton1View!
    var isAgree = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "注销账号")
        self.view.backgroundColor = .white
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TRCancelAcountTitleCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRCancelAcountTipCell.self, forCellReuseIdentifier: "cell2")

        self.view.addSubview(tableView)
        
        let agreementView = TRAgreementActionView(frame: .zero)
        agreementView.agreeBtn.addTarget(self, action: #selector(agreeAction), for: .touchUpInside)
        agreementView.backgroundColor = .white
        self.view.addSubview(agreementView)
        
        bottomView = TRBottomButton1View(frame: .zero)
        bottomView.backgroundColor = .white
        bottomView.saveBtn.setTitle("已清楚风险，确认注销", for: .normal)
        bottomView.saveBtn.addTarget(self, action: #selector(cancelAccount), for: .touchUpInside)
        self.view.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        agreementView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(bottomView.snp.top).offset(-5)
            make.height.equalTo(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(Nav_Height)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(agreementView.snp.top).offset(-10)
        }
        
    }
    @objc func agreeAction(btn : UIButton){
        isAgree = !isAgree
        if isAgree {
            btn.setImage(UIImage(named: "address_default"), for: .normal)
        } else {
            btn.setImage(UIImage(named: "loaction_nor"), for: .normal)
        }
    }
    @objc func cancelAccount(){
        if isAgree == false {
            SVProgressHUD.showInfo(withStatus: "请先阅读并同意《注销账号重要提醒》")
            return
        }
        
        let alertView = TRAlertView(frame: .zero)
        alertView.type = .normal
        alertView.titleLab.text = "是否确认注销账号？"
        alertView.tipLab.textColor = .hexColor(hexValue: 0xF55555)
        alertView.tipLab.text = "注销后账号内的资产权益等将不可恢复\n30后将完成注销\n期间如果登录，则取消注销账户"
        alertView.sureBtn.setTitle("确认", for: .normal)
        alertView.cancelBtn.setTitle("取消", for: .normal)
        alertView.addToWindow()
        alertView.block = {[weak self](index) in
            guard let self = self else { return }
            TRTool.saveData(value: "", key: Save_Key_Token)
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let loginController = TRLoginViewController()
            let navController = BasicNavViewController(rootViewController: loginController)
            delegate.window?.rootViewController = navController;
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRCancelAcountTitleCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRCancelAcountTipCell
            cell.titleLab.text = titles[indexPath.row]
            cell.tipLab.text = tips[indexPath.row]
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRCancelAcountTipCell
        
        return cell
    }
    
    
    let titles = ["注销账号有以下风险：","账户需满足以下条件才可注销：","\(appName)账户注销重要提醒"]
    let tips = [
        "1.永久注销，无法登录\n账号一旦注销，支持\(appName)账户登录的多项产品/服务将无法登录井使用。\n2.所有账号数据将无法找回\n特别地，账号所产生的交易数据将被清空，请确保所有交易已完结且无纠纷，账号注销后因历史交易可能产生的资金退回等权益，将视作自动放弃。\n3.所有账号权益将永久清空\n您的身份信息、账户信息、平台积分、账期权益等平台会员权益将被清空且无法找回",
        "1.账户近期不存在交易：\n您的账户无未完成订单、无已完成但未满售后期（一般为15天）的订单。\n2.账户不存在占用的账期余额：\n您的账户不存在未还款的账期。\n2.账户不存在进行中的违规记录：\n您的账户不存在正在进行中的违规处罚或限权记录。\n3.账户相关财产权益已结清：\n您的账户不存在冻结中保证金、平台账户余额等。\n4.账户下不存在尚未注销的店铺：\n基于相关法律法规要求及店铺经营相关交易安全需要，您须先行完成店铺注销。\n5.账户不存在未完结的服务：\n您的账户不存在\(appName)平台所提供的尚未完结的服务，包括采销服务、仓储物流服务、金融服务、生活订购服务等。\n6.企业管理员已完成权限转移：\n您的账户若为企业管理员的，须完成管理员身份权限转移，该账户使用企业账期支付的交易数据全部留存，企业子账户能够正常登录使用。\n7.其他APP、网站相关的账户解绑：\n该\(appName)平台账户已解除与其他APP、网站的登录、使用或绑定等关系。",
        "在您确认注销您的\(appName)平台账户之前，请您充分阅读、理解并同意下列事项：（如您不同意下列任一内容，或无法准确理解任何条款的含义，请不要进行账户注销操作。您通过网络页面确认申请注销，视为您同意接受本提醒所有内容）\n1.您所申请注销的\(appName)平台账户应当是您依照与\(appName)平台的约定注册并由\(appName)平台提供给您本人的账户。您自注册该账户时起，使用该账户进行的行为符合国家法律法规、《\(appName)服务协议》和\(appName)平台公开发布的相关规则。\n2.您应确保您有权决定该账户的注销事宜，不侵犯任何第三方的合法权益，如因此引发任何投诉争议，由您自行承担并使\(appName)平台免责。\n3.在您申请注销\(appName)平台账户前，您应当确保该账户处于正常状态，且在注销申请提起时该账户下无未完结的交易，无进行中的投诉纠纷或处罚，亦无任何拖欠的款项，如账期支付待还款项、\(appName)代垫款项及其他因交易产生的欠款等，并符合其他\(appName)平台账户注销条件。\n4.您充分知晓\(appName)平台账户注销将导致\(appName)平台终止为您提供本服务，《\(appName)平台服务协议》约定的双方权利义务终止（依本通知其他条款另行约定不得终止的或依其性质不能终止的除外），同时还可能对于该账户产生包括但不限于如下结果：\n您将无法再次使用该账户登录\(appName)平台以及其他使用该账户登录的网站及客户端，包括但不限于\(appName)客户端、\(appName)小程序、以及\(appName)相关合作网站等进行任何操作；\n您的账户名称将被释放，供其他用户进行注册；\n您的账户内所有历史记录信息将被清除并无法再次找回；\n您的账户内所获得的任何优惠信息（平台积分、\(appName)店铺优惠券、商品优惠券、账期支付额度等）都将作废。\n5.您应当按照\(appName)平台公示的流程进行\(appName)平台账户注销，且您承诺该账户注销申请一经提交，您不会以任何理由要求\(appName)平台予以撤销。\n6.特别地，如果您的\(appName)平台账户在连续6个月内没有任何操作行为，且满足其他\(appName)平台账户注销条件时，\(appName)平台有权依照适用的法律和《\(appName)平台服务协议》主动进行注销。\n7.您申请注销的\(appName)平台账户所对应的支付账户应当不存在任何由于该账户被注销而导致的未了结的合同关系与其他基于该账户的存在而产生或维持的权利义务，及本公司认为注销该账户会由此产生未了结的权利义务而产生纠纷的情况。\n8.本通知未尽事宜，\(appName)平台依照与您约定的《\(appName)平台服务协议》执行。"
    ]
    

}

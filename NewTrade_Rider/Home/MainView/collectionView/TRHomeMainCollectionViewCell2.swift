//
//  TRHomeMainCollectionViewCell2.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: 待取货页面
class TRHomeMainCollectionViewCell2: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var page : Int = 1
    var data : [TROrderModel] = []
    
    private var ev : LYEmptyView!
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        configData()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .init(Notification_Name_Order_Accept), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .init(Notification_Name_Order_Pickup), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .init(Notification_Name_Patch_Order), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .init(Notification_Name_Order_Cancel), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .init(Notification_Name_Location_Update), object: nil)
    }
    
    private func setupView(){
        ev = LYEmptyView.empty(with: UIImage(named: "no_data_order"), titleStr: "暂无订单", detailStr: "")
        ev.contentViewY = self.contentView.ly_centerY / 2 - StatusBar_Height
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRHomePickupTableViewCell.self, forCellReuseIdentifier: "cell1")
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self.contentView)
        }
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            guard let self = self else { return }
            NotificationCenter.default.post(name: .init(Notification_Home_refresh), object: nil)
            refreshData()
        })
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {[weak self] in
            guard let self = self else { return }
            page += 1
            configData()
        })
        
    }
    @objc func refreshData(){
        page = 1
       
        configData()
    }
    private func configData(){

        let subPars : [String:String] = [:]
        let pars = [
            "param" : subPars,
            "current" : page,
            "size" : PAGE_SIZE
        ] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Order_Taking, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TROrderManage.deserialize(from: dict) else {
                tableView.mj_header?.endRefreshing()
                tableView.mj_footer?.endRefreshing()
                return}
            if model.code == 1 {
                if page == 1 {
                    data.removeAll()
                }
                data.append(contentsOf: model.data.records)
                tableView.reloadData()

            }
            tableView.mj_header?.endRefreshing()
            tableView.mj_footer?.endRefreshing()
            if tableView.ly_emptyView == nil {
                tableView.ly_emptyView = ev
            }
        }
    }
    private func getPrivacyPhone(model : TROrderModel){
        SVProgressHUD.show()
        TRNetManager.shared.get_no_lodding(url: URL_Order_Privacy_Phone, pars: ["orderNo":model.orderNo]) {[weak self] dict in
            guard let self = self else {return}
            guard let manage = TRPrivacyConcactManage.deserialize(from: dict) else {return}
            if manage.code == Net_Code_Success {
                self.contactPhone(model: model, contactModel: manage.data)
//                TRTool.callPhone(manage.data.phoneNo)
            } else {
                SVProgressHUD.showInfo(withStatus: manage.exceptionMsg)
            }
        }
    }
    //联系弹窗
    private func contactPhone(model : TROrderModel,contactModel : TRPrivacyConcactModel) {
        let contactView = TRContactBottomView(frame: .zero)
        //发短信的高度 74
        contactView.contentHeight = 358 + 10 - (IS_IphoneX ? 0 : 35)
        contactView.addToWindow()
        contactView.openView()
        contactView.type = 2
        //        contactView.order = model
        contactView.order = model
        contactView.contactModel = contactModel
        var uid = model.scStoreUserId
        if  contactView.type  == 2 {
            uid = model.scStoreUserId
        } else {    
            uid = model.scMemberUserId
        }
        contactView.block = {[weak self](index) in
            guard let self  = self  else { return }
            if index == 1 {
                contactView.closeView()
                TRTool.callPhone(contactModel.phoneNo)
//                if type == 2 {
//                    TRTool.callPhone(model.senderPhone)
//                } else {
//                    TRTool.callPhone(model.receiverPhone)
//                }
            } else if index == 2 {
                contactView.closeView()
                TRTool.callPhone(contactModel.phoneNo)

//                if type == 2 {
//                    TRTool.sendMsg(phone: model.senderPhone)
//                } else {
//                    TRTool.sendMsg(phone: model.receiverPhone)
//                }
            } else {
                
                
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
                            self.iq.viewContainingController()?.navigationController?.pushViewController(chatVC , animated: true)
                        }
                    }
                }
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRHomePickupTableViewCell
        let model = data[indexPath.row]
        cell.model = model
        cell.contactBtn.rx.tap.subscribe (onNext: {[weak self] in
            guard let self else {return}
            getPrivacyPhone(model: model)
        }).disposed(by: cell.bag)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TRTaskDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        let model = data[indexPath.row]
        vc.model = model
        vc.type = 2
        self.viewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

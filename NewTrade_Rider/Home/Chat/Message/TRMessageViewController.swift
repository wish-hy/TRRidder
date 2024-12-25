//
//  TRMessageViewController.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/14.
//

import UIKit

import RxCocoa
import RxSwift
class TRMessageViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate, ChatClientDelegate {

    var messageBar : TRMessgeNavBar!
    
    var tableView : UITableView!
    
    let bag = DisposeBag()
    var sessionList : [ChatSessionModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        customNav()
        customMainView()
        ChatClient.sharedInstance.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(receiveMsg), name: .init(Notification_Name_Receive_Message), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disConnectAction), name: .init(Notification_Name_Net_DisConnect), object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshSessionList()
    }

    private func customMainView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 51
        tableView.register(TRMessageTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
//            make.top.equalTo(messageBar.snp.bottom).inset(25)
            make.top.equalTo(messageBar.snp.bottom).inset(66)
        }
    }
    
    
    private func customNav(){
        messageBar = TRMessgeNavBar(frame: .zero)
        self.view.addSubview(messageBar)
        messageBar.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(Nav_Height + 66)
        }
        messageBar.setBtn.rx.tap.subscribe(onNext: {[weak self ] in
            //
            guard let self  = self  else { return  }
            ChatClient.sharedInstance.clearSessionRecord()
            refreshSessionList()
            SVProgressHUD.showSuccess(withStatus: "已清除")
            //聊天设置
//            let vc = TRChatSetViewController()
//            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        messageBar.clearBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self  else { return }
            ChatClient.sharedInstance.clearSessionRecord()
            refreshSessionList()
        }).disposed(by: bag)
        messageBar.backBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self  else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
    }
    //收到一条消息,目前只会接受别人的消息
    @objc func receiveMsg(noti : Notification){
        //updateList
        let cc = ChatClient.sharedInstance
        let mm = noti.object as! ChatMsgModel
        //更新信息 更新会话
        let session = cc.getSession(sessionID: mm.sessionID)
        if session == nil{
            //创建一个会话
            createNewSession(mm: mm)
        } else {
            //更新会话
            cc.insertMessageList(sessionID: mm.sessionID, data: [mm])
            session!.scUserId = TRDataManage.shared.userModel.scUserId
            session!.lastMessage = mm.msgContent
            session!.lastMessageType = mm.type
            session!.lastMessageTime = mm.sendTime
            session!.unread = session!.unread + 1
            cc.updateSessionMsg(newSession: session!)
            
            //此处要通知 消息页面更新 当会话不存在是 不会有消息页
            NotificationCenter.default.post(name: .init(Notification_Name_Update_Message), object: nil)

        }
        
        //刷新列表
        refreshSessionList()
        DispatchQueue.main.async {
            if self.navigationController?.tabBarController?.selectedIndex != 2 {
                ChatUtil.shared.playMessageComeVoice()
            }
        }

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
                session!.scUserId = TRDataManage.shared.userModel.scUserId
                session!.lastMessageTime = mm.sendTime
                cc.insertMessageList(sessionID: mm.sessionID, data: [mm])
                cc.updateSessionMsg(newSession: session!)
                //刷新列表
                refreshSessionList()
                NotificationCenter.default.post(name: .init(Notification_Name_Update_Message), object: nil)
            }
        }
    }
    
   
    //刷新会话列表
    private func refreshSessionList(){
        let cc = ChatClient.sharedInstance.getSessionList()
        let filteredSessionList = cc.filter { $0.scUserId == TRDataManage.shared.userModel.scUserId }
        sessionList = filteredSessionList
        if !Thread.current.isMainThread {
            DispatchQueue.main.sync {
                tableView.reloadData()
            }
        } else {
            tableView.reloadData()

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
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = TRMessageNotifyViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = TRChatViewController()
            vc.sessionModel = sessionList[indexPath.row]
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : sessionList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRMessageTableViewCell
            if indexPath.section == 0 {
                cell.userImgV.image = UIImage(named: "msg_notification")
                cell.nameLab.text = "系统通知"
                cell.desLab.text = "暂无消息"
                cell.unreadView.isHidden = true
                cell.redDotView.isHidden = true
                cell.unreadCountLabel.isHidden = true
            } else {
                cell.sessionModel = sessionList[indexPath.row]
            }
        return cell
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
    @objc func disConnectAction(){
        messageBar.titleLab.text = "消息中心(网络未连接)"
    }
    
    func stateDidChange(_ state: ChatClientState) {
        DispatchQueue.main.async {[self] in
            switch state {
            case .connected:
                messageBar.titleLab.text = "消息中心(正在连接....)"
            case .disConnect:
                messageBar.titleLab.text = "消息中心(连接已断开)"
            case .connecting:
                messageBar.titleLab.text = "消息中心(正在连接....)"

            case .login:
                messageBar.titleLab.text = "消息中心"
            case .logout:
                messageBar.titleLab.text = "消息中心(已退出)"

            case .faield:
                messageBar.titleLab.text = "消息中心(连接失败失败)"
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

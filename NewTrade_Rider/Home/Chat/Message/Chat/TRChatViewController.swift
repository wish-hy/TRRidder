//
//  TRChatViewController.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/26.
//

import UIKit
import IQKeyboardManagerSwift
import ZLPhotoBrowser

class TRChatViewController: BasicViewController, UITableViewDataSource & UITableViewDelegate& UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var sessionModel : ChatSessionModel!
    var tableView : UITableView!
    
    var sendView : TRChatSendView!
    var msgList : [ChatMsgModel] = []
    
    var chatUserInfo : [ChatUserModel] = []
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ : )), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ : )), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared.isEnabled = true
        NotificationCenter.default.removeObserver(self)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateUnread()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    @objc private func keyboardWillShow(_ notification:NSNotification){
        
        let keyBoardShowTime = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! CGFloat
        // 键盘坐标
        
        let keyBoardFrame = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        let h = keyBoardFrame.size.height
        let y = Screen_Height - h  - 66
        
        UIView.animate(withDuration: TimeInterval(keyBoardShowTime), animations: {
            
//            self.sendView.frame = CGRect(x: 0, y: y, width: Screen_Width, height: 66)
            self.sendView.snp.remakeConstraints { make in
                make.left.right.equalTo(self.view)
    //            make.height.equalTo(66)
                make.bottom.equalTo(self.view).offset(-h + (IS_IphoneX ? 35 : 0))
            }
        })
    
    }
    @objc private func keyboardWillHide(_ notification:NSNotification){
        
        let keyBoardShowTime = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! CGFloat
        // 键盘坐标
        
        let keyBoardFrame = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        let h = keyBoardFrame.size.height
        let y = Screen_Height + (IS_IphoneX ? -25 : 0) - 66
        
        UIView.animate(withDuration: TimeInterval(keyBoardShowTime), animations: {[self]
            
//            self.sendView.frame = CGRect(x: 0, y: y, width: Screen_Width, height: 66)
            self.sendView.snp.remakeConstraints { make in
                make.left.right.equalTo(self.view)
    //            make.height.equalTo(66)
                make.bottom.equalTo(self.view).offset(0)
            }
        })
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        customNav()
        
        customBottomView()
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRChatTextCell.self, forCellReuseIdentifier: "txt")
        tableView.register(TRChatTimeCell.self, forCellReuseIdentifier: "time")
        tableView.register(TRChatImgCell.self, forCellReuseIdentifier: "img")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
//            make.bottom.equalTo(self.view).inset(IS_IphoneX ? 68 + 25 : 68)
            make.bottom.equalTo(sendView.snp.top).inset(15)
        }
        self.view.bringSubviewToFront(sendView)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveMsg), name: .init(Notification_Name_Update_Message), object: nil)

        //获取聊天列表
        //处理私聊，用户信息
        queryUserInfo()
        
    }
    private func queryUserInfo(){
        if sessionModel.receiveType.elementsEqual("PRIVATE") {
            ChatUtil.shared.updateUserInfo(id: sessionModel.receiveId) {[weak self] m in
                guard let self  = self  else { return }
                chatUserInfo = [m]
                updateMsgList(false)

            }
        } else {
            //处理 群成员信息
        
        }
    }
    private func updateUnread(){
        sessionModel.unread = 0
        ChatClient.sharedInstance.updateSessionMsg(newSession: sessionModel)
    }
    private func customNav(){
        configNavBar()
        self.navBar?.contentView.backgroundColor = UIColor.white
        configNavTitle(title: sessionModel.receiveName)
        configNavLeftBtn()
//        navBar!.titleLab!.snp.remakeConstraints({ make in
//            make.left.equalTo(navBar!.leftView!.snp.right).offset(0)
//            make.centerY.equalTo(navBar!.leftView!)
//        })
//        sendView.snp.makeConstraints { make in
//            make.left.right.equalTo(self.view)
////            make.height.equalTo(66)
//            make.bottom.equalTo(self.view).offset(IS_IphoneX ? -25 : 0)
//        }
        
    }
    //打开相机
    private func takePhote(){
        TKPermissionCamera.auth(withAlert: true) { ret in
            if ret {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let vc = UIImagePickerController()
                    vc.delegate = self
                    vc.allowsEditing = true
                    vc.sourceType = .camera
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc , animated: true)
                } else {
                    SVProgressHUD.showInfo(withStatus: "不支持相机")
                }
            }
        }

       
        
        
    }
    //打开相册发送图片
    private func uploadPic(){
        TKPermissionPhoto.auth(withAlert: true , level: .readWrite) { ret in
            if ret {
                let config = ZLPhotoConfiguration.default()
                config.allowEditImage = true
                config.allowSelectGif = false
                config.allowSelectVideo = false
                config.maxSelectCount = 5
                let vc = ZLPhotoPreviewSheet(results: nil)
                
                vc.showPhotoLibrary(sender: self)
                vc.selectImageBlock = { [weak self] results, isOriginal in
                    guard let `self` = self else { return }
                    var imgs : [UIImage] = []
                    var datas : [Data] = []
                    for m in results {
                        //                        let data = m.image.jpegData(compressionQuality: 0.2)
                        let data = TRTool.compressImage(m.image)
                        imgs.append(m.image)
                        
                        datas.append(data!)
                        
                    }
//                    TRNetManager.shared.upload(file: datas, _isFiles: true, _isChat: true,URLString: URL_IM_UploadPic, type: sessionModel.sessionId) {[weak self] responseObject in
//                        guard let self = self else {return}
//                        guard let picModel = TRPicModel.deserialize(from: responseObject) else { return }
//                        if  picModel.code == Net_Code_Success && !picModel.data.isEmpty{
//        //                    updateModelWithUI(postion, showImg: imgs, netNameStr: response!["data"] as! String)
//                            //构建图片消息
//                           
//                            let arr = picModel.data
//                            for i in 0...arr.count - 1 {
//                                let m = ChatMsgModel()
//                                m.sessionID = sessionModel.sessionId
//                                m.msgContent =  arr[i]
//                                m.type = MsgType.image.rawValue
//                                let id = TRDataManage.shared.userModel.scUserId as NSString
//                                m.sender = Int64(id.integerValue)
//                                //本地文件，要保存在本地
//                                m.localFile = datas[i]
//                                sendMsg(m: m)
//                            }
//
//                            } else {
//                                SVProgressHUD.showInfo(withStatus: "图片上传出错")
//                            }
//                    }
                    
                    TRNetManager.shared.common_upload_pic(files: datas, URLString: URL_V1_IM_Img_Upload) {[weak self] responseObject in
                        guard let self = self  else { return }
                        guard let picModel = TRPicModel.deserialize(from: responseObject) else { return }
                        if picModel.code == 1 && !picModel.data.isEmpty {
                            let arr = picModel.data
                            for i in 0...arr.count - 1 {
                                let m = ChatMsgModel()
                                m.sessionID = sessionModel.sessionId
                                m.msgContent =  arr[i]
                                m.type = MsgType.image.rawValue
                                let id = TRDataManage.shared.userModel.scUserId as NSString
                                m.sender = Int64(id.integerValue)
                                //本地文件，要保存在本地
                                m.localFile = datas[i]
                                sendMsg(m: m)
                            }
                        } else {
                            SVProgressHUD.showInfo(withStatus: "图片发送失败，请重试！")
                        }
                    }
                }
            }
        }
    }
 // MARK: - 发送消息，调用要先构造ChatMsgModel
    private func sendMsg(m : ChatMsgModel) {
        
        ChatClient.sharedInstance.sendMsg(msg: m, isGroup: false, to: sessionModel.sessionId) {[weak self] ret in
            guard let self = self else {return}
            if ret == 1 {
                sessionModel.lastMessage = m.msgContent
                sessionModel.lastMessageTime = m.sendTime
                sessionModel.lastMessageType = m.type
                //更新列表
                msgList.append(m)
                
                tableView.reloadData()
                if msgList.count > 1 {
                    tableView.scrollToRow(at: IndexPath(row: msgList.count - 1, section: 0), at: .bottom, animated: true)
                }                //插入一条信息
                ChatClient.sharedInstance.insertMessageList(sessionID: sessionModel.sessionId, data:[m])
                //更新会话
                ChatClient.sharedInstance.updateSessionMsg(newSession: sessionModel)
                
                sendView.textView.text = ""
            } else {
                SVProgressHUD.showInfo(withStatus: "消息发送失败")
            }
        }
    }
    
    private func customBottomView(){
        sendView = TRChatSendView(frame: .zero)
        self.view.addSubview(sendView)
        sendView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(0)
        }
        
        sendView.moreView.block = {[weak self](type) in
            guard let self  = self else { return }
            if type == ChatMoreAction.ablum.rawValue {
                uploadPic()
            } else if type == ChatMoreAction.camera.rawValue {
                takePhote()
            }
        }
        sendView.block = {[weak self](type ,content) in
            guard let self  = self  else { return  }
            if TRTool.isNullOrEmplty(s: content) {
                SVProgressHUD.showInfo(withStatus: "请输入内容")
                return
            }
            let m = ChatMsgModel()
            m.sessionID = sessionModel.sessionId
            m.msgContent = content
            m.type = type
            m.receiveId = sessionModel.receiveId
            let id = TRDataManage.shared.userModel.scUserId as NSString
            
            m.sender = Int64(id.integerValue)
            
            sendMsg(message: m)
        }
//        sendView.testBlock = {[weak self](type, content) in
//            guard let self  = self  else { return  }
//            let m = ChatMsgModel()
//            m.sessionID = sessionModel.id
//            m.msgContent = content
//            m.type = type
//            let id = TRDataManage.shared.userModel.scUserId as NSString
//            m.sender = Int64(id.integerValue)
//            m.sendTime = TRTool.currentLongTime()
//            
//            sessionModel.lastMessage = m.msgContent
//            sessionModel.lastMessageTime = m.sendTime
//            sessionModel.lastMessageType = m.type
//            ChatClient.sharedInstance.updateSessionMsg(newSession: sessionModel)
//            ChatClient.sharedInstance.insertMessageList(sessionID: sessionModel.id, data: [m])
//            updateMsgList()
//        }

    }
    @objc func receiveMsg(noti : Notification){
        //updateList
        updateMsgList()
    }
    
    
    //处理消息分组
    private func aaa(){
       
        for m in msgList {
            let cm = ChatMsgModel()
            cm.msgContent = "12:00"
            cm.type = 9
        }
    }
    private func sendMsg(message : ChatMsgModel){
        ChatClient.sharedInstance.sendMsg(msg: message, isGroup: false, to: sessionModel.sessionId) {[weak self] ret in
            guard let self = self else {return}
            if ret == 1 {
                sessionModel.lastMessage = message.msgContent
                sessionModel.lastMessageTime = message.sendTime
                sessionModel.lastMessageType = message.type
                ChatClient.sharedInstance.updateSessionMsg(newSession: sessionModel)
                ChatClient.sharedInstance.insertMessageList(sessionID: sessionModel.sessionId, data: [message])
                updateMsgList()
                sendView.textView.text = ""
            } else {
                SVProgressHUD.showInfo(withStatus: "会话异常，请重试")
            }
        }
    }

    private func updateMsgList(_ animated : Bool = true){
        let list = ChatClient.sharedInstance.getMessageList(sessionID: sessionModel.sessionId)
        msgList = ChatUtil.shared.messageListToGroup(list)
        if !Thread.current.isMainThread {
            DispatchQueue.main.sync {
                tableView.reloadData()
                if msgList.count > 1 {
                    tableView.scrollToRow(at: IndexPath(row: msgList.count - 1, section: 0), at: .bottom, animated: animated)
                }
            }
        } else {
            tableView.reloadData()
            if msgList.count > 1 {
                tableView.scrollToRow(at: IndexPath(row: msgList.count - 1, section: 0), at: .bottom, animated: animated)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
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
//        let msg = msgList[indexPath.row] as ChatMsgModel
//        if msg.type == MsgType.image.rawValue {
//            let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: msg.msgContent))
//            if data != nil {
//                let img = UIImage(data: data!)
//                let previewController = TRImagePreviewController(images: [img! as UIImage] ,currentIndex: indexPath.row)
//                previewController.modalPresentationStyle = .fullScreen
//                TRTool.getCurrentWindow()?.rootViewController!.present(previewController, animated: true)
//            }
//        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = msgList[indexPath.row]
        if sessionModel.receiveType.elementsEqual("PRIVATE") {
            if !chatUserInfo.isEmpty {
                msg.sendInfo = chatUserInfo.first
            }
        }
        if msg.type == MsgType.text.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "txt", for: indexPath) as! TRChatTextCell
            cell.msgModel = msg
            return cell
        } else if msg.type == MsgType.tip.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath) as! TRChatTimeCell
            cell.lab.text = msg.msgContent
            return cell
        } else if msg.type == MsgType.image.rawValue {
//
            let cell = tableView.dequeueReusableCell(withIdentifier: "img", for: indexPath) as! TRChatImgCell
            cell.imgBlock = {[weak self] in
                let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: msg.msgContent))
                if data != nil {
                    let img = UIImage(data: data!)
                    let previewController = TRImagePreviewController(images: [img! as UIImage] ,currentIndex: 0)
                    previewController.modalPresentationStyle = .fullScreen
                    TRTool.getCurrentWindow()?.rootViewController!.present(previewController, animated: true)
                }else {
                    let previewController = TRImagePreviewController(images: [msg.msgContent] ,currentIndex: 0)
                    previewController.modalPresentationStyle = .fullScreen
                    TRTool.getCurrentWindow()?.rootViewController!.present(previewController, animated: true)
                }
            }
            cell.msgModel = msg
            return cell
        }
        
        
        //uchon
        let cell = tableView.dequeueReusableCell(withIdentifier: "txt", for: indexPath) as! TRChatTextCell
        cell.msgModel = msg
        return cell
    }
    
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.editedImage] as! UIImage
        
        var imgs : [UIImage] = [img]
        var datas : [Data] = []
        let data = img.jpegData(compressionQuality: 0.2)
        imgs.append(img)
        datas.append(data!)
            
        TRNetManager.shared.common_upload_pic(files: datas,URLString: URL_V1_IM_Img_Upload) {[weak self] responseObject in
            guard let self = self else {return}
            guard let picModel = TRPicModel.deserialize(from: responseObject) else {return}
            if  picModel.code == Net_Code_Success && !picModel.data.isEmpty {
                //构建图片消息
                let arr = responseObject!["data"] as! [String]
                for i in 0...arr.count - 1 {
                    let m = ChatMsgModel()
                    m.sessionID = sessionModel.sessionId
                    m.msgContent =  arr[i]
                    m.type = MsgType.image.rawValue
                    let id = TRDataManage.shared.userModel.scUserId as NSString
                    m.sender = Int64(id.integerValue)
                    //本地文件，要保存在本地
                    m.localFile = datas[i]
                    sendMsg(m: m)
                }

                } else {
                    SVProgressHUD.showInfo(withStatus: "图片上传出错")
                }
        }
        
        picker.dismiss(animated: true)
        
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

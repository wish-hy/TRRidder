/*
    聊天管理 单利
 */

import UIKit
import SwiftProtobuf
import WCDBSwift

//sdk状态
enum ChatClientState : Int {
    //已连接
    case connected = 0
    //断开连接
    case disConnect = 1
    //正在连接 (连接不成功，会再次进入连接状态，多次不成功，会进入断开连接状态)
    case connecting = 3
    //一登录
    case login = 4
    //退出登录
    case logout = 5
    //登录失败
    case faield
}
//协议，监听客户端的状态
protocol ChatClientDelegate : NSObject {
    func stateDidChange(_ state : ChatClientState)
}

class ChatClient : NSObject, SocketConnectionDelegate{
    var buffer = Data()
    weak var delegate : ChatClientDelegate?
    //代理方法
    internal func recvMsg(_ data: Data) {
        buffer.append(data) // 将接收到的数据追加到缓冲区
        while let completeMessage = extractCompleteMessage() {
            // 处理完整的消息
            handleCompleteMessage(completeMessage)
        }
    }
    
    internal func didConnected(_ isSuccess: Bool) {
        //连接情况
        isConnecting = false
        if isSuccess {
            if delegate != nil {
                delegate!.stateDidChange(.connected)
            }
            
            TRGCDTimer.share.destoryTimer(withName: "reconnect")
            
            //登录操作
            var request = GlMessage()
            request.msgID =  "\(TRTool.currentLongTime())"
            request.type = .login
            request.sendTime = Int64(TRTool.currentLongTime())
            var msg = LoginMessage.init()
            msg.imToken = imToken as String
            request.content = .loginMessage(msg)
            do {
//                let binaryData = try request.serializedData()
                let binaryData = try prependVarint32LengthPrefix(to: request)
                sendMessage(msg: binaryData)
                
            } catch {
               
            }
        }
        
        
    }
    
    internal func didDisConnected(_ isSuccess: Bool, reson reason: Int32) {
        //断开连接 reason = 1主动断开
//        print("断开了")
        if delegate != nil {
            delegate!.stateDidChange(.disConnect)
        }
        if isSuccess && reason == 0 && !isConnecting{
            startReConnectTimer()
        }
    }
    func handleCompleteMessage(_ data: Data) {
        // 解码 Protobuf 消息或执行其他操作
        print("消息接收完成")
        do {
            let message = try decodeProtobufMessage(from: data)
            if message.type == .login {
                //登录信息
                if message.respMessage.status {
                    loginResultBlock!(["code" : "1"])
                    if delegate != nil {
                        delegate!.stateDidChange(.login)
                    }
                } else {
                    loginResultBlock!(["code" : "0"])
                    if delegate != nil {
                        delegate!.stateDidChange(.faield)
                    }
                }
                
                //处理心跳
                sendHeartMsg()
            } else if message.type == .chatMessage {
                //聊天消息
                let mm = ChatMsgModel()
                mm.msgID = message.msgID
                mm.msgContent = message.chatMessage.msgContent
                mm.sender = message.chatMessage.sender
                mm.sendTime = message.chatMessage.sendTime
                mm.sessionID = message.chatMessage.sessionID
                mm.type = message.chatMessage.type.rawValue

                //收到消息，发送通知
                NotificationCenter.default.post(name: .init(Notification_Name_Receive_Message), object: mm)
            } else if message.type == .heartbeat {
                //心跳
            }
            //消息处理
        } catch {
            return
        }
    }

    
    func hasCompleteMessageInBuffer() -> Bool {
        guard buffer.count > 0 else { return false }
        
        var length = 0
        var shift = 0
        for i in 0..<buffer.count {
            let byte = buffer[i]
            length |= (Int(byte & 0x7F) << shift)
            if (byte & 0x80) == 0 {
                break
            }
            shift += 7
        }
        
        return buffer.count >= length + (shift / 7 + 1)
    }
    
    func extractCompleteMessage() -> Data? {
        guard hasCompleteMessageInBuffer() else { return nil }
        
        var length = 0
        var shift = 0
        for i in 0..<buffer.count {
            let byte = buffer[i]
            length |= (Int(byte & 0x7F) << shift)
            if (byte & 0x80) == 0 {
                break
            }
            shift += 7
        }
        let messageLength = length + (shift / 7 + 1)
        let message = buffer.subdata(in: 0..<messageLength)
        buffer.removeSubrange(0..<messageLength) // 移除已处理的消息
        
        return message
    }

    
    fileprivate var clientSocket: SocketConnection!
    //数据缓冲
    fileprivate var receiveData:Data=Data.init();
    //重连时间间隔
    fileprivate var timeInterval=1;
    
    //是否正在连接
    fileprivate var isConnecting : Bool = false
    //单例模式
    static let sharedInstance=ChatClient();
    
    //账户信息
    fileprivate var account : NSString = ""
    fileprivate var scAccount : NSString = ""
    //修改 使用tmToken登录
    fileprivate var imToken : NSString = ""
    fileprivate var loginResultBlock : (([String : String]?)->())? =  nil
    fileprivate var sessionList : [ChatSessionModel] = []
    private override init() {
        super.init()
        clientSocket = SocketConnection.init()
        configHost()
        clientSocket.delegate = self
        
        
    }
}



// MARK: - 外部开放接口
extension ChatClient {
    //在连接之前配置，默认值要配置成线上的
    func configHost(host : String = Chat_IP, port : Int = Chat_Port) {
        if !host.isEmpty {
            clientSocket.ip_ADRR = host
        }
        if port != 0 {
            clientSocket.port = port
        }
    }
    // MARK: - 登录登出
    @available(*, deprecated, message: "使用loginWithToken")
    func loginWithAccount(account : NSString, scAccount : NSString ,resultBlock : @escaping(_ dict : [String : String]?)->()){
        self.loginResultBlock = resultBlock
        self.account = account
        self.scAccount = scAccount
        startConnect()
    }
    func loginWithToken(_ token : NSString, resultBlock : @escaping(_ dict : [String : String]?)->()) {
        //
        self.imToken = token
        self.loginResultBlock = resultBlock
        startConnect()
    }
    // - 登出
    func logout(){
        var request = GlMessage()
        request.msgID =  "\(TRTool.currentLongTime())"
        request.type = .login
        request.sendTime = Int64(TRTool.currentLongTime())
        var msg = LoginMessage.init()
        msg.imToken = imToken as String
        request.content = .loginMessage(msg)
        do {
//            let binaryData = try request.serializedData()
            let binaryData = try prependVarint32LengthPrefix(to: request)
            sendMessage(msg: binaryData)
            
        } catch {
           
        }
        
        
        stopConnect()
    }
    // MARK: - 消息管理 会话管理
    //消息发送
   
    private func sendPrivateMsg(msg : ChatMsgModel, to : String , successBlock : @escaping(Int)->()) {
        /*
         "content": "skdjf",
                "msgCode": "TEXT",
                "sessionId": 1773267726920314880,
         */

    }
    //发送组消息
    private func sendGroupMsg(msg : ChatMsgModel, to : String, successBlock : @escaping(Int)->()) {
        TRNetManager.shared.post_no_lodding(url: URL_IM_Group_Send, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                successBlock(1)
            } else {
                successBlock(0)
            }
        }
    }
    //发送消息
    func sendMsg(msg : ChatMsgModel, isGroup : Bool, to : String, successBlock : @escaping(Int)->()) {
        var msgCode = "TEXT"
        if msg.type == MsgType.text.rawValue {
            msgCode = "TEXT"
        } else if msg.type == MsgType.image.rawValue {
            msgCode = "IMAGE"
        }
        let parms = [
            "content" : msg.msgContent,
            "msgCode" : msgCode,
            "sessionId" : msg.sessionID,
            "chatType" : isGroup ? "GROUP" : "PRIVATE",
            "receiveId" : msg.receiveId
        ]
        TRNetManager.shared.post_no_lodding(url: URL_IM_SendMsg, pars: parms) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                //此处要保存消息
                msg.msgID = model.data as! String
                msg.sendTime = TRTool.currentLongTime()
                //此处要保存文件
                if msg.type == MsgType.image.rawValue {
                    msg.msgContent = ChatUtil.shared.saveImgData(sessionID: msg.sessionID, msgID: msg.msgID, data: msg.localFile)
                }
                successBlock(1)
            } else {
                successBlock(0)
            }
        }
    }
    //创建一个会话，
    /*
        创建会话：
       
        1.主动创建
     */
    func createNewSession(receiveID : Int64, successBlock : @escaping(Int)->()){
        TRNetManager.shared.post_no_lodding(url: URL_IM_CreateSession, pars: ["receiveId":receiveID, "receiveType" : "PRIVATE"]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                //此处要创建会话。
                guard let session = ChatSessionModel.deserialize(from: codeModel.data as! [String : Any]) else {return}
                session.scUserId = TRDataManage.shared.userModel.scUserId
                insertSessionList(data: [session])
                successBlock(Int.init(session.sessionId) ?? 0)
            } else {
                successBlock(0)
            }
        }
    }
    // 2.被动创建，收到消息，但没有会话， 拉去会话信息
    func pullNewSession(sessionID : String, successBlock : @escaping(Int)->()){
        TRNetManager.shared.get_no_lodding(url: URL_IM_PullSession, pars: ["sessionId":sessionID]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                guard let session = ChatSessionModel.deserialize(from: codeModel.data as! [String : Any]) else {return}
                session.scUserId = TRDataManage.shared.userModel.scUserId
                insertSessionList(data: [session])
                successBlock(1)
            } else {
                successBlock(0)
            }
        }
    }
    // MARK: - 归档 查询
    
    //获取会话列表 本地 、、加载会话时，查询时如果最后一条消息是空，就不返回
    func getSessionList()->[ChatSessionModel]{
//        let cache = YYCache(path: IM_Cache_Session_Path)
//        return cache?.object(forKey: "sessionList") as! [ChatMsgModel]
        guard let list = TRDBTool.sharedInstance.qureyFromDb(fromTable: TABLE_NAME_SESSION, cls: ChatSessionModel.self, orderBy: [ChatSessionModel.Properties.lastMessageTime.order(.descending)]) else { return [] }
        return list
    }
    // 获取某一条会话
    func getSession(sessionID : String)->ChatSessionModel? {
        guard let list = TRDBTool.sharedInstance.qureyFromDb(fromTable: TABLE_NAME_SESSION, cls: ChatSessionModel.self, where: ChatSessionModel.Properties.sessionId == sessionID) else { return nil }
        if list.isEmpty {return nil}
        return list.last
    }
    //插入消息会话列表 本地
    func insertSessionList(data : [ChatSessionModel]){
//        let cache = YYCache(path: IM_Cache_Session_Path)
//        cache?.setObject(data as NSCoding, forKey: "sessionList")
        TRDBTool.sharedInstance.insertToDb(objects: data, intoTable: TABLE_NAME_SESSION)
        

    }
    //更新会话最后一条 消息
    func updateSessionMsg(newSession : ChatSessionModel) {

        TRDBTool.sharedInstance.updateToDb(table: TABLE_NAME_SESSION, on: ChatSessionModel.Properties.all, with: newSession, where: ChatSessionModel.Properties.sessionId == newSession.sessionId)
        
    }
    //清除所有回话列表
    func clearSessionRecord(){
        TRDBTool.sharedInstance.deleteFromDb(fromTable: TABLE_NAME_SESSION)
        TRDBTool.sharedInstance.deleteFromDb(fromTable: TABLE_NAME_MESSAGE)
        //清除本地的会话文件
        ChatUtil.shared.deleteAllImgData()
    }
    //清除某一条会话
    func clearSessionWith(record : ChatSessionModel) {
        TRDBTool.sharedInstance.deleteFromDb(fromTable: TABLE_NAME_SESSION, where: ChatSessionModel.Properties.sessionId == record.sessionId)
        TRDBTool.sharedInstance.deleteFromDb(fromTable: TABLE_NAME_MESSAGE, where: ChatMsgModel.Properties.sessionID == record.sessionId)
        ChatUtil.shared.deleteAllImgData()
    }
    //消息管理
    func getMessageList(sessionID : String)->[ChatMsgModel]{
       
        
        guard let list = TRDBTool.sharedInstance.qureyFromDb(fromTable: TABLE_NAME_MESSAGE, cls: ChatMsgModel.self, where: ChatMsgModel.Properties.sessionID == sessionID, orderBy: [ChatMsgModel.Properties.sendTime.order(.ascending)]) else { return [] }
        return list
    }
    func insertMessageList(sessionID : String, data: [ChatMsgModel]){
       print("插入一条消息")
        TRDBTool.sharedInstance.insertToDb(objects: data, intoTable: TABLE_NAME_MESSAGE)
        
        
    }
    // 手动解码 Protobuf 消息
    func decodeProtobufMessage(from data: Data) throws -> GlMessage {
        var cursor = 0
        
        // 读取 Varint32 长度前缀
        var length: Int = 0
        var shift = 0
        repeat {
            guard cursor < data.count else {
                throw NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Incomplete data"])
            }
            let byte = data[cursor]
            length |= (Int(byte & 0x7F) << shift)
            shift += 7
            cursor += 1
        } while (data[cursor - 1] & 0x80) != 0 // 继续读取直到最高位为0
        
        // 根据长度前缀读取消息
        guard cursor + length <= data.count else {
            throw NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Incomplete message data"])
        }
        let messageData = data.subdata(in: cursor..<cursor + length)
        var message = GlMessage()
        try message.merge(serializedData: messageData)
        return message
    }
}




extension ChatClient {
    private func reStartConnect(){
        if isConnecting {
            return
        }
        startReConnectTimer()
    }
    // 开始连接
    private func startConnect(){
        
        startReConnectTimer();
    }
    
    //断开连接
    private func stopConnect(){
        clientSocket.stop()
    }
    
    
    //启动连接定时器
    private func startReConnectTimer(){
            //启动一个定时器执行
            TRGCDTimer.share.createTimer(withName: "reconnect", timeInterval: 3, queue: .global(), repeats: true) {[weak self ] in
                guard let self = self else {
                    TRGCDTimer.share.destoryTimer(withName: "reconnect")
                    return
                }
                if(self.clientSocket.isconnected){
                    TRGCDTimer.share.destoryTimer(withName: "reconnect")
                    return
                }
                if isConnecting {
                    return
                }
//                if(self.timeInterval<30){
//                    //每次从连增加3秒的间隔时间,步长越来越长
//                    self.timeInterval+=3;
//                } else {
//                    self.isConnecting = false
//                    //连接多次，未连接成功，让用户主动去连接，或者检测网络状态去处理
//                    TRGCDTimer.share.destoryTimer(withName: "reconnect")
//                    return
//                }
                if delegate != nil {
                    delegate!.stateDidChange(.connecting)
                }
                
                self.isConnecting = true
                self.clientSocket.socketConnection()
            
            }
        }
    
    //连接成功 心跳机制
    private func sendHeartMsg(){
        TRGCDTimer.share.createTimer(withName: "chat_heart", timeInterval: 50, queue: .global(), repeats: true) { [self] in
            var request = GlMessage()
            request.msgID =  "\(TRTool.currentLongTime())"
            request.type = .heartbeat
            request.sendTime = Int64(TRTool.currentLongTime())
            do {
//                let binaryData = try request.serializedData()
                let binaryData = try prependVarint32LengthPrefix(to: request)
                sendMessage(msg: binaryData)
                
            } catch {
               
            }
        }
    }
    private func stopHeaderMsg(){
        TRGCDTimer.share.destoryTimer(withName: "chat_heart")
    }
    // 将 Int 转换为 Varint32 格式的数据
    func varint32LengthPrefix(for value: Int) -> Data {
        var value = value
        var datas: [UInt8] = []
        repeat {
            let byte = value & 0b01111111
            value >>= 7
            if value != 0 {
                datas.append(UInt8(byte | 0b10000000))
            } else {
                datas.append(UInt8(byte))
            }
        } while value != 0
        return Data(datas.reversed())
    }
    
    func prependVarint32LengthPrefix(to message: GlMessage) throws -> Data {
        let serializedMessage = try message.serializedData()
        let lengthPrefix = varint32LengthPrefix(for: Int(serializedMessage.count))
        var finalData = Data()
        finalData.append(lengthPrefix)
        finalData.append(serializedMessage)
        return finalData
    }
}

extension ChatClient{
    //发送消息
    private func sendMessage(msg:Data){
        clientSocket.sendMsg(msg)
    }
}
   


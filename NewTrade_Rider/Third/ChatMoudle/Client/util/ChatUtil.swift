//
//  ChatUtil.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/3/15.
//

import UIKit
import WCDBSwift
import AudioToolbox
let IM_Cache_Session_Path  = "im/session"

//后面追加会话ID
let IM_Cache_Message_Path = "im/message"
class ChatUtil: NSObject {
    static var shared = ChatUtil()
    // MARK: - 文件维护（自己发的图片）
    func saveImgData(sessionID : String, msgID : String ,data : Data?)->String {
        guard let data  = data else { return ""}
        var user = TRDataManage.shared.userModel.scUserId
        if TRTool.isNullOrEmplty(s: user) {
            user = "--"
        }
        let fm = FileManager.default
        let fileName = "\(sessionID)&\(msgID)"
        let userFilePath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,
                                                             true).last! + "/\(user)/pics"
        if !fm.fileExists(atPath: userFilePath) {
           try? fm.createDirectory(atPath: userFilePath, withIntermediateDirectories: false)
        }
        
        let filePath = userFilePath.appending("/\(fileName)")
        try? data.write(to: URL.init(fileURLWithPath: filePath))
        return filePath
    }
    //删除仅本地所有聊天 图片（自己发的）
    func deleteAllImgData(){
        let fm = FileManager.default

        var user = TRDataManage.shared.userModel.scUserId

        let userFilePath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,
                                                             true).last! + "/\(user)/pics"
        try? fm.removeItem(at: URL.init(fileURLWithPath: userFilePath))
        print("aa")
    }
    func deleteImgDataWithSession(sessionID : String) {
        let fm = FileManager.default

        var user = TRDataManage.shared.userModel.scUserId

        let userFilePath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,
                                                             true).last! + "/\(user)/pics"
        do {
            let files = try fm.contentsOfDirectory(atPath: userFilePath)
            for f in files {
                let p = userFilePath.appending("/\(f)")
                try? fm.removeItem(atPath: p)
            }
        } catch {
            
        }
        
        
    }
    //消息时间处理
    func messageListToGroup(_ list : [ChatMsgModel])->[ChatMsgModel] {
        if list.isEmpty {return list}
        var ml : [ChatMsgModel] = []
        
        var lastTime = list.first!.sendTime / 1000
        //时间模型
        let tm = ChatMsgModel()
        tm.type = MsgType.tip.rawValue
        tm.msgContent = TRTool.longTimeToShowTime(lastTime)
        ml.append(tm)
        ml.append(list.first!)
        if list.count == 1 {
            return ml
        }
        for i in 1...list.count - 1 {
            let m = list[i]
            let time = m.sendTime / 1000
            if abs(lastTime - time) >= 5 * 60 {
                let tm = ChatMsgModel()
                tm.type = MsgType.tip.rawValue
                tm.msgContent = TRTool.longTimeToShowTime(time)
                ml.append(tm)
                lastTime = time
            }
            ml.append(m)
        }
       
        return ml
    }
    
    // MARK: - 聊天用户信息维护
    
    func insertUserInfo(user : ChatUserModel) {
        
        TRDBTool.sharedInstance.insertToDb(objects: [user], intoTable: TABLE_NAME_USER)
    }
    func updateUserInfo(user : ChatUserModel) {
        TRDBTool.sharedInstance.updateToDb(table: TABLE_NAME_USER, on: ChatUserModel.Properties.all, with: user, where: ChatUserModel.Properties.id == user.id)
    }
    // 更新用户信息
    func updateUserInfo(id : String, result : @escaping(_ user : ChatUserModel)->()){
        //此用户一定是存在的，
        var updateTime = ""
        let list = TRDBTool.sharedInstance.qureyFromDb(fromTable: TABLE_NAME_USER, cls: ChatUserModel.self, where: ChatUserModel.Properties.id == id) ?? []
        
        if list.isEmpty {
            updateTime = ""
        } else {
            updateTime = list.first!.updateTime
        }
        var pars = [
            "id" : id,
            "updateTime" : updateTime
        ]
        TRNetManager.shared.post_no_lodding(url: URL_IM_UserIno, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                guard let m = ChatUserModel.deserialize(from: codeModel.data as! [String : Any]) else {return}
                if list.isEmpty {
                    insertUserInfo(user: m)
                } else {
                    updateUserInfo(user: m)
                }
                result(m)
            } else {
                
            }
        }
    }
    func queryUserInfo(id : String, result : @escaping(_ user : ChatUserModel)->()){

        var updateTime = ""
        let list = TRDBTool.sharedInstance.qureyFromDb(fromTable: TABLE_NAME_USER, cls: ChatUserModel.self, where: ChatUserModel.Properties.id == id) ?? []
        
        if list.isEmpty {
            updateTime = ""
        } else {
//            updateTime = list.first!.updateTime
            //从数据库里取出用户，不需要调接口，如果list是空的需要，调接口去查询
            result(list.first!)
            return
        }
        var pars = [
            "id" : id,
            "updateTime" : updateTime
        ]
        TRNetManager.shared.post_no_lodding(url: URL_IM_UserIno, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                guard let m = ChatUserModel.deserialize(from: codeModel.data as! [String : Any]) else {return}
                if list.isEmpty {
                    insertUserInfo(user: m)
                } else {
                    updateUserInfo(user: m)
                }
                result(m)
            } else {
                
            }
        }
    }
    
    //消息来了，播放声音
    func playMessageComeVoice(){
        AudioServicesPlaySystemSound(1015)
    }
}

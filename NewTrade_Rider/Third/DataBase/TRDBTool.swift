//
//  TRDBTool.swift
//  DBTest
//
//  Created by xph on 2024/3/26.
//

import UIKit
import WCDBSwift
///Users/xph/Documents/NewTrade_Mall/NewTrade_Mall/Vendor/DataBase/TRDBTool.swift:34:33 Cannot find 'dataBasePath' in scope

//消息表
let TABLE_NAME_MESSAGE = "TBALE_NAME_MESSAGE"
//会话表
let TABLE_NAME_SESSION = "TABLE_NAME_SESSION"
//用户表
let TABLE_NAME_USER = "TABLE_NAME_USER"

//群表
let TABLE_NAME_GROUP = "TABLE_NAME_GROUP"
//群成员表(以群为主)
let TABLE_NAME_GROUP_MEMBER = "TABLE_NAME_GROUP_MEMBER"
class TRDBTool {
    var dataBase: Database?

    static let sharedInstance = TRDBTool()
    init() {
        var user = TRDataManage.shared.userModel.scUserId
        if TRTool.isNullOrEmplty(s: user) {
            user = "--"
        }
        let chatDBPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,
                                                             true).last! + "/\(user)/CHAT.db"

        dataBase = Database(at: chatDBPath)
        createTable(table: TABLE_NAME_MESSAGE, of: ChatMsgModel.self)
        createTable(table: TABLE_NAME_SESSION, of: ChatSessionModel.self)
        createTable(table: TABLE_NAME_USER, of: ChatUserModel.self)
        
//        createTable(table: TABLE_NAME_GROUP, of: <#T##TableDecodable.Protocol#>)
    }
    
     ///创建表
     func createTable<T: TableDecodable>(table: String, of ttype:T.Type) -> Void {
         do {
             try dataBase?.create(table: table, of:ttype)
         } catch let error {
             debugPrint("create table error \(error.localizedDescription)")
         }
     }
     ///插入
     func insertToDb<T: TableEncodable>(objects: [T] ,intoTable table: String) -> Void {
         do {
             try dataBase?.insert(objects, intoTable: table)
         } catch let error {
             debugPrint(" insert obj error \(error.localizedDescription)")
         }
     }
     
     ///修改
     func updateToDb<T: TableEncodable>(table: String, on propertys:[PropertyConvertible],with object:T,where condition: Condition? = nil) -> Void{
         do {
             try dataBase?.update(table: table, on: propertys, with: object,where: condition)
         } catch let error {
             debugPrint(" update obj error \(error.localizedDescription)")
         }
     }
     
     ///删除
     func deleteFromDb(fromTable: String, where condition: Condition? = nil) -> Void {
         do {
             try dataBase?.delete(fromTable: fromTable, where:condition)
         } catch let error {
             debugPrint("delete error \(error.localizedDescription)")
         }
     }
     
     ///查询
     func qureyFromDb<T: TableDecodable>(fromTable: String, cls cName: T.Type, where condition: Condition? = nil, orderBy orderList:[OrderBy]? = nil) -> [T]? {
         do {
             let allObjects: [T] = try (dataBase?.getObjects(fromTable: fromTable, where:condition, orderBy:orderList))!
             debugPrint("\(allObjects)");
             return allObjects
         } catch let error {
             debugPrint("no data find \(error.localizedDescription)")
         }
         return nil
     }
     
     ///删除数据表
     func dropTable(table: String) -> Void {
         do {
             try dataBase?.drop(table: table)
         } catch let error {
             debugPrint("drop table error \(error)")
         }
     }
     
     /// 删除所有与该数据库相关的文件
     func removeDbFile() -> Void {
         do {
             try dataBase?.close(onClosed: { [self] in
                 try dataBase?.removeFiles()
             })
         } catch let error {
             debugPrint("not close db \(error)")
         }
     }


}

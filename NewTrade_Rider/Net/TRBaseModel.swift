//
//  TRBaseModel.swift
//  As
//
//  Created by xph on 2023/12/6.
//

import Foundation
import HandyJSON
//RIDER_NOT_EXISTED(6003, "骑手不存在"),
let Net_Code_User_Not_Exist = 1005
let Net_Code_RIDER_Not_Exist = 6003
let Net_Code_Apply_Has_Exist = 6023
//用户未登录相关
//未带token
let Net_Code_User_Not_Login_1 = 3
//token已过期
let Net_Code_User_Not_Login_2 = 5
//token错误
let Net_Code_User_Not_Login_3 = 11
//未登录
let Net_Code_User_Not_Login_4 = 12

//非法参数
let Net_Code_Error = 106

let Net_Code_Success = 1
class TRBaseModel: HandyJSON {
    
    var exceptionCode = -1
    var exceptionMsg = "服务异常，请稍后重试。。"
    required init() {
    }
}

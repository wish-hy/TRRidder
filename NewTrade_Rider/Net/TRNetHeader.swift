//
//  TRNetHeader.swift
//  As
//
//  Created by xph on 2023/12/6.
//

import Foundation

// MARK: - 测试服务器



//正式服务器


//#if false
//let BASIC_Login_URL = "http://yunen.test.brjkj.cn:30001/auth-service"
//
//let BASIC_URL = "http://yunen.test.brjkj.cn:30001/rider-backend-api-service"
//let Web_Basic_URL = "http://yunen.test.brjkj.cn:8000/gamma-h5/pages/DisH5Item"
//let rsa_pu_key = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIPYrEGRt50AlytqwWgTOJFpJUw07t71Mss4ZCqA72W0G0ZmvwwPOTXrU2cUyGWQOoXNAJ23nMk4uNWKMNkRqUcCAwEAAQ=="
//let Chat_IP = "192.168.1.29"
//let Chat_Port = 7214
//#else
//let BASIC_Login_URL = "https://api.fmyunwei.com/auth-service"
//let BASIC_URL = "https://api.fmyunwei.com/rider-backend-api-service"
//let Web_Basic_URL = "https://fmyunwei.com/gamma-h5/pages/DisH5Item"
//let rsa_pu_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAHNqFodMvt1xUSWdfYPa8UO643QvWt6O5e24jfeUbpbjW4lIHZ1WgtaCREnPno7SO4Ic62f53Tzp5bDV6P0lMz/p6+ybwTz8SJFpiE3UE6jBdnqGgcyRN+ZdTLxLEbaomHAqjA5zAyzukuyMrQp0R8HmA+HvKKT/xsV7trOFRZwIDAQAB"
//let Chat_IP = "139.9.101.147"
//let Chat_Port = 30214
//#endif


#if DEBUG
let BASIC_Login_URL = TRTool.getData(key: "BASIC_Login_URL") as? String ?? "http://yunen.test.brjkj.cn:30001/auth-service"
let BASIC_URL = TRTool.getData(key: "BASIC_URL") as? String ?? "http://yunen.test.brjkj.cn:30001/rider-backend-api-service"
let Web_Basic_URL = "http://192.168.1.5:8080/gamma-h5/pages/DisH5Item"
//TRTool.getData(key: "Web_Basic_URL") as? String ?? "http://yunen.test.brjkj.cn:8000/gamma-h5/pages/DisH5Item"
//let Web_Basic_URL = "https://fmyunwei.com/gamma-h5/pages/DisH5Item"
let rsa_pu_key = TRTool.getData(key: "rsa_pu_key") as? String ?? "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIPYrEGRt50AlytqwWgTOJFpJUw07t71Mss4ZCqA72W0G0ZmvwwPOTXrU2cUyGWQOoXNAJ23nMk4uNWKMNkRqUcCAwEAAQ=="
let Chat_IP = TRTool.getData(key: "Chat_IP") as? String ?? "192.168.1.29"
let Chat_Port = TRTool.getData(key: "Chat_Port") as? Int ?? 7214

let BASIC_UpPic_URL = TRTool.getData(key: "BASIC_UpPic_URL") as? String ?? "http://yunen.test.brjkj.cn:30001/minio-service"

#else
let BASIC_Login_URL = "https://api.fmyunwei.com/auth-service"
let BASIC_URL = "https://api.fmyunwei.com/rider-backend-api-service"
let Web_Basic_URL = "https://fmyunwei.com/gamma-h5/pages/DisH5Item"
let rsa_pu_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAHNqFodMvt1xUSWdfYPa8UO643QvWt6O5e24jfeUbpbjW4lIHZ1WgtaCREnPno7SO4Ic62f53Tzp5bDV6P0lMz/p6+ybwTz8SJFpiE3UE6jBdnqGgcyRN+ZdTLxLEbaomHAqjA5zAyzukuyMrQp0R8HmA+HvKKT/xsV7trOFRZwIDAQAB"
let Chat_IP = "139.9.101.147"
let Chat_Port = 30214
let BASIC_UpPic_URL = "https://api.fmyunwei.com/minio-service"

#endif


//车辆管理
let Web_Traffic_Web = "/gamma-h5/pages/DisH5Item/rider/page/carlist/index"
//用户登录相关
let URL_User_Register = "/rider/register"

let URL_User_Forget_Pwd = "/rider/forgotPwd"
let URL_Send_Code = "/auth/sendCode"
let URL_Refresh_Token = "/auth/refreshToken"
let URL_User_Quit = "/auth/logOut"
let URL_User_Login_Pwd = "/auth/loginAcc"
let URL_User_Login_Code = "/auth/loginPho"
let URL_User_Logout = "/auth/logOut"

// MARK: - 图片上传
let URL_Upload_Img = "/rider/uplPic"
let URL_Upload_idCard = "/uplIdCardPicBatch"
let URL_Upload_VehiclePicBatch = "/uplVehiclePicBatch"
let URL_Upload_License = "/uplLicensePicBatch"
let URL_Sugges_uplPic = "/serCenter/uplSuggestPic"
let URL_Head_UplPic = "/me/uplHeaderPic"
// MARK: - 申请相关
// /rider-backend-api-service/rider/addRiderInfo
let URL_Rider_Add = "/rider/addRiderInfo"
let URL_Rider_upInfo = "/rider/updRiderInfo"
let URL_Rider_uplPic = "/rider/uplPic"

let URL_Traffic_EnergyType = "/rider/getVtEnergyList"
let URL_Traffic_Type = "/vehicle/getVtList"

let URL_Address_List =  "/rider/getAreaList"

let URL_Address_No_Limit_List = "/me/getAreaList"

let URL_Opening_Area_List = "/apply/getAreaList"

let URL_Rider_Info =  "/rider/getApplyRiderInfo"

let URL_Nation_Info = "/rider/getNationList"

//申请改版
let URL_Rider_Apply_Add = "/apply/addRiderRegisterApply"
let URL_Rider_Apply_Again = "/apply/addAgainApply"
let URL_Rider_Apply_Record_Detail = "/apply/getApplyDetails"
let URL_Rider_Apply_List = "/apply/getApplyPage"
let URL_Rider_Vehicle_List = "/apply/getMyVehicleList"
let URL_Rider_Apply_Info = "/apply/getRiderInfo"
let URL_Vehicle_Type_Info = "/apply/getVehicleListBySerCode"

let URL_Adjust_Area_HasOpened = "/apply/getOpenAreaList"
let URL_Rider_Vehicle_Type_List = "/apply/getVehicleListBySerCode"

let URL_Rider_CerInfo = "/apply/getIdentityInfo"
let URL_Rider_CerInfo_Update = "/apply/updateIdentityInfo"
//对应业务的可选车辆类型
let URL_Rider_Enable_Vehicle = "/apply/getVehicleListBySerCode"
// MARK: - 首页
let URL_Home_AD = "/home/getAdConsultPage"
let URL_Home_Begin_Set = "/home/updRiderInfo"
let URL_Home_State_Changed = "/home/updRiderStatus"
let URL_Home_Statistics =     "/home/getRiderStatistics"
let URL_Home_GetRiderStatus = "/home/getRiderStatus"

// /vehicle/getVehicleMap
let URL_Rider_Open_Vehicle = "/vehicle/getVehicleMap"
let URL_Order_Create = "/home/createRechargeOrder"

let URL_Order_Cancel = "/home/cancelRechargeOrder"

let URL_Order_Pay = "/home/payRechargeOrder"

let URL_MALL_Order_Pay_Result = "/myOrder/getPayResult"

//上报骑手位置
let URL_UpLoction = "/me/uplLongLat"
let URL_Order_Count_Statistics = "/order/getOrderCount"
// MARK: - 订单
let URL_Order_Waitting = "/order/getWaitingPage"
let URL_Order_Delivering = "/order/getDeliveringPage"
let URL_Order_Taking = "/order/getTakePage"

let URL_Order_Detail = "/order/getRiderOrderDetail"

let URL_Order_Action_Done = "/order/updArriveOrder"
let URL_Order_Action_Cancel = "/order/updCancelTakeOrder"
let URL_Order_Action_Take = "/order/updTakeOrder"
let URL_Order_Action_Accept = "/order/addRiderOrder"

let URL_Order_Action_Delivering_Report = "/exception/addDeliveryException"
let URL_Order_Action_Take_Report = "/exception/addTakeException"
let URL_Order_Action_Appeal = "/order/addOrderAppeal"

//隐私号获取
let URL_Order_Privacy_Phone = "/order/getOrderCallInfo"

//差价计算
let URL_Order_Patch_Cal = "/order/localDelGoodsFeePatchCalculate"
//生成差价订单
let URL_Order_Patch_Order = "/order/createLocalDelGoodsPatchOrder"
// MARK: - Chat
let URL_IM_Chat_Info = "/im/getUserInfo"

let URL_IM_CreateSession = "/im/createSession"
let URL_IM_PullSession = "/im/pullSession"
let URL_IM_Group_Send = "/im/sendGroup"
let URL_IM_SendMsg = "/im/sendMsg"
let URL_IM_UserIno = "/im/getUserInfo"
//不用
let URL_IM_SendPrivate = "/im/sendPrivate"
let URL_IM_UploadPic = "/im/uploadPics"
//取货异常
let URL_Order_Reason_Taking = "/exception/getTakeCodeList"
let URL_Order_Delivering_upPic = "/exception/getDeliveryCodeList"
let URL_Order_Taking_upPic = "/exception/uplTakePics"
//配送异常
let URL_Order_Reason_Delivery = "/exception/getDeliveryCodeList"
// MARK: - 个人信息
let URL_Me_Info = "/me/getRiderInfo"
let URL_Me_Update_Info = "/me/updateRider"
let URL_Me_Update_Info_Head = "/me/uplHeaderPic"
let URL_Me_Update_Phone = "/me/updatePhone"
let URL_Me_Statistics = "/me/getRiderStatistics"
let URL_Me_RiderFrequentFeature = "/me/getRiderFrequentFeature"    //查询常用功能信息
let URL_Me_Wallet_Info = "/me/wallet/getInfo"
//接单设置
let URL_Order_Setting_Get = "/rider/getRrcInfo"
let URL_Order_Settting_upd = "/rider/updRrcInfo"
///rider-backend-api-service/me/updPassword
let URL_Me_Update_Pwd = "/me/updPassword"
// MARK: - 车辆管理
let URL_Traffic_List = "/vehicle/getPage"

let URL_Traffic_Detail = "/vehicle/getDetail"

let URL_Traffic_Add = "/vehicle/add"

let URL_Traffic_Update = "/vehicle/update"
// MARK: - 服务中心
let URL_Service_Question_list = "/serCenter/getFaqPage"
let URL_Feedback = "/serCenter/addSuggest"
let URL_Service_qus_detail = "/serCenter/getFaqDetail"
let URL_Service_Protocol = "/me/getProtocolList"

// MARK: - 新版图片上传
let URL_V1_HeadPic_Upload = "/profilePicture/rider/uploadFileBatch"
let URL_V1_Sugges_Upload = "/suggest/uploadFileBatch"

// 社交批量上传文件
let URL_V1_IM_Img_Upload = "/imSc/uploadFileBatch"

let URL_V1_Vehicle_Upload = "/rider/vehicle/uploadFileBatch"
//行驶证、驾驶证
let URL_V1_Vehicle_Auth = "/rider/driveLicense/uploadFileBatch"

let URL_V1_Appeal_Upload = "/appeal/rider/uploadFileBatch"

let URL_V1_Exception_Upload = "/rider/exception/uploadFileBatch"

let URL_V1_IDCard_Upload = "/idCard/uploadFileBatch"


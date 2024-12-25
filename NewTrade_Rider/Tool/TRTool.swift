//
//  TRTool.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/4.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
typealias strBlock = (_ str: String)->Void

typealias voidBlock = ()->Void

typealias Int_Block = (Int) -> Void

typealias MutableArray_Block = (NSMutableArray) -> Void

typealias Any_Block = (AnyObject) -> Void

typealias Array_Block = (Array<Any>) -> Void

typealias String_Block = (String) -> Void

typealias Bool_Block = (Bool) -> Void

typealias Float_Block = (CGFloat) -> Void

typealias Int_Int_Block = (Int,Int) -> Void

typealias Str_Str_Block = (String, String) -> Void

typealias AMapNaviRoute_Block = (AMapNaviRoute?,AMapNaviRoute?)->Void

typealias LongPress_Block = (UILongPressGestureRecognizer) -> Void

typealias Void_Block = () -> Void

typealias Date_Block = (Date) -> Void

typealias Annotation_Block = (MAPointAnnotation)->Void

typealias Int_Str_Block = (Int, String)->Void

let Notification_Name_Net_Connect = "net_disconnect"

let Save_Key_Token = "udosiddfuo"
let Save_IS_Agree = "sdfsdfpwe"

let APP_Platform = "RIDER_SYS"
let APP_Client = "IOS"

let Notification_Home_refresh = "Notification_Home_refresh"
let Notification_Name_Location_Update = "Notification_Name_Location_Update"

let Notification_Name_Receive_Message = "Notification_Name_Receive_Message"

let Notification_Name_Update_Message = "Notification_Name_Update_Message"

let Notification_Name_Net_DisConnect = "Notification_Name_Net_DisConnect"

//骑手已接单
let Notification_Name_Order_Accept = "Notification_Name_Order_Accept"
//骑手已取货
let Notification_Name_Order_Pickup = "Notification_Name_Order_Pickup"
//订单已送达
let Notification_Name_Order_Done = "Notification_Name_Order_Done"
//订单取消
let Notification_Name_Order_Cancel = "Notification_Name_Order_Cancel"
//支付相关
let Notification_Name_Pay_Suceess = "Notification_Name_Pay_Suceess"

//创建补差价订单
let Notification_Name_Patch_Order = "Notification_Name_Patch_Order"
//车辆管理
let Notification_Name_Vehicle_Change = "Notification_Name_Vehicle_Change"
let Screen_Width = UIScreen.main.bounds.size.width
let Screen_Height = UIScreen.main.bounds.size.height

let Notification_Name_User_Info_Changed = "Notification_Name_User_Info_Changed"

let StatusBar_Height = CGFloat(UIApplication.shared.statusBarFrame.size.height)

let TRWidthScale = UIScreen.main.bounds.size.width / 375.0

let TRHeightScale = UIScreen.main.bounds.size.height / 812.0

let APP_Scale =  UIScreen.main.bounds.size.height / 984.0

let IS_IphoneX = UIApplication.shared.statusBarFrame.size.height > 20 ? true : false

let kBottomSafeHeight = (StatusBar_Height > 20 ? 34.0: 0.0)

let APP_Bottom_Safe_Height = IS_IphoneX ? 35 : 0

let Time_Send_Code = 120

let BRAND_NAME = "嘉马"

let PAGE_SIZE = 10
//最大上传图片数量
let IMG_UP_MAX = 4

let Net_Default_Img = UIImage(named: "def_place_img")!
let Net_Default_Head = UIImage(named: "head_def")
let Net_Def_Rider_Head = UIImage(named: "rider_head_def")
extension UIColor {
    
    static func hexColor(hexValue:UInt)->UIColor{
        UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((hexValue & 0xFF00) >> 8) / 255.0, blue: CGFloat(hexValue & 0xFF) / 255.0, alpha: 1)
    }
    
    static func themeColor()->UIColor{
        UIColor.hexColor(hexValue: 0x0FD06A)
    }
    
    static func lightThemeColor()->UIColor{
        UIColor.hexColor(hexValue: 0x0FD06A)
    }
    
    static func bgColor()->UIColor{
        UIColor.hexColor(hexValue: 0xF0F1F2)
    }
    
    static func txtColor()->UIColor{
        UIColor.hexColor(hexValue: 0x333333)
    }
    
    static func lineColor()->UIColor{
        UIColor.hexColor(hexValue: 0xF4F6F8)
    }
    
    static func applyColor()->UIColor {
        .lightThemeColor()
    }
    
}
extension String {
    func getNormalStrH(strFont: UIFont, w: CGFloat) -> CGFloat {
        
        return CGFloat(ceilf(Float(getNormalStrSize(str: self, font: strFont, w: w, h: CGFLOAT_MAX).height)))
    }

    func getNormalStrW( strFont: UIFont, h: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: CGFLOAT_MAX, h: h).width
    }
    
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: UIFont, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: [.usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        return CGSize.zero
    }
    
}
extension UIFont {
    static func alimamaFont(fontSize : CGFloat) ->UIFont {
        UIFont(name: "Alimama ShuHeiTi", size: fontSize)!
    }
}
extension UIView{
    func trCorner(f : CGFloat){
        self.layer.cornerRadius = f
        self.layer.masksToBounds = true
    }
    func trCorner(_ f : CGFloat){
        self.layer.cornerRadius = f
        self.layer.masksToBounds = true
    }
    func viewController() -> UIViewController? {
        guard let window = UIApplication.shared.windows.first else {
            return nil
        }
        var tempView: UIView?
        for subview in window.subviews.reversed() {
            if subview.classForCoder.description() == "UILayoutContainerView" {
                tempView = subview
                break
            }
        }
        
        if tempView == nil {
            tempView = window.subviews.last
        }
        
        var nextResponder = tempView?.next
        var next: Bool {
            return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController
        }
 
        while next{
            tempView = tempView?.subviews.first
            if tempView == nil {
                return nil
            }
            nextResponder = tempView!.next
        }
        return nextResponder as? UIViewController
    }

}
extension UIFont {
    static func trFont(fontSize : CGFloat)->UIFont {
        UIFont.systemFont(ofSize: fontSize)
    }
    static func trBoldFont(fontSize : CGFloat)->UIFont{
        UIFont.boldSystemFont(ofSize: fontSize)
    }

    static func trMiddleFont(fontSize : CGFloat)->UIFont {
        UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    static func trFont(_ fontSize : CGFloat)->UIFont {
        UIFont.systemFont(ofSize: fontSize)
    }
    static func trBoldFont(_ fontSize : CGFloat)->UIFont{
        UIFont.boldSystemFont(ofSize: fontSize)
    }
    static func trMediumFont(_ fontSize : CGFloat)->UIFont{
        UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    static func trMediumFont( fontSize : CGFloat)->UIFont{
        UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
}

class TRTool: NSObject {
    
    static func getAppVersion()->String {
        let bundle = Bundle.main
        guard let info = bundle.infoDictionary else {return ""}
        return info["CFBundleShortVersionString"] as? String ?? ""
    }
    static func getUUID()->String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    static func getMacInfo()->String {
        return TRMacInfo.getMacInfo()
    }
    static func getCurrentWindow() -> UIWindow? {
        // 获取当前的 key window，如果没有 key window，则尝试获取第一个 window
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow
        } else if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = scene.windows.first {
            return window
        }
        return nil
    }
    static func saveData(value : Any?, key : String!){
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    static func getData(key : String!)->Any?{
        return UserDefaults.standard.value(forKey: key)
    }
    static func removeData(key : String!){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    static func richText(str1 : String, font1 : UIFont, color1 : UIColor, str2 : String, font2 : UIFont, color2 : UIColor)->NSMutableAttributedString{
        let dhMutablestring = NSMutableAttributedString()
                    
        let dhStr1 = NSAttributedString(string: str1, attributes: [.font : font1, .foregroundColor : color1])
      
        let dhStr2 = NSAttributedString(string: str2, attributes: [.font : font2, .foregroundColor : color2])
        dhMutablestring.append(dhStr1)
        dhMutablestring.append(dhStr2)
        return dhMutablestring
    }
    
    static func richText3(str1 : String, font1 : UIFont, color1 : UIColor, str2 : String, font2 : UIFont, color2 : UIColor ,str3 : String, font3 : UIFont, color3 : UIColor)->NSMutableAttributedString{
        let dhMutablestring = NSMutableAttributedString()
                    
        let dhStr1 = NSAttributedString(string: str1, attributes: [.font : font1, .foregroundColor : color1])
      
        let dhStr2 = NSAttributedString(string: str2, attributes: [.font : font2, .foregroundColor : color2])
        
        let dhStr3 = NSAttributedString(string: str3, attributes: [.font : font3, .foregroundColor : color3])

        dhMutablestring.append(dhStr1)
        dhMutablestring.append(dhStr2)
        dhMutablestring.append(dhStr3)

        return dhMutablestring
    }
    
    static func isNullOrEmplty(s : String?)->Bool {
        if s == nil {
            return true
        }
        
        if s!.isEmpty{
            return true
        }
        if s!.elementsEqual(""){
            return true
        }
        return false
    }
    
    static func showSuccess(_ msg : String){
        SVProgressHUD.setImageViewSize(.init(width: 28, height: 28))
        SVProgressHUD.showSuccess(withStatus: msg)
    }
    static func showInfo(_ msg : String) {
        SVProgressHUD.setImageViewSize(.zero)
        SVProgressHUD.showInfo(withStatus: msg)
    }
    
    //发送短信
    static func sendMsg(phone : String) {
        let url = URL.init(string: "sms://\(phone)")
        if url == nil {
            SVProgressHUD.showInfo(withStatus: "号码无效")
            return
        }
        UIApplication.shared.open(url!)
    }
    //拨打电话
    static func callPhone(phone : String) {
        let url = URL.init(string: "tel://\(phone)")
        if url == nil {
            SVProgressHUD.showInfo(withStatus: "号码无效")
            return
        }
        UIApplication.shared.open(url!)
    }
    static func numFormatter(_ value : NSNumber)->String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f.string(from: value) ?? ""
    }
    static func callPhone(_ phone : String){

        let phone = "telprompt://" + phone
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.open(URL(string: phone)!, options: [:], completionHandler: nil)
        }
        
    }
    static func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
            let date:Date = Date.init(timeIntervalSince1970: timeInterval)
            let formatter = DateFormatter.init()
            if dateFormat == nil {
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            }else{
                formatter.dateFormat = dateFormat
            }
            return formatter.string(from: date as Date)
    }
    static func longTimeToShowTime(_ longlongTime : Int64)->String{
        let hdate = Date(timeIntervalSince1970: TimeInterval(longlongTime))
        //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:currentLanguage]];

        
        let calendar = Calendar.current
        let hdc = calendar.dateComponents([.day, .month, .year], from: hdate)
        let ndc = calendar.dateComponents([.day, .month, .year], from: Date())
        let df = DateFormatter()
        df.locale = Locale(identifier: Locale.preferredLanguages.first ?? "zh-Hans")
        var isYestoday = false
        if hdc.year != ndc.year {
            df.dateFormat = "yyyy/MM/dd"
        } else {
            if hdc.day == ndc.day {
                df.dateFormat = "HH:mm"
            } else if (ndc.day! - hdc.day!) == 1 {
                isYestoday = true
                df.dateFormat = "昨天 HH:mm"
            } else {
                if ndc.day! - hdc.day! <= 7 {
                    df.dateFormat = "EEEE HH:mm"
                } else {
                    df.dateFormat = "yyyy/MM/dd"
                }
            }
        }
        
        let str = df.string(from: hdate)
        return str
    }
    static func timeChangeToShowTimeStr(_ date : String)->String{
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dataFormatter.date(from: date)!
        let ti = date.timeIntervalSince1970
        
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(ti)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let hdate = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: hdate as Date)
    }
    static func currentLongTime()->CLongLong {
        let date = Date()
        let timeInterval: TimeInterval = date.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
    static func currentTimeStamp()->String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "MMddHHmmss"
        return df.string(from: date) + "\(Int(arc4random()))"
    }
    static func dateToLongTime(date : Date)->CLongLong {
        let timeInterval: TimeInterval = date.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
    static func openPayMiniPro(pars : String){
        let launchMiniProgramReq = WXLaunchMiniProgramReq.object()
        //拉起的小程序ID ，临时
        launchMiniProgramReq.userName = "gh_c1db7bd66d11";
        //（正式，开发，体验）
        launchMiniProgramReq.miniProgramType = .release

        launchMiniProgramReq.path = "/pages/AnzIosPay/pay?parms=\(pars)";
        WXApi.send(launchMiniProgramReq)
    }
    func arrayToJson(_ array : [Any])->[String : Any]{
        if (!JSONSerialization.isValidJSONObject(array)) {
            //print("is not a valid json object")
            return [:]
        }

        let data : Data! = try? JSONSerialization.data(withJSONObject: array, options: [])
        //NSData转换成NSString打印输出
        let str = NSString(data:data, encoding: String.Encoding.utf8.rawValue)
        
        return [:]
    }
    
    static func checkIdentityCardNumber(_ number: String) -> Bool {
            //判断位数
            if number.count != 15 && number.count != 18 {
                return false
            }
            var carid = number
            
            var lSumQT = 0
            
            //加权因子
            let R = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
            
            //校验码
            let sChecker: [Int8] = [49,48,88, 57, 56, 55, 54, 53, 52, 51, 50]
            
            //将15位身份证号转换成18位
            let mString = NSMutableString.init(string: number)
            
            if number.count == 15 {
                mString.insert("19", at: 6)
                var p = 0
                let pid = mString.utf8String
                for i in 0...16 {
                    let t = Int(pid![i])
                    p += (t - 48) * R[i]
                }
                let o = p % 11
                let stringContent = NSString(format: "%c", sChecker[o])
                mString.insert(stringContent as String, at: mString.length)
                carid = mString as String
            }
            
            let cStartIndex = carid.startIndex
            let _ = carid.endIndex
            let index = carid.index(cStartIndex, offsetBy: 2)
            //判断地区码
            let sProvince = String(carid[cStartIndex..<index])
            if (!self.areaCodeAt(sProvince)) {
                return false
            }
            
            //判断年月日是否有效
            //年份
            let yStartIndex = carid.index(cStartIndex, offsetBy: 6)
            let yEndIndex = carid.index(yStartIndex, offsetBy: 4)
            let strYear = Int(carid[yStartIndex..<yEndIndex])
            
            //月份
            let mStartIndex = carid.index(yEndIndex, offsetBy: 0)
            let mEndIndex = carid.index(mStartIndex, offsetBy: 2)
            let strMonth = Int(carid[mStartIndex..<mEndIndex])
            
            //日
            let dStartIndex = carid.index(mEndIndex, offsetBy: 0)
            let dEndIndex = carid.index(dStartIndex, offsetBy: 2)
            let strDay = Int(carid[dStartIndex..<dEndIndex])
            
            let localZone = NSTimeZone.local
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.timeZone = localZone
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let date = dateFormatter.date(from: "\(String(format: "%02d",strYear!))-\(String(format: "%02d",strMonth!))-\(String(format: "%02d",strDay!)) 12:01:01")
            
            if date == nil {
                return false
            }
            let paperId = carid.utf8CString
            //检验长度
            if 18 != carid.count {
                return false
            }
            //校验数字
            func isDigit(c: Int) -> Bool {
                return 0 <= c && c <= 9
            }
            for i in 0...18 {
                let id = Int(paperId[i])
                if isDigit(c: id) && !(88 == id || 120 == id) && 17 == i {
                    return false
                }
            }
            //验证最末的校验码
            for i in 0...16 {
                let v = Int(paperId[i])
                lSumQT += (v - 48) * R[i]
            }
            if sChecker[lSumQT%11] != paperId[17] {
                return false
            }
            return true
        }
        static func areaCodeAt(_ code: String) -> Bool {
            var dic: [String: String] = [:]
            dic["11"] = "北京"
            dic["12"] = "天津"
            dic["13"] = "河北"
            dic["14"] = "山西"
            dic["15"] = "内蒙古"
            dic["21"] = "辽宁"
            dic["22"] = "吉林"
            dic["23"] = "黑龙江"
            dic["31"] = "上海"
            dic["32"] = "江苏"
            dic["33"] = "浙江"
            dic["34"] = "安徽"
            dic["35"] = "福建"
            dic["36"] = "江西"
            dic["37"] = "山东"
            dic["41"] = "河南"
            dic["42"] = "湖北"
            dic["43"] = "湖南"
            dic["44"] = "广东"
            dic["45"] = "广西"
            dic["46"] = "海南"
            dic["50"] = "重庆"
            dic["51"] = "四川"
            dic["52"] = "贵州"
            dic["53"] = "云南"
            dic["54"] = "西藏"
            dic["61"] = "陕西"
            dic["62"] = "甘肃"
            dic["63"] = "青海"
            dic["64"] = "宁夏"
            dic["65"] = "新疆"
            dic["71"] = "台湾"
            dic["81"] = "香港"
            dic["82"] = "澳门"
            dic["91"] = "国外"
            if (dic[code] == nil) {
                return false;
            }
            return true;
        }
    
    static func compressImage(_ image: UIImage, _ maxLength : Int = 200 * 1000) -> Data? {
        var compression: CGFloat = 1
        guard var data = image.jpegData(compressionQuality: compression),
            data.count > maxLength else { return image.jpegData(compressionQuality: 1) }
        
        // Compress by size
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = image.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        var resultImage: UIImage = UIImage(data: data)!
        if data.count < maxLength { return data }
        
        // Compress by size
        var lastDataLength: Int = 0
        while data.count > maxLength, data.count != lastDataLength {
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(maxLength) / CGFloat(data.count)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                    height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = resultImage.jpegData(compressionQuality: compression)!
        }
        return data
    }
}

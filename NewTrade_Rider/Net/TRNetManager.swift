//
//  TRNetManager.swift
//  As
//
//  Created by xph on 2023/12/6.
//

import UIKit
import Alamofire
import HandyJSON
import SVProgressHUD
typealias SuccessBlock = ()->(Any)

class TRNetManager {
    private var manager : Session!
    static let shared = TRNetManager()
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
    
        manager = Session(configuration: config)
    
    }
    //当出现异常时，可以先取消网络请求
    func cancelAllQuery(){
        manager.cancelAllRequests()
    }
    
    func post_no_lodding(url : String, pars : [String : Any]?, successBlock : @escaping(_ dict : [String : Any]?)->()){

        var head = HTTPHeaders()
        head.add(name: "Accept", value: "application/json")
        
        configHeade(head: &head)

        let encoder : ParameterEncoding = JSONEncoding.default
        AF.request(BASIC_URL + url,
                   method: .post,
                   parameters: pars,
                   encoding: encoder,
                   headers: head
                   
                   ).response { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                self.dealCode(oriDic: dic as? [String : AnyObject])
                successBlock(dic as? [String : AnyObject])
            case .failure(_):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
               
        }
    
    }
    
    func get_no_lodding(url : String, pars : [String : Any]?, successBlock : @escaping(_ dict : [String : Any]?)->()){

        
        var head = HTTPHeaders()
        configHeade(head: &head)

        let encoder : ParameterEncoding = URLEncoding.default
        AF.request(BASIC_URL + url,
                   method: .get,
                   parameters: pars,
                   encoding: encoder,
                   headers: head
                   
                   ).response { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                let myDic = dic as? [String : Any]
                
                 self.dealCode(oriDic: myDic)
                successBlock(myDic)
            case .failure(let fail):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
               
        }
    }
    func delete_no_lodding(url : String, pars : [String : Any]?, successBlock : @escaping(_ dict : [String : Any]?)->()){

        
        var head = HTTPHeaders()
        configHeade(head: &head)

        let encoder : ParameterEncoding = URLEncoding.default
        AF.request(BASIC_URL + url,
                   method: .delete,
                   parameters: pars,
                   encoding: encoder,
                   headers: head
                   
                   ).response { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                let myDic = dic as? [String : Any]
                self.dealCode(oriDic: myDic)
                successBlock(myDic)
            case .failure(_):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
               
        }
    }
    func put_no_lodding(url : String, pars : [String : Any]?, successBlock : @escaping(_ dict : [String : Any]?)->()){

        
        var head = HTTPHeaders()
        configHeade(head: &head)

        let encoder : ParameterEncoding = JSONEncoding.default
        AF.request(BASIC_URL + url,
                   method: .put,
                   parameters: pars,
                   encoding: encoder,
                   headers: head
                   
                   ).response { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                let myDic = dic as? [String : Any]
                
                self.dealCode(oriDic: myDic)
                successBlock(myDic)
            case .failure(let fail):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
        }
    }
    func common_no_lodding(url : String,method : HTTPMethod, pars : [String : Any]?, successBlock : @escaping(_ dict : [String : Any]?)->()){

        
        var head = HTTPHeaders()
        configHeade(head: &head)

        let encoder : ParameterEncoding = JSONEncoding.default
        AF.request(BASIC_URL + url,
                   method: method,
                   parameters: pars,
                   encoding: encoder,
                   headers: head
                   
                   ).response { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                let myDic = dic as? [String : Any]
                
                self.dealCode(oriDic: myDic)
                successBlock(myDic)
            case .failure(let fail):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
        }
    }
    
    // 上传类型：头像=logo, 品牌=brand, 店铺照片=store，身份证照片=idCard，许可证=license
    
    public func upload(file: [Data],
                       URLString: String,
                       type : String?,
                       isOrder : Bool = false,
                        respondCallback: @escaping (_ responseObject: [String: Any]?) -> Void)
    {
        
       
        var newUrl = BASIC_URL +  URLString

        //文件类型 logo brand
        if isOrder {
            newUrl = BASIC_URL + URLString + "?tranNo=\(type!)"

        } else if type != nil {
            //为了兼容 多图片 单图片，type和types都传递
            newUrl = BASIC_URL + URLString + "?type=\(type!)&types=\(type!)"
        }
        var headers = HTTPHeaders()
        headers.add(name: "Content-type", value: "multipart/form-data")
        configHeade(head: &headers)
        SVProgressHUD.show()
        AF.upload(multipartFormData: { formData in
            for f in file {
                formData.append(f, withName: "files", fileName: TRTool.currentTimeStamp() + ".jpg",mimeType: "image/jpg/png/jpeg")
            }
           
        }, to: newUrl, headers: headers).uploadProgress { progress in
            
        }
        .responseString(completionHandler: { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let res):
                let dic = try! JSONSerialization.jsonObject(with: res.data(using: .utf8)!, options: .mutableContainers)
                respondCallback(dic as! [String : AnyObject])
            case .failure( _):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                respondCallback(res)
                break
            }
    
        })
    }
    public func upload(file: [Data],
                       _isFiles : Bool = false,
                       _isChat : Bool = false,
                       URLString: String,type : String?,
                        respondCallback: @escaping (_ responseObject: [String: Any]?) -> Void)
    {
        var fileName = "file"
        if _isFiles {
            fileName = "files"
        }
       
        var newUrl = BASIC_URL +  URLString
        var head = HTTPHeaders()
        head.add(name: "Content-type", value: "multipart/form-data")
        //文件类型 logo brand
        if _isChat {
            if type != nil {
                newUrl = BASIC_URL + URLString + "?sessionId=\(type!)"
            }
        } else {
            if type != nil {
                newUrl = BASIC_URL + URLString + "?type=\(type!)"
            }
        }
        
        var headers = HTTPHeaders()
        headers.add(name: "Content-type", value: "multipart/form-data")
        configHeade(head: &headers)
        SVProgressHUD.show()
        AF.upload(multipartFormData: { formData in
            for f in file {
                formData.append(f, withName: fileName, fileName: TRTool.currentTimeStamp() + ".jpg",mimeType: "image/jpg/png/jpeg")
            }
           
        }, to: newUrl, headers: headers).uploadProgress { progress in
            
        }
        .responseString(completionHandler: { response in
            if Thread.isMainThread {
                SVProgressHUD.dismiss()
            } else {
                DispatchQueue.main.sync {
                    SVProgressHUD.dismiss()
                }
            }
            switch response.result {
            case .success(let res):
                let dic = try! JSONSerialization.jsonObject(with: res.data(using: .utf8)!, options: .mutableContainers)
                respondCallback(dic as! [String : AnyObject])
            case .failure( _):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                respondCallback(res)
                break
            }
    
        })
    }
    public func uploadSingle(file: [Data],
                       URLString: String,type : String?,
                        respondCallback: @escaping (_ responseObject: [String: Any]?) -> Void)
    {
        
       
        var newUrl = BASIC_URL +  URLString

        //文件类型 logo brand
        if type != nil {
            newUrl = BASIC_URL + URLString + "?type=\(type!)"
        }
        var headers = HTTPHeaders()
        headers.add(name: "Content-type", value: "multipart/form-data")
        configHeade(head: &headers)
        SVProgressHUD.show()
        AF.upload(multipartFormData: { formData in
            for f in file {
                formData.append(f, withName: "file", fileName: TRTool.currentTimeStamp() + ".jpg",mimeType: "image/jpg/png/jpeg")
            }
           
        }, to: newUrl, headers: headers).uploadProgress { progress in
            
        }
        .responseString(completionHandler: { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let res):
                let dic = try! JSONSerialization.jsonObject(with: res.data(using: .utf8)!, options: .mutableContainers)
                respondCallback(dic as! [String : AnyObject])
            case .failure( _):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                respondCallback(res)
                break
            }
    
        })
    }
    
    // MARK: - 图片上传
    public func common_upload_pic(files: [Data],
                       URLString: String,
                        respondCallback: @escaping (_ responseObject: [String: Any]?) -> Void)
    {
      
        var newUrl = BASIC_UpPic_URL +  URLString
      
        var headers = HTTPHeaders()
        headers.add(name: "Content-type", value: "multipart/form-data")
        configHeade(head: &headers)
        SVProgressHUD.show()
        AF.upload(multipartFormData: { formData in
            for f in files {
                formData.append(f, withName: "files", fileName: TRTool.currentTimeStamp() + ".jpg",mimeType: "image/jpg/png/jpeg")
            }
           
        }, to: newUrl, headers: headers).uploadProgress { progress in
            
        }
        .responseString(completionHandler: { response in
            if Thread.isMainThread {
                SVProgressHUD.dismiss()
            } else {
                DispatchQueue.main.sync {
                    SVProgressHUD.dismiss()
                }
            }
            switch response.result {
            case .success(let res):
                let dic = try! JSONSerialization.jsonObject(with: res.data(using: .utf8)!, options: .mutableContainers)
                respondCallback(dic as! [String : AnyObject])
            case .failure( _):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                respondCallback(res)
                break
            }
        })
    }
    
    // MARK: - 登录相关 不通过网关
    func userAuthService(url : String, method : HTTPMethod = .get,pars : [String : Any]?, successBlock : @escaping(_ dict : [String : Any]?)->()){
        
        
        var head = HTTPHeaders()
        
        var encoder : ParameterEncoding = URLEncoding.default
        if method != .get {
            encoder = JSONEncoding.default
        }
        AF.request(BASIC_Login_URL + url,
                   method: method,
                   parameters: pars,
                   encoding: encoder,
                   headers: head
                   
                   ).response { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                let myDic = dic as? [String : Any]
                                self.dealCode(oriDic: myDic)
                successBlock(myDic)
            case .failure(let fail):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
               
        }
    }
    func userLogoutService(successBlock : @escaping(_ dict : [String : Any]?)->()){
        
        
        var head = HTTPHeaders()
        configHeade(head: &head)


        var encoder : ParameterEncoding = URLEncoding.default
       
        AF.request(BASIC_Login_URL + URL_User_Logout,
                   method: .post,
                   parameters: nil,
                   encoding: encoder,
                   headers: head
                   
                   ).response { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                let myDic = dic as? [String : Any]
                
                successBlock(myDic)
            case .failure(let fail):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
        }
    }
    
    
    // MARK: - 数组类型参数
    func httpRequestWithArratPars(url : String, method : HTTPMethod,pars : [String], successBlock : @escaping(_ dict : [String : Any]?)->()){
        
        
        var head = HTTPHeaders()
        configHeade(head: &head)

        AF.request(BASIC_URL + url,
                   method: method,
                   parameters: pars,
                   encoder : JSONParameterEncoder.default,
                   headers: head
                   ).response { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                let myDic = dic as? [String : Any]
                
                self.dealCode(oriDic: myDic)
                successBlock(myDic)
            case .failure(let fail):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
        }
    }
    
    func httpRequestWithArratPars(url : String, method : HTTPMethod,pars : [[String : String]], successBlock : @escaping(_ dict : [String : Any]?)->()){
        
        
        var head = HTTPHeaders()
        configHeade(head: &head)

        AF.request(BASIC_URL + url,
                   method: method,
                   parameters: pars,
                   encoder : JSONParameterEncoder.default,
                   headers: head
                   ).response { response in
            SVProgressHUD.dismiss()

            switch response.result {
                
            case .success(let success):
                let dic = try! JSONSerialization.jsonObject(with: success!, options: .mutableContainers)
                let myDic = dic as? [String : Any]
                self.dealCode(oriDic: myDic)
                successBlock(myDic)
            case .failure(let fail):
                SVProgressHUD.dismiss()
                let res = ["code" : -1, "exceptionMsg": "服务异常，请稍后重试"]
                successBlock(res)
                break
            }
        }
    }
    
    
    
    private func dealCode(oriDic : [String : Any]?) {
        guard let model = TRCodeModel.deserialize(from: oriDic) else { return }
        if model.exceptionCode == Net_Code_User_Not_Login_1 ||
            model.exceptionCode == Net_Code_User_Not_Login_2 ||
            model.exceptionCode == Net_Code_User_Not_Login_3 ||
            model.exceptionCode == Net_Code_User_Not_Login_4{
                TRTool.saveData(value: "", key: Save_Key_Token)
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let loginController = TRLoginViewController()
                let navController = BasicNavViewController(rootViewController: loginController)
                delegate.window?.rootViewController = navController;
        }
        
    }
    
    private func configHeade(head : inout HTTPHeaders) {
        let a_token = TRTool.getData(key: Save_Key_Token) as! String
        head.add(name: "Authorization", value: a_token)
        head.add(name: "App-Version", value: TRTool.getAppVersion())
    }
    
}

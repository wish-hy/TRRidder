//
//  TRWebViewController.swift
//  NewTrade_Seller
//
//  Created by xph on 2024/1/31.
//

import UIKit
import WebKit

/*
 http://192.168.1.5:8080/gamma-h5/pages/DisH5Item/rider/page/carlist/index
 */
let Web_Txt_Name = "code=RIDER_SYS&type=RS_"

let JS_GO_BACK = "goBack"
let JS_GET_TOKEN = "getToken"
enum webViewType {
    case txt_user_xieyi
    case txt_margin
    case txt_privacy
    case txt_about
    case txt_service
    case txt_disclaimer
    
    case traffic_manage
    
    case rider_wallet
    case rider_history_order
    case rider_order_comment
    case rider_order_rules
    case rider_statics

}

class TRWebViewController: UIViewController , WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler{
    let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())

    var type : webViewType = .txt_about
    var txt_user_xieyi_url = Web_Basic_URL + "/common/pageText/index?" + Web_Txt_Name + "USERXIEYI"
    var txt_privacy_url : String = Web_Basic_URL + "/common/pageText/index?" + Web_Txt_Name + "YINSHIZEC"
    var txt_about_url : String = Web_Basic_URL + "/common/pageText/index?" +  Web_Txt_Name + "ABOUT_US"
    var txt_disclaimer_url : String = Web_Basic_URL +  "/common/pageText/index?" + Web_Txt_Name + "DISCLAIMER"
    var txt_service_url : String = Web_Basic_URL + "/common/pageText/index?" + Web_Txt_Name + "FUWUTK"
    var txt_margin_url : String = Web_Basic_URL + "/common/pageText/index?" + Web_Txt_Name + "MARGINFUWU"
    
    var rider_manage_url = Web_Basic_URL + "/rider/page/carlist/index"
    
    
    var rider_wallet = Web_Basic_URL + "/rider/page/wallet/index"
    var rider_history_order = Web_Basic_URL + "/rider/page/pastOder/index"
    var rider_order_comment = Web_Basic_URL + "/rider/page/evaluate/index"
    var rider_order_rules = Web_Basic_URL + "/rider/page/rules/index"
    let rider_statics = Web_Basic_URL + "/rider/page/collect/index"
    private var surl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        switch type {
        case .txt_privacy:
            surl = txt_privacy_url
        case .txt_about:
            surl = txt_about_url
        case .txt_service:
            surl = txt_service_url
        case .txt_disclaimer:
            surl = txt_disclaimer_url
        case .traffic_manage:
            surl = rider_manage_url
        case .rider_wallet:
            surl = rider_wallet
        case .rider_history_order:
            surl = rider_history_order

        case .rider_order_comment:
            surl = rider_order_comment

        case .rider_order_rules:
            surl = rider_order_rules

        case .txt_user_xieyi:
            surl = txt_user_xieyi_url
        case .txt_margin:
            surl = txt_margin_url
        case .rider_statics:
            surl = rider_statics
        }
        view.backgroundColor = .white
        let config = WKWebViewConfiguration()
        let js = String.init(format: "localStorage.setItem('mall_token', '%@')", "token")
        let script = WKUserScript(source: js, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        webView.frame = self.view.bounds
        
        webView.allowsBackForwardNavigationGestures = true
//        webView.configuration = config
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        let urlrequest = URL.init(string: surl)!
        let urlRequest = URLRequest.init(url: urlrequest)
        webView.load(urlRequest)
//            [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:"Loction"];
        webView.configuration.userContentController.add(self, name: JS_GO_BACK)
        webView.configuration.userContentController.add(self, name: JS_GET_TOKEN)

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    deinit {
        webView.configuration.userContentController.removeScriptMessageHandler(forName: JS_GO_BACK)
        webView.configuration.userContentController.removeScriptMessageHandler(forName: JS_GET_TOKEN)

    }

    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
        
//        webView.evaluateJavaScript("EQINFOFUN('\(13132)')") { _, e in
//            print(e)
//        }
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.showInfo(withStatus: "加载失败")
        self.navigationController?.popViewController(animated: true)
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name.elementsEqual(JS_GO_BACK) {
            self.navigationController?.popViewController(animated: true)
        } else if message.name.elementsEqual(JS_GET_TOKEN) {
            var Token = TRTool.getData(key: Save_Key_Token) as? String
            if TRTool.isNullOrEmplty(s: Token) {
                Token = "iostoken"
            }
           //  NSString *jsStr = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
            let jsStr = String.init(format: "EQINFOFUN('%@','%@','%@','%@','%@','%@')", "IOS","\(Token!)","9102912","\(StatusBar_Height)" , "\(APP_Bottom_Safe_Height)",APP_Platform)
            webView.evaluateJavaScript(jsStr) { _, e in
                
            }
        }
//        let Token = TRTool.getData(key: Save_Key_Token) as! String

    }
    





}

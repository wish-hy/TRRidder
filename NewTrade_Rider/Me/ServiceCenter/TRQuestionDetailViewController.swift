//
//  TRQuestionDetailViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import WebKit

class TRQuestionDetailViewController: BasicViewController, WKNavigationDelegate, WKUIDelegate {
    var item : TRQuestionModel!
    
    var webView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavBar()
        configNavTitle(title: "详情")
        configNavLeftBtn()
        
        self.view.backgroundColor = .white
        webView = WKWebView()

        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(15)
            make.top.equalTo(self.view).inset(Nav_Height + 15)
            make.bottom.equalTo(self.view).inset(10)
        }
        configNetData()
        
    }
    private func configNetData(){
        TRNetManager.shared.get_no_lodding(url: URL_Service_qus_detail, pars: ["id":item.id]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRQuestionDetail.deserialize(from: dict) else {return}
            if model.code == 1 {
                item = model.data
                let mainPath  = Bundle.main.bundlePath + "/WebDetail/index.html"
                let url = URL(fileURLWithPath: mainPath)
                let str = try! String(contentsOf: url, encoding: .utf8)
                webView.loadHTMLString(str, baseURL: url)
            }
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let json = ["title":"aaa","detail": item.answer]
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let jsonStr = String(data: data, encoding: .utf8)
        let js = String.init(format: "getData(%@)", jsonStr!)
        webView.evaluateJavaScript(js) { a , e  in
            
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

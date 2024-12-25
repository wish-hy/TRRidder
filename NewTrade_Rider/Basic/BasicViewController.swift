//
//  BasicViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/3.
//

import UIKit
import RxSwift
import RxCocoa

class BasicViewController: UIViewController, UIGestureRecognizerDelegate {
    var Nav_Height = 0.0
    var NAV_BAR_H = 0.0
    var disposeBag = DisposeBag()
    var navBar : TRNavgationBar?
    
    var page : Int = 1
    var refresh : AndroidRefresh?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        if self.navigationController != nil {
            Nav_Height = self.navigationController!.navigationBar.frame.height + StatusBar_Height
            NAV_BAR_H = self.navigationController!.navigationBar.frame.height

        }

        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.view.backgroundColor = UIColor.bgColor()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.isHidden = true
    }

    //防止push卡
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.navigationController?.viewControllers.first == self {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    public func configNavBar(){
        navBar = TRNavgationBar()
        view.addSubview(navBar!)
        navBar!.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(0)
            make.height.equalTo(Nav_Height)
        }
    }
    @objc func popBack(){
        view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    func configNavLeftBtn()->UIButton{
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        self.navBar?.leftView = backBtn
        backBtn.rx.tap.subscribe(onNext: {[weak self] in
            self?.view?.endEditing(true)
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        return backBtn
    }
    func configNavTitle(title : String) {
        let titleLab = UILabel()
        titleLab.text = title
        titleLab.font = UIFont.trMediumFont(fontSize: 18)
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        self.navBar?.titleLab = titleLab
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let arr = self.navigationController?.viewControllers
        if arr != nil {
            let x = arr!.count
            if x > 1 {
                self.navigationController!.interactivePopGestureRecognizer?.delegate = self
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            } else {
                self.navigationController!.interactivePopGestureRecognizer?.delegate = nil
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false


            }
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        let arr = self.navigationController?.viewControllers
//        if arr != nil {
//            let x = arr!.count
//            if x <= 1 {
//                self.navigationController!.interactivePopGestureRecognizer?.delegate = nil
//
//            }
//        }
//    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}

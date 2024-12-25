//
//  TRRiderApplyStateViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/25.
//

import UIKit
import SVProgressHUD

class TRRiderApplyStateViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var model : TRApplerRiderContainer!
    var tableView : UITableView!
    
    var bottomView : TRBottomButton1View!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController!.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        navBar?.backgroundColor = .white
        configNavTitle(title: "骑手申请状态")
        let btn = configNavLeftBtn()
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRRAStateHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRRARiderInfoCell.self, forCellReuseIdentifier: "info")
        tableView.register(TRRARIderResonCell.self, forCellReuseIdentifier: "reson")

        self.view.addSubview(tableView)
        
        bottomView = TRBottomButton1View(frame: .zero)

        
        bottomView.saveBtn.backgroundColor = .lightThemeColor()
        self.view.addSubview(bottomView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.bottom.equalTo(bottomView.snp.top)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        bottomView.saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            guard let self = self else { return }
          
            configData()
        })
        tableView.mj_header?.state = .refreshing
        configData()
//        reloadBottomData()
    }
    @objc func backAction(){
        if self.navigationController!.viewControllers.count == 1 {
            TRTool.saveData(value: "", key: Save_Key_Token)
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let loginController = TRLoginViewController()
            let navController = BasicNavViewController(rootViewController: loginController)
            delegate.window?.rootViewController = navController;
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let state = model.riderInfo.curAuthStatus
        if state.elementsEqual("TRAINED") {
            let mainVC = TRRiderTrainViewController()
            mainVC.model = model
            self.navigationController?.pushViewController(mainVC, animated: false)
        } else if state.elementsEqual("UNSIGNED"){
            let mainVC = TRRiderTrainViewController()
            mainVC.model = model
            self.navigationController?.pushViewController(mainVC, animated: false)
        } else if state.elementsEqual("UNTRAINED") {
            let mainVC = TRRiderTrainViewController()
            mainVC.model = model

            self.navigationController?.pushViewController(mainVC, animated: false)
        }
    }
    private func reloadBottomData(){
        if model.riderInfo.curAuthStatus.elementsEqual("REJECTED") {
            bottomView.saveBtn.setTitle("前往修改", for: .normal)
        } else if  model.riderInfo.curAuthStatus.elementsEqual("UNAUDITED") {
            bottomView.saveBtn.setTitle("正在审核", for: .normal)
        } else if  model.riderInfo.curAuthStatus.elementsEqual("UNSIGNED") {
            //签约暂时不做
            bottomView.saveBtn.setTitle("审核通过，去训练", for: .normal)
        } else if  model.riderInfo.curAuthStatus.elementsEqual("UNTRAINED") {
            bottomView.saveBtn.setTitle("审核通过，去训练", for: .normal)
        } else if  model.riderInfo.curAuthStatus.elementsEqual("TRAINED") {
            bottomView.saveBtn.setTitle("训练通过，去开工", for: .normal)
        }
    }
    private func configData(){
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Apply_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {
                tableView.mj_header?.endRefreshing()
                return}
            tableView.mj_header?.endRefreshing()

            if codeModel.code == 1 {
                guard let smodel = TRApplerRiderManange.deserialize(from: dict) else {return}
                let riderMode = smodel.data
                riderMode.dealNetModel()
                //审核中
                model = riderMode
                reloadBottomData()
                tableView.reloadData()
                
            }
        }
    }
    @objc func saveAction(){
        if model.riderInfo.curAuthStatus.elementsEqual("REJECTED") {
            if self.navigationController != nil {
                for vc in self.navigationController!.viewControllers {
                    if vc.isKind(of: TRAddRiderVViewController.self) {
                        let vc = vc as! TRAddRiderVViewController
                        vc.toFirst()
                    }
                }
            }

            self.navigationController?.popViewController(animated: true)
        } else if  model.riderInfo.curAuthStatus.elementsEqual("UNAUDITED") {
            SVProgressHUD.showInfo(withStatus: "资料正在审核中")
            //            self.navigationController?.popViewController(animated: true)
            
        } else if  model.riderInfo.curAuthStatus.elementsEqual("UNSIGNED") {
            //签约暂时不做
            let vc = TRRiderTrainViewController()
            vc.model = model
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc , animated: true)
        } else if  model.riderInfo.curAuthStatus.elementsEqual("UNTRAINED") {
            let vc = TRRiderTrainViewController()
            vc.model = model
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc , animated: true)
        } else if model.riderInfo.curAuthStatus.elementsEqual("TRAINED") {
            //此通知是为了重新获取骑手信息
            NotificationCenter.default.post(name: .init("loginSuccess"), object: nil)
            let beginVC = TRHomeBeginVC()
            let navVC = BasicNavViewController(rootViewController: beginVC)
            UIApplication.shared.keyWindow?.rootViewController = navVC
        }
        
      
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRRAStateHeader
        header.model = model
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.riderInfo.curAuthStatus.elementsEqual("REJECTED") ? 2 : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as!  TRRARiderInfoCell
            cell.model = model
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reson", for: indexPath) as! TRRARIderResonCell
        cell.resonLab.text = model.riderInfo.authContext
        
        return cell
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

//
//  TRRiderTrainViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/26.
//

import UIKit

class TRRiderTrainViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    var bottomView : TRBottomButton1View!
    var model : TRApplerRiderContainer!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController!.interactivePopGestureRecognizer?.delegate = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        configNavBar()
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        self.navBar?.leftView = backBtn
        backBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else { return }
//            self?.navigationController?.popViewController(animated: true)
            //退出登录
            TRTool.saveData(value: "", key: Save_Key_Token)
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let loginController = TRLoginViewController()
            let navController = BasicNavViewController(rootViewController: loginController)
            delegate.window?.rootViewController = navController;
            
        }).disposed(by: disposeBag)
        
        
        
        configNavTitle(title: "骑手培训")
        navBar?.titleLab?.textColor = .white
//        let backBtn = configNavLeftBtn()
//        backBtn.setImage(UIImage(named: "nav_back_white"), for: .normal)
       
    }
    
    private func setupMainView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRRiderTrainHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRRiderTrainContentCell.self, forCellReuseIdentifier: "content")
        tableView.register(TRRiderTrainReasonCell.self, forCellReuseIdentifier: "reason")

        bottomView = TRBottomButton1View(frame: .zero)
        bottomView.saveBtn.setTitle("前往接单", for: .normal)
        bottomView.saveBtn.addTarget(self, action: #selector(toMainVC), for: .touchUpInside)
        self.view.addSubview(bottomView)
        tableView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.bottom.equalTo(bottomView.snp.top)
        }
        

        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            guard let self = self else { return }
            configNetData()
        })

        reloadBottomData()
    }
    private func configNetData(){
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Info, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {
                tableView.mj_header?.endRefreshing()
                return}
            tableView.mj_header?.endRefreshing()

            if codeModel.code == 1 {
                guard let smodel = TRApplerRiderManange.deserialize(from: dict) else {return}
                let riderMode = smodel.data
                //审核中
                model = riderMode
                
                reloadBottomData()
                tableView.reloadData()
                
            }
        }
    }
    private func reloadBottomData(){
        if model.riderInfo.curAuthStatus.elementsEqual("TRAINED") {
            bottomView.isHidden = false
        } else {
            bottomView.isHidden = true
        }
    }
    @objc func toMainVC(){
//        let vc = TRTabBarViewController()
//        UIApplication.shared.keyWindow?.rootViewController = vc
        //此通知是为了重新获取骑手信息
        NotificationCenter.default.post(name: .init("loginSuccess"), object: nil)
        let beginVC = TRHomeBeginVC()
        let navVC = BasicNavViewController(rootViewController: beginVC)
        UIApplication.shared.keyWindow?.rootViewController = navVC
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRRiderTrainHeader
        if model.riderInfo.curAuthStatus.elementsEqual("TRAINED") {
            header.lab.text = "非常棒！你已完成骑手培训，成为一名合格的骑手，接单工作中请注意安全。"
        } else {
            header.lab.text = "请等待管理员安排进行骑手岗位相关培训，培训期间不会收取任何培训费。"
        }
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
        return model.riderInfo.trainingResult.isEmpty ? 1 : 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as! TRRiderTrainContentCell
            cell.model = model
            return cell
        }
        //培训不通过好像不存在
        let cell = tableView.dequeueReusableCell(withIdentifier: "reason", for: indexPath) as! TRRiderTrainReasonCell
        if model.riderInfo.curAuthStatus.elementsEqual("TRAINED") {
            cell.titleLab.text = "培训不通过原因："
        } else {
            cell.titleLab.text = "培训已通过："
        }
        cell.resonLab.text = model.riderInfo.trainingResult
        return cell
    }
}

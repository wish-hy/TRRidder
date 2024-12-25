//
//  TRRiderApplyRecordDetailVC.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit

class TRRiderApplyRecordDetailVC: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var recordModel : TRRiderApplyRecordModel!

    var model : TRApplerRiderContainer = TRApplerRiderContainer()
    
    private var riderCerModel : TRApplerUserInfoModel = TRApplerUserInfoModel()
    var tableView : UITableView!
    var topView : TRRiderApplyRecordDetailHeader!
    var bottomView : TRBottomButton1View!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController!.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
  
        
        topView = TRRiderApplyRecordDetailHeader(frame: .zero)
        topView.model = recordModel
        self.view.addSubview(topView)
        
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TRRAStateHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRRARiderInfoCell.self, forCellReuseIdentifier: "info")
        tableView.register(TRRiderApplyRecordDetailResonCell.self, forCellReuseIdentifier: "reson")
        tableView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(tableView)
        
        configNavBar()
        configNavTitle(title: "申请记录详情")
        configNavLeftBtn()
        
        bottomView = TRBottomButton1View(frame: .zero)
        
        
        bottomView.saveBtn.backgroundColor = .lightThemeColor()
        self.view.addSubview(bottomView)
        reloadBottomData()
        topView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(StatusBar_Height + 165)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(0)
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
        tableView.mj_header?.state = .idle
        configData()
//        reloadBottomData()
    }

//
    private func reloadBottomData(){
        bottomView.saveBtn.isHidden = true
//        if recordModel.authStatus.elementsEqual("REJECTED") {
//            bottomView.saveBtn.setTitle("前往修改", for: .normal)
//        } else {
//            bottomView.saveBtn.isHidden = true
//        }
    }
    private func configData(){
        TRNetManager.shared.get_no_lodding(url: URL_Rider_Apply_Record_Detail, pars: ["id":recordModel.id]) {[weak self] dict in
            guard let self = self else {return}
            guard let detailModel = TRRiderApplyRecordContainer.deserialize(from: dict) else {
                tableView.mj_header?.endRefreshing()
                return}
            tableView.mj_header?.endRefreshing()

            if detailModel.code == 1 {
                recordModel = detailModel.data
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
//            for vc in self.navigationController?.viewControllers {
//
//            }
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
        }
        
      
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return StatusBar_Height + 165
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRRAStateHeader
//        header.model = model
        return nil
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
        return model.riderInfo.curAuthStatus.elementsEqual("REJECTED") ? 1 : 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as!  TRRARiderInfoCell
            cell.stateImgV.isHidden = true
            cell.recordModel = recordModel
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reson", for: indexPath) as! TRRiderApplyRecordDetailResonCell
        cell.recordModel = recordModel

        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
        }
        topView.frame = .init(x: 0, y: -scrollView.contentOffset.y, width: topView.frame.width, height: topView.frame.height)
        
    }
}

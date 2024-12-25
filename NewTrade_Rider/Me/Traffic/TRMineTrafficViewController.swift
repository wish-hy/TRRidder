//
//  TRMineTrafficViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRMineTrafficViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {
    
    //注意取值
    var data : [TRApplerVehicleInfoModel] = []
    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configNav()
 
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRMineTrafficTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(self.Nav_Height)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            guard let self = self else { return }
            page = 0
            data.removeAll()
            configNetData()
        })

        configNetData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(configNetData), name: .init(Notification_Name_Vehicle_Change), object: nil)
    }

    @objc private func configNetData(){

        let subPars : [String : Any] = [
            :
        ]
        let pars = [
            "current" : page,
            "size" : 360,
            "param" : [:]
        ] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Traffic_List, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRTrafficManage.deserialize(from: dict) else {
                tableView.mj_header?.endRefreshing()
                return}
            if model.code == Net_Code_Success {
                data = model.data.records
                tableView.reloadData()
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
            tableView.mj_header?.endRefreshing()

        }
    }
    private func configNav(){
        configNavBar()
        configNavTitle(title: "车辆管理")
        configNavLeftBtn()
        
        let rightBtn = TRRightButton(frame: CGRect(x: 0, y: 0, width: 115, height: 35))
        rightBtn.imgV.image = UIImage(named: "add_green")
        rightBtn.lab.text = "添加车辆"
        rightBtn.lab.font = UIFont.trFont(fontSize: 15)
        rightBtn.lab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        rightBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        navBar?.rightView = rightBtn
    }
    @objc func addAction(){
        let vc = TRRidderVehicleEditViewController()
        vc.serviceCode = ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc , animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRMineTrafficTableViewCell
        let trafficModel = data[indexPath.row]
        cell.trafficModel = trafficModel
        cell.editBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self  else { return }
            let vc = TRRidderVehicleEditViewController()
            vc.serviceCode = ""
            vc.vehicleInfo = trafficModel
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(vc , animated: true)
        }).disposed(by: cell.bag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return data.count
    }

}

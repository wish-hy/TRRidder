//
//  TRRiderApplyRecordVC.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit

class TRRiderApplyRecordVC: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    
    var models : [TRRiderApplyRecordModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "申请记录")
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRRiderApplyRecordCel.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
        }
        
        configNetData()
    }
    
    private func configNetData(){
        TRNetManager.shared.post_no_lodding(url: URL_Rider_Apply_List, pars: ["size":"50"]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRRiderApplyRecordManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                models = model.data.records
                tableView.reloadData()
            }
        }
    }

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        let vc = TRRiderApplyRecordDetailVC()
        vc.recordModel = model
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc , animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRRiderApplyRecordCel
        let model = models[indexPath.row]
        cell.model = model
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

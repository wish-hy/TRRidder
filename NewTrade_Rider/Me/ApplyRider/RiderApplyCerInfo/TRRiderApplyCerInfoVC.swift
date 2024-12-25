//
//  TRRiderApplyCerInfoVC.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/23.
//

import UIKit

class TRRiderApplyCerInfoVC: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    var bottomView : TRBottomButton1View!

    private var model : TRApplerUserInfoModel = TRApplerUserInfoModel()
    private var items = ["姓名","性别","民族","出生日期","住址","身份证号码","证件有效期"]
    
    var isLoading : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "证件信息")
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRRiderApplyCerInfoBasicCell.self, forCellReuseIdentifier: "basicCell")
        tableView.register(TRRiderApplyCerInfoCardCell.self, forCellReuseIdentifier: "cardCell")
        
        tableView.register(TRTableViewCornerFooter.self, forHeaderFooterViewReuseIdentifier: "footer")
        self.view.addSubview(tableView)
        
        
        bottomView = TRBottomButton1View(frame: .zero)
        bottomView.saveBtn.setTitle("修改证件信息", for: .normal)
        bottomView.saveBtn.addTarget(self, action: #selector(modifyInfo), for: .touchUpInside)
        bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top)
            make.left.right.equalTo(self.view).inset(0)
            make.top.equalTo(self.view).offset(Nav_Height)
            
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
        configRiderCerInfo()
        
    }
    private func configRiderCerInfo(){
        
        TRNetManager.shared.get_no_lodding(url: URL_Rider_CerInfo, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let manageModel = TRRiderCerInfoManage.deserialize(from: dict) else {return}
            if manageModel.code == 1 {
                self.model = manageModel.data
                tableView.reloadData()
            } else {
                SVProgressHUD.showInfo(withStatus: manageModel.exceptionMsg)
            }
            
        }
    }
    
    @objc func modifyInfo(){
        if model.id.isEmpty {
            SVProgressHUD.showInfo(withStatus: "正在加载中...")
            return
        }
        let vc = TRRiderApplyCerInfoEditVC()
        vc.cerModel = self.model
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
            return footer
        }
        return nil
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! TRRiderApplyCerInfoCardCell
            cell.model = model
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath) as! TRRiderApplyCerInfoBasicCell
            let item = items[indexPath.row]
            cell.itemLab.text = item
            //private var items = ["姓名","性别","民族","出生日期","住址","身份证号码","证件有效期"]
            if item.elementsEqual("姓名") {
                cell.valueLab.text = model.realName
            } else if item.elementsEqual("性别") {
                cell.valueLab.text = model.sex ?? false ? "男" : "女"
            } else if item.elementsEqual("民族") {
                cell.valueLab.text = model.nation
            } else if item.elementsEqual("出生日期") {
                cell.valueLab.text = model.birthday
            } else if item.elementsEqual("住址") {
                cell.valueLab.text = model.idDetailsAddress
            } else if item.elementsEqual("身份证号码") {
                cell.valueLab.text = model.idCard
            } else if item.elementsEqual("证件有效期") {
                cell.valueLab.text = model.validBeginTime + "~" + model.validEndTime
            }
            
            
            return cell
        }
       
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! TRRiderApplyCerInfoCardCell
        
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

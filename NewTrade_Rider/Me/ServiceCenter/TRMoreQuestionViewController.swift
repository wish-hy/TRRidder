//
//  TRMoreQuestionViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRMoreQuestionViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource  {

    let titles = ["如何创建项目","如何邀请项目成员","如何安装项目设备","物联网卡如何续费"]
    var tableView : UITableView!
    
    var questionList : [TRQuestionModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        configNavTitle(title: "更多问题")
        configNavLeftBtn()
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRServiceTableViewCell.self, forCellReuseIdentifier: "cell")

        
        self.view.addSubview(tableView)
        

        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.bottom.equalTo(self.view)
        }
        commenQuestion()
  
    }
    private func commenQuestion(){
        let subPars : [String:String] = [:]
        let pars = [
            "current" : page,
            "param" : subPars,
            "size" : 3
        ] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Service_Question_list, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRQuestionManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                questionList = model.data.records
                tableView.reloadData()
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let item = questionList[indexPath.row]
            let vc = TRQuestionDetailViewController()
            vc.item = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 55

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return questionList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRServiceTableViewCell
        let m = questionList[indexPath.row]
        cell.titleLab.text = m.problem
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

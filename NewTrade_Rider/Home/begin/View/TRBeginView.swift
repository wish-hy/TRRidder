//
//  TRBeginView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit

class TRBeginView: UIView ,UITableViewDataSource,UITableViewDelegate{
    
    weak var vc : TRHomeViewController?
    var tableView : UITableView!
    var block : Int_Block?
    var model : TRRiderStaticsModel = TRRiderStaticsModel()
    var ads : [TRADModel] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.register(TRHomeBeginTableViewCell1.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRHomeBeginTableViewCell2.self, forCellReuseIdentifier: "cell2")
        tableView.register(TRHomeBeginTableViewCell4.self, forCellReuseIdentifier: "cell4")


        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        configAd()
    }
   
    private func configAd(){
        let subPars : [String : String] = [:]
        let pars = [
            "current" : 1,
            "param" : subPars,
            "size" : 2
        ] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Home_AD, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRADManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                ads = model.data.records
                tableView.reloadData()
            }
        }
        
        

    }
    private func beginAction(){
        TRNetManager.shared.put_no_lodding(url: URL_Home_State_Changed, pars: ["workStatus" : "ONLINE"]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                if block != nil {
                    block!(100)
                }
                self.removeFromSuperview()

            }else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return ads.count
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .bgColor()
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRHomeBeginTableViewCell1
            cell.model = model
            return cell
        } else if indexPath.section == 1{

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRHomeBeginTableViewCell2
            cell.model = ads[indexPath.row]
                return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! TRHomeBeginTableViewCell4
        cell.block = {[weak self] (num) in
            guard let self  = self  else { return  }
            if num == 1 {
                //设置
                self.vc?.openSetView()
            } else if num == 2 {
                //开工
                beginAction()

            }
        }

        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

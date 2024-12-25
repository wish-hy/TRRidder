//
//  TRBondViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRBondViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "接单保证金"
        configNavLeftBtn()
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        tableView.register(TRBondWithDrawTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRBondAgreementTableViewCell.self, forCellReuseIdentifier: "cell2")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(self.Nav_Height)
        }
        
        let bottomView = TRMineSetBottomView(frame: .zero)
        bottomView.tipLab.isHidden = false
        bottomView.btn.setTitle("确定", for: .normal)
        bottomView.btn.setTitleColor(.white, for: .normal)
        bottomView.btn.backgroundColor = UIColor.hexColor(hexValue: 0x13D066)
        bottomView.btn.layer.cornerRadius = 23
        bottomView.btn.layer.masksToBounds = true
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(56 + 35 + 15)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 132
        } else if indexPath.section == 1 {
            return 400
        }
        return 69
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRBondWithDrawTableViewCell
            cell.actionBtn.isHidden = false
            return cell
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRBondAgreementTableViewCell
            
            return cell
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 4
        }
        return 0
    }

}

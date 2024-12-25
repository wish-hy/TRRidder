//
//  TRChatSetViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit
import RxCocoa
import RxSwift
class TRChatSetViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tableView : UITableView!
    
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "消息通知设置")
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRChatAutoSendTableViewCell.self, forCellReuseIdentifier: "cell1")

        tableView.register(TRMineSetTableViewCell.self, forCellReuseIdentifier: "cell2")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(self.Nav_Height)
        }
        
 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }
        return 52
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        }
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRChatAutoSendTableViewCell
            cell.actionBtn.rx.tap.subscribe(onNext: {[weak self] in
                let view = TRChatSetBottomView(frame: .zero)
                view.contentHeight = 260
                view.addToWindow()
                view.openView()
            }).disposed(by: bag)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRMineSetTableViewCell
        cell.titleLab.font = UIFont.trBoldFont(fontSize: 16)
        cell.desLab.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
 

}

//
//  TRRiderStateDutyView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderStateDutyView: UIView , UITableViewDelegate, UITableViewDataSource{
    var sections : [String] = ["上岗信息"]
    var items : [String] = ["骑手编号","骑手在岗","配送订单"]
    var tableView : UITableView!
    var riderModel = TRRiderUserModel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRRiderReviewSimpleCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TRRiderReViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRRiderReViewHeader
        let item = sections[section]
        header.titleLab.text = item
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRRiderReviewSimpleCell
        let item = items[indexPath.row]
        cell.itemLab.text = items[indexPath.row]
        if item.elementsEqual("骑手编号"){
            cell.valueLab.text = riderModel.no
        } else if item.elementsEqual("骑手在岗"){
            cell.valueLab.text = riderModel.totalDay + "天"
        } else if item.elementsEqual("配送订单"){
            cell.valueLab.text = riderModel.totalOrder + "单"
        }
        
        if item.elementsEqual("配送订单"){
            cell.cornderType = 2
        } else {
            cell.cornderType = 0
        }
        return cell
        

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

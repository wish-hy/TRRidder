//
//  TRRiderStateTrainView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderStateTrainView: UIView , UITableViewDelegate, UITableViewDataSource{
    var sections : [String] = ["培训内容","培训结果"]
    var items : [String] = ["骑行安全","软件操作","礼貌用语","其他相关"]
    var tableView : UITableView!
    var selIndexs : [Int] = []
    
    
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
        tableView.register(TRRiderStateTrainCell.self, forCellReuseIdentifier: "train")
        tableView.register(TRLimitInputCell.self, forCellReuseIdentifier: "input")
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if selIndexs.contains(indexPath.row){
                selIndexs.remove(at: selIndexs.firstIndex(of: indexPath.row)!)
            } else {
                selIndexs.append(indexPath.row)
            }
            tableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? items.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "input", for: indexPath) as! TRLimitInputCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "train", for: indexPath) as! TRRiderStateTrainCell
        let item = items[indexPath.row]
        cell.itemLab.text = item
        if selIndexs.contains(indexPath.row){
            cell.imgV.image = UIImage(named: "check_circle_point")
        } else {
            cell.imgV.image = UIImage(named: "uncheck_circle")

        }
        
        if indexPath.row == items.count - 1 {
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

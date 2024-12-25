//
//  TRDoneDetailView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit

class TRDoneDetailView: UIView ,UITableViewDataSource,UITableViewDelegate{

    
    
    weak var vc : TRDoneDetailViewController!
    var tableView : UITableView!
    let orderInfo = ["订单类型", "订单重量", "订单编号", "配送方式", "备注", "发票信息", "支付方式", "下单时间"]
    var payInfo = [" 送建材 ", " 约50kg ", "886455036687", "专员配送", "无备注信息", "-", "在线支付", "2023-07-05 12:30:59"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.register(TRDoneDetailTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRTaskDetailTableViewCell2.self, forCellReuseIdentifier: "cell2")
        tableView.register(TRTaskDetailTableViewCell3.self, forCellReuseIdentifier: "cell3")
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TRTaskDetailTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return orderInfo.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRTaskDetailTableViewHeader
        if section == 1 {
            header.nameLab.text = "商品清单"
            header.numLab.isHidden = false
            header.priceLab.isHidden = false
            header.unitLab.isHidden = false

            return header
        } else if section == 2 {
            header.nameLab.text = "订单信息"
            header.numLab.isHidden = true
            header.priceLab.isHidden = true
            header.unitLab.isHidden = true
            return header
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 {
            return 60
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .bgColor()
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRDoneDetailTableViewCell
            return cell
           
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)  as! TRTaskDetailTableViewCell2
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! TRTaskDetailTableViewCell3
            if indexPath.row == 0 {
                cell.type = 1
                
                
            } else if indexPath.row == 1 {
                cell.type = 2
                
            } else {
                cell.type = 0
            }
            cell.nameLab.text = orderInfo[indexPath.row]
            cell.detailLab.text = payInfo[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

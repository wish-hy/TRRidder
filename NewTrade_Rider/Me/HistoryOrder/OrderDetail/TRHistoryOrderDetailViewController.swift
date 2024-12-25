//
//  TRHistoryOrderDetailViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRHistoryOrderDetailViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {

    let orderInfo = ["订单类型", "订单重量", "订单编号", "配送方式","配送车辆","取件时间","送达时间", "备注", "发票信息", "支付方式", "下单时间"]
    var payInfo = [" 送建材 ", " 约50kg ", "886455036687", "专员配送","电单车（深A·123456）","2023-07-17 08:23:59","2023-07-17 10:57:20", "无备注信息", "-", "在线支付", "2023-07-05 12:30:59"]
    var type : Int = 2
    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "订单详情")
        configMainView()
    }
    private func configMainView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TROrderDetailStateTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(TROrderDetailTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TROrderDetailResultTableViewCell.self, forCellReuseIdentifier: "cell2")

        tableView.register(TRTaskDetailTableViewCell2.self, forCellReuseIdentifier: "cell4")
        tableView.register(TROrderPeiSongInfoTableViewCell.self, forCellReuseIdentifier: "cell3")

        tableView.register(TRTaskDetailTableViewCell3.self, forCellReuseIdentifier: "cell5")

        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
        }
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if type == 2 {
                let view = TRPunishBottomView(frame: .zero)
                view.contentHeight = 407 + 35
                view.addToWindow()
                view.openView()
            } else if type == 3 {
                let view = TRPunishBottomView(frame: .zero)
                view.addToWindow()
                view.openView()
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        15
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 3
        } else if section == 4 {
            return orderInfo.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 270
        } else if indexPath.section == 1 {
            return 120 - 60
        } else if indexPath.section == 2 {
            return 218 - 60
        } else if indexPath.section == 3 {
            return 51
        } else if indexPath.section == 4 {
            return 51
        }
        
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TROrderDetailTableViewHeader
        if section == 1 {
            header.nameLab.text = "罚单"
            header.numLab.isHidden = true
            header.unitLab.isHidden = true
            header.priceLab.isHidden = false
            header.priceLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
            header.priceLab.text = "-100元"
        } else if section == 2{
            header.nameLab.text = "配送信息"
            header.numLab.isHidden = true
            header.unitLab.isHidden = true
            header.priceLab.isHidden = true
        }else if section == 3 {
            header.nameLab.text = "商品清单"
            header.numLab.isHidden = false
            header.unitLab.isHidden = false
            header.priceLab.isHidden = false
            header.priceLab.textColor = UIColor.hexColor(hexValue: 0x141414)
            header.priceLab.text = "100"
        }else if section == 4 {
            header.nameLab.text = "订单信息"
            header.numLab.isHidden = true
            header.unitLab.isHidden = true
            header.priceLab.isHidden = true
        }
        return header
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            return cell
        }  else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            return cell
        }  else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
            return cell
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath) as! TRTaskDetailTableViewCell3
            cell.nameLab.text = orderInfo[indexPath.row]
            cell.detailLab.text = payInfo[indexPath.row]
            if indexPath.row == 5 {
                cell.yuyueLab.isHidden = false
            } else {
                cell.yuyueLab.isEnabled = true
            }
            if indexPath.row == 0 {
                cell.type = 1
            } else if indexPath.row == 1 {
                cell.type = 2
            } else {
                cell.type = 0
            }
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

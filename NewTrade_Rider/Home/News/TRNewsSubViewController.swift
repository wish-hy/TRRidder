//
//  TRNewsSubViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/16.
//

import UIKit

class TRNewsSubViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var key : String = ""
    
    var data : [TRADModel] = []
    
    var ev : LYEmptyView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ev = LYEmptyView.empty(with: UIImage(named: "no_data_order"), titleStr: "暂无相关内容", detailStr: "")
        ev.contentViewY = 0
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.ly_emptyView = ev
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.hexColor(hexValue: 0xF7F9FA)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TSNewsSubViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-51)
        }
        tableView.mj_header = MJRefreshHeader(refreshingBlock: {[weak self] in
            guard let self = self else { return }
            page = 1
            configNetData()
        })
//        tableView.mj_footer = MJRefreshFooter(refreshingBlock: {[weak self] in
//            guard let self = self else { return }
//            page += 1
//            configNetData()
//        })
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {[weak self] in
            guard let self = self else { return }
            page += 1
            configNetData()
        })
        configNetData()
    }
    private func configNetData(){
//        if key.isEmpty {
//            return
//        }
        let subPars : [String : Any] = [
            :
        ]
        let pars = ["param" : subPars,
                    "size" : "10",
                    "current" : page] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Home_AD, pars:  pars) {[weak self] dict in

            guard let self = self else {return}
            tableView.mj_header?.endRefreshing()
            tableView.mj_footer?.endRefreshing()
            guard let model = TRADManage.deserialize(from: dict) else {return}
            if page == 1 {
                data.removeAll()
            }
            data.append(contentsOf: model.data.records)
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
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
//        let vc = TRNewsDetailViewController()
//        let model = data[indexPath.row]
//        vc.id = model.id
//        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TSNewsSubViewCell
        
        cell.model = data[indexPath.row]
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 106), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 12, height: 12))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        
        let maskPath1 = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 106), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 12, height: 12))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.path = maskPath1.cgPath

            if indexPath.row == 0 {
                cell.bgView.layer.mask = maskLayer

            } else if indexPath.row == 4 {
                cell.bgView.layer.mask = maskLayer1

            } else {
                cell.bgView.layer.mask = nil

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

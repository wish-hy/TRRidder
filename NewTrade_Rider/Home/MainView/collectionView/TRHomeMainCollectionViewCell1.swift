//
//  TRHomeMainCollectionViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/6.
//

import UIKit


// MARK: 新任务页面
class TRHomeMainCollectionViewCell1: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
 
    
    var tableView : UITableView!
    var page : Int = 1
    var data : [TROrderModel] = []
    
    private var ev : LYEmptyView!
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
       
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .init(Notification_Name_Order_Done), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .init(Notification_Name_Order_Accept), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .init(Notification_Name_Location_Update), object: nil)

    }
    
    private func setupView(){
        ev = LYEmptyView.empty(with: UIImage(named: "no_data_order"), titleStr: "暂无订单", detailStr: "")
        ev.contentViewY = self.contentView.ly_centerY / 2 - StatusBar_Height
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRHomeTaskTableViewCell.self, forCellReuseIdentifier: "cell1")
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self.contentView)
        }
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            guard let self = self else { return }
            NotificationCenter.default.post(name: .init(Notification_Home_refresh), object: nil)
           refreshData()
        })
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {[weak self] in
            guard let self = self else { return }
            page += 1
            configData()
        })
        
        refreshData()
    }
    @objc private func refreshData(){
        page = 1
       
        configData()
    }
    private func configData(){
        
//        询问定位权限
        TKPermissionLocationAlways.auth(withAlert: true) {[weak self] ret in
            guard let self = self else {return}
        }
        
        var arr : [String] = []
        if !TRDataManage.shared.curLongLat.isEmpty {
            arr = TRDataManage.shared.curLongLat.components(separatedBy: ",")
            if arr.count != 2 {
                SVProgressHUD.showInfo(withStatus: "位置信息异常")
                return
            }
        }
        let subPars = [
            "lat": arr.last ?? "",
            "lon": arr.first ?? ""
        ] as [String : Any]
        let pars = [
            "param" : subPars,
            "current" : page,
            "size" : PAGE_SIZE
        ] as [String : Any]
        TRNetManager.shared.post_no_lodding(url: URL_Order_Waitting, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TROrderManage.deserialize(from: dict) else {
                tableView.mj_header?.endRefreshing()
                tableView.mj_footer?.endRefreshing()
                return}
            if model.code == Net_Code_Success {
                if page == 1 {
                    data.removeAll()
                }
                data.append(contentsOf: model.data.records)
                tableView.reloadData()
            }
            tableView.mj_header?.endRefreshing()
            tableView.mj_footer?.endRefreshing()
            if tableView.ly_emptyView == nil {
                tableView.ly_emptyView = ev
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRHomeTaskTableViewCell
        let model = data[indexPath.row]
        cell.model = model
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TRTaskDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        let model = data[indexPath.row]
        vc.model = model
        vc.type = 1
        self.viewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

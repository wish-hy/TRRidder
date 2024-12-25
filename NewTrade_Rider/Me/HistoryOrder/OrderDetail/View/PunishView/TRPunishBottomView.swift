//
//  TRPunishBottomView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRPunishBottomView: TRBottomPopBasicView  , UITableViewDelegate, UITableViewDataSource{
    var tableView : UITableView!
    let names = ["取消来源","取消时间","取消原因","罚金(元)"]
    let values = ["骑手取消订单","2023-07-20 17:23:59","15分钟≤抢单后，骑手取消","-5元"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubView()
    }
    
    private func configSubView(){
    
        contentView.backgroundColor = .clear
        let whiteView = UIView()
        contentView.addSubview(whiteView)
        whiteView.backgroundColor = .white
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TRTaskDetailTableViewCell3.self, forCellReuseIdentifier: "cell1")

        tableView.register(TRPunishBottomViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRPunishBottomViewFooter.self, forHeaderFooterViewReuseIdentifier: "footer")

        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(contentView)
        }
        whiteView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(tableView)
            make.height.equalTo(50)
        }
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 114
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 61
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as! TRPunishBottomViewFooter
        footer.cancelBtn.rx.tap.subscribe(onNext:{[weak self] in
            self?.closeView()
        }).disposed(by: bag)

        return footer
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRTaskDetailTableViewCell3
        cell.nameLab.text = names[indexPath.row]
        cell.detailLab.text = values[indexPath.row]
        return cell
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

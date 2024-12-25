//
//  TRBottomTransOrderPopVIew.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit

class TRBottomTransOrderPopVIew: TRBottomPopBasicView , UITableViewDelegate, UITableViewDataSource {

    var tableView : UITableView!
    
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
        tableView.register(TRBottomTransOrderMoneyCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRBottonTransOrderTextTableViewCell.self, forCellReuseIdentifier: "cell2")

        tableView.register(TRBottomReportPicCell.self, forCellReuseIdentifier: "cell3")

        tableView.register(TRBottomTransOrderPopHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRBottomTransOderPopFooter.self, forHeaderFooterViewReuseIdentifier: "footer")

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
        return 109
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 52
        } else if indexPath.row == 1 {
            return 115
        } else {
            return 90
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as! TRBottomTransOderPopFooter
        
        footer.cancelBtn.rx.tap.subscribe(onNext:{[weak self] in
            self?.closeView()
        }).disposed(by: bag)
        footer.sureBtn.rx.tap.subscribe(onNext:{[weak self] in
            self?.closeView()
        }).disposed(by: bag)

        return footer
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRBottomTransOrderMoneyCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRBottonTransOrderTextTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! TRBottomReportPicCell
        return cell
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

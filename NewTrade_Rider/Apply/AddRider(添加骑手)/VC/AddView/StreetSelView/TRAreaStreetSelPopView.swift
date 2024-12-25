//
//  TRAreaStreetSelPopView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/19.
//

import UIKit

class TRAreaStreetSelPopView: TRBottomPopBasicView, UITableViewDataSource, UITableViewDelegate {

    var tableView : UITableView!
    var applyAreaList :[TRAddressModel] = []

    var block : Int_Block?
    var currentIndex : Int = -1
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        
        configTitleCancelView()
        titleLab.text = "已开通乡/镇/街道"
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TRAreaStreetSelCell.self, forCellReuseIdentifier: "cell")
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(titleLab.snp.bottom).offset(12)
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if block != nil {
            block!(indexPath.row)
            closeView()
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applyAreaList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRAreaStreetSelCell
        let model = applyAreaList[indexPath.row]
        cell.itemLab.text = model.townAddress
        if currentIndex == indexPath.row {
            cell.isSel = true
        } else {
            cell.isSel = false
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

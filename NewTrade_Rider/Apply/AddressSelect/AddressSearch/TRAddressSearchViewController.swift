//
//  TRAddressSearchViewController.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/22.
//

import UIKit

class TRAddressSearchViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    var searchView : TRAddressSearchView!

    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        costomNavBar()
        costomSearchView()
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRAddressSearchCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(searchView.snp.bottom).offset(15)
        }
    }
    
    private func costomNavBar(){
        configNavBar()
        configNavTitle(title: "选择工作地点")
        configNavLeftBtn()
        navBar?.backgroundColor = .white
        let sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(.themeColor(), for: .normal)
        sureBtn.frame = .init(x: 0, y: 0, width: 35, height: 28)
        navBar?.rightView = sureBtn
    }
    private func costomSearchView(){
            
        searchView = TRAddressSearchView(frame: .zero)
        searchView.backgroundColor = .white
        searchView.contentView.backgroundColor = .bgColor()
        searchView.layer.cornerRadius =  16
        searchView.layer.masksToBounds = true
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(0)
            make.top.equalTo(self.view).offset(Nav_Height + 6)
            make.height.equalTo(32)
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
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRAddressSearchCell
        
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

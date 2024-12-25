//
//  TRSearchLocView.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/12.
//

import UIKit
import MapKit
class TRSearchLocView: UIView, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
    var textField : UITextField!
    var tableView : UITableView!
    var items : [MAPointAnnotation] = [] {
        didSet{
            currnetSel = -1
            tableView.reloadData()
        }
    }
    var searchBlock : String_Block?
    var selectBlock : Int_Block?
    var currnetSel : Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = .white
        let searchbgView = UIView()
        searchbgView.trCorner(18)
        searchbgView.backgroundColor = .bgColor()
        self.addSubview(searchbgView)
        let searchImgV = UIImageView(image: UIImage(named: "search"))
        searchbgView.addSubview(searchImgV)
        textField = UITextField()
        textField.placeholder = "搜索地址"
        textField.font = .trFont(16)
        textField.returnKeyType = .search
        textField.delegate = self
        searchbgView.addSubview(textField)
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TRSearchLocCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(tableView)
        
        searchbgView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(self).offset(16)
            make.height.equalTo(36)
        }
        searchImgV.snp.makeConstraints { make in
            make.left.equalTo(searchbgView).inset(8)
            make.centerY.equalTo(searchbgView)
            make.height.width.equalTo(20)
        }
        textField.snp.makeConstraints { make in
            make.left.equalTo(searchImgV.snp.right).offset(5)
            make.top.bottom.equalTo(searchbgView).inset(3)
            make.right.equalTo(searchbgView)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchbgView.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(self)
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
        currnetSel = indexPath.row
        if selectBlock != nil {
            selectBlock!(indexPath.row)
        }
        tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRSearchLocCell
        let placeMark = items[indexPath.row]
        cell.itemLab.text = placeMark.title
        //街道
        cell.desLab.text = placeMark.subtitle
        if indexPath.row == currnetSel {
            cell.isSel = true
        } else {
            cell.isSel = false
        }
        return cell
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {return true}
        //搜索
            if self.searchBlock != nil {
                self.searchBlock!(text)
            }
        textField.resignFirstResponder()
        return true
        
    }
}

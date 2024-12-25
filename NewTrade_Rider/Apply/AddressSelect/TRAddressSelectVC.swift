//
//  TRAddressSelectVC.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/21.
//

import UIKit
import RxSwift
import RxCocoa
class TRAddressSelectVC: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    
    let bag = DisposeBag()
    var searchView : TRAddressSearchView!
    
    var addressView : TRAddressView!
    
    var addressSelView : TRLocAddressSelView!
    
    var tableView : UITableView!
    
    var progress : Int = 0
    var provinces : [TRAddressModel] = []
    var citys : [TRAddressModel] = []
    var xians : [TRAddressModel] = []
    var streets : [TRAddressModel] = []
    
    var block : Array_Block?
    
    var isLimited : Bool = true
    //网络参数
    private var level : Int = 1
    private var parentId : String = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        costomNav()
//        costomSearchView()
        costomTableView()
        if isLimited {
            configNetData()
        } else {
            configNoLimitData()
        }
    }

    private func configNetData(){
        let pras = [
            "parentId" : parentId
        ]
        TRNetManager.shared.get_no_lodding(url: URL_Address_List, pars: pras) {[weak self] (dict) in
            guard let self = self else {return}
            guard let model = TRAddressManage.deserialize(from: dict) else {return}
            if progress == 0 {
                provinces = model.data
            } else if progress == 1 {
                citys = model.data
            } else if progress == 2 {
                xians = model.data
            } else if progress == 3 {
                streets = model.data
            }
//            if model.data.count <= 0 {
//               let view = TRNotOpenView(frame: .zero)
//                view.addToWindow()
//            }
            tableView.reloadData()
        }
    }
    private func configNoLimitData(){
        let pras = [
            "parentId" : parentId
        ]
        TRNetManager.shared.get_no_lodding(url: URL_Address_No_Limit_List, pars: pras) {[weak self] (dict) in
            guard let self = self else {return}
            guard let model = TRAddressManage.deserialize(from: dict) else {return}
            if progress == 0 {
                provinces = model.data
            } else if progress == 1 {
                citys = model.data
            } else if progress == 2 {
                xians = model.data
            } else if progress == 3 {
                streets = model.data
            }
//            if model.data.count <= 0 {
//               let view = TRNotOpenView(frame: .zero)
//                view.addToWindow()
//            }
            tableView.reloadData()
        }
    }
    private func costomTableView(){
//        addressView = TRAddressView(frame: .zero)
//        addressView.items = []
//        addressView.block = {[weak self](index) in
//            guard let self = self else {return}
//            
//            var temItems = addressView.items
//
//            temItems.removeLast(temItems.count - index)
//            addressView.items = temItems
//            self.progress = index
//            tableView.reloadData()
//        }
//        self.view.addSubview(addressView)
        
        addressSelView = TRLocAddressSelView(frame: .zero)
        addressSelView.block = {[weak self](index) in
            guard let self = self else {return}

            var temItems = addressSelView.items

            temItems.removeLast(temItems.count - index)
            addressSelView.items = temItems
            self.progress = index
            tableView.reloadData()
        }
        addressSelView.items = []
        self.view.addSubview(addressSelView)
        
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TRAddressLocCell.self, forCellReuseIdentifier: "locCell")
        tableView.register(TRAddressLetterCell.self, forCellReuseIdentifier: "letterCell")
        
//        tableView.register(TRAddressView.self, forHeaderFooterViewReuseIdentifier: "header")
        
        self.view.addSubview(tableView)
        addressSelView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
//            make.top.equalTo(searchView.snp.bottom)
            make.top.equalTo(self.view).offset(Nav_Height + 6)
//            make.height.equalTo(120)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(addressSelView.snp.bottom).offset(15)
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
        return 51
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            return
//        }
        if progress == 4 {return}
        var items = addressSelView.items
        var newItems : [TRAddressModel] = []

        var new : TRAddressModel?
        if progress == 0 {
            new = provinces[indexPath.row]
        } else if progress == 1 {
            newItems.append(items[0])
            new =  citys[indexPath.row]
        } else if progress == 2 {
            newItems.append(items[0])
            newItems.append(items[1])

            new = xians[indexPath.row]
        } else {
            newItems.append(items[0])
            newItems.append(items[1])
            newItems.append(items[2])

            new = streets[indexPath.row]
        }
        
        newItems.append(new!)
        addressSelView.items = newItems
        if progress < 3 {
            progress += 1
            parentId = new!.id
            if isLimited {
                configNetData()
            } else {
                configNoLimitData()
            }
        }
        tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if progress == 0 {
            return provinces.count
        } else if progress == 1 {
            return citys.count
        } else if progress == 2 {
            return xians.count
        } else if progress == 3{
            return streets.count
        }
        
        return streets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "locCell", for: indexPath)
//            
//            return cell
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "letterCell", for: indexPath) as! TRAddressLetterCell
        cell.letterLab.isHidden = true
        if progress == 0 {
            let model = provinces[indexPath.row]
            cell.lab.text = model.name
        } else if progress == 1 {
            let model = citys[indexPath.row]
            cell.lab.text =  model.name
        } else if progress == 2 {
            let model = xians[indexPath.row]
            cell.lab.text = model.name
        } else {
            let model = streets[indexPath.row]
            cell.lab.text = model.name
        }
        return cell
        
    }
    
    private func costomSearchView(){
        searchView = TRAddressSearchView(frame: .zero)
        searchView.layer.cornerRadius =  16
        searchView.layer.masksToBounds = true
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(0)
            make.top.equalTo(self.view).offset(Nav_Height + 6)
            make.height.equalTo(32)
        }
        
        searchView.textField.isEnabled = false
        searchView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(searchAction))
        searchView.addGestureRecognizer(tap)
    }
    @objc func searchAction(){
        let vc = TRAddressSearchViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func costomNav(){
        configNavBar()
        configNavTitle(title: "选择区域")
        
        let cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        cancelBtn.frame = .init(x: 0, y: 0, width: 28, height: 28)
        navBar?.leftView = cancelBtn
        
        let sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(.hexColor(hexValue: 0x1D6CFF), for: .normal)
        sureBtn.frame = .init(x: 0, y: 0, width: 40, height: 28)
        navBar?.rightView = sureBtn
        
        
        cancelBtn.rx.tap.subscribe(onNext: {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
        
        sureBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            if addressSelView.items.count < 4 {
                SVProgressHUD.showInfo(withStatus: "请完善区域信息")
                return
            }
            
            if self.block != nil {
                self.block!(addressSelView.items)
            }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
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

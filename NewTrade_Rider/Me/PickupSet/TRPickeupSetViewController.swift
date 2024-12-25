//
//  TRPickeupSetViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRPickeupSetViewController:  BasicViewController, UITableViewDataSource, UITableViewDelegate {
    let infoTips = ["头像","姓名","性别","所在地","手机号码","联系地址"]
    var tableView : UITableView!
    
    var settingModel : TROrderSettingModel = TROrderSettingModel()
    
    var typeArr = ["商城配送接单价格大于","同城跑腿接单价格大于","同城送货接单价格大于"]
    override func viewDidLoad() {
        super.viewDidLoad()

       

        configTopView()
        
        
        configMainView()
    }
    private func configTopView(){
        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "接单设置")
        let saveBtn = TRFactory.buttonWithCorner(title: "保存", bgColor: .lightThemeColor(), font: .trMediumFont(13), corner: 15)
        saveBtn.frame = .init(x: 0, y: 0, width: 60, height: 30)
        saveBtn.addTarget(self, action: #selector(upOrderSetting), for: .touchUpInside)
        navBar?.rightView = saveBtn
    }
    private func configMainView(){
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRPickupsetSelectTableViewCell.self, forCellReuseIdentifier: "cell1_1")
        tableView.register(TRPickupsetSelectTableViewCell.self, forCellReuseIdentifier: "cell1_2")
        tableView.register(TRPickupsetSelectTableViewCell.self, forCellReuseIdentifier: "cell1_3")
        tableView.register(TRPickupsetSelectTableViewCell.self, forCellReuseIdentifier: "cell1_4")
        tableView.register(TRPickupsetSelectTableViewCell.self, forCellReuseIdentifier: "cell1_5")
        tableView.register(TRPickupsetSelectTableViewCell.self, forCellReuseIdentifier: "cell1_6")

        tableView.register(TRPickupSwitchTableViewCell.self, forCellReuseIdentifier: "cell2")
        tableView.register(TRPickupShopSelTableViewCell.self, forCellReuseIdentifier: "cell3")
        
        tableView.register(TRPickupSetHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header0")
        tableView.register(TRPickupSetTitleHeader.self, forHeaderFooterViewReuseIdentifier: "titleHeader")

        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
        }
        configNetData()
    }
    func configNetData(){
        TRNetManager.shared.get_no_lodding(url: URL_Order_Setting_Get, pars: [:]) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TROrderSettingManage.deserialize(from: dict) else {return}
            if model.code == 1 {
                settingModel = model.data
                tableView.reloadData()
//                self.navigationController?.popViewController(animated: true)
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    @objc func upOrderSetting(){
        let pars = [
            "id" : settingModel.id,
            "maxReceive" : settingModel.maxReceive,
            "alwaysAddress" : settingModel.alwaysAddress,
            "alwaysLatLong" : settingModel.alwaysLatLong,
            "localMinDelFee" : settingModel.localMinDelFee.elementsEqual("不限") ? "0" : settingModel.localMinDelFee,
            "mallMinDelFee" : settingModel.mallMinDelFee.elementsEqual("不限") ? "0" : settingModel.mallMinDelFee,
            "delGoodsMinDelFee" : settingModel.delGoodsMinDelFee.elementsEqual("不限") ? "0" : settingModel.delGoodsMinDelFee
        
        ]
        TRNetManager.shared.put_no_lodding(url: URL_Order_Settting_upd, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "设置成功")
                self.navigationController?.popViewController(animated: true)
            } else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 51
        } else if indexPath.section == 1 {
            if indexPath.row == 2 {
                return 75
            } else {
                return 51
            }
        }
        return 73
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 16 + 45
        } else if section == 1 {
            return 45
        }
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //第三区隐藏
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 4
        }
        return 2
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
            return header
        } else if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "titleHeader") as! TRPickupSetTitleHeader
            header.titleLab.text = "派单"
            return header
        }
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header0")
        header?.contentView.backgroundColor = .bgColor()
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                TKPermissionLocationAlways.auth(withAlert: true) { ret in
                    if ret{
                        let vc = TRMapLocalViewController()
                        vc.anni_block = {[weak self](ann) in
                            guard let self = self else { return }
                            settingModel.alwaysAddress = ann.title + ann.subtitle
                            settingModel.alwaysLatLong = String.init(format: "%.6f,%.6f", ann.coordinate.longitude,ann.coordinate.latitude)
                            tableView.reloadData()
                        }
                        vc.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                

            } else if indexPath.row == 1 {
                let view = TRSimpleDataPicker(frame: .zero)
                view.titleLab.text = "商城配送接单价格大于"
                let items = ["不限","5元","10元","20元"]
                view.items = items
                view.block = {[weak self](index) in
                    guard let self  = self  else { return }
                    if index == 0 {
                        settingModel.mallMinDelFee = "0"
                    }
                    settingModel.mallMinDelFee = items[index].replacingOccurrences(of: "元", with: "")
                    tableView.reloadData()
                }
                view.addToWindow()
                view.openView()
            } else if indexPath.row == 2 {
                let view = TRSimpleDataPicker(frame: .zero)
                view.titleLab.text = "同城跑腿接单价格大于"
                let items = ["不限","5元","10元","20元"]
                view.items = items
                view.block = {[weak self](index) in
                    guard let self  = self  else { return }
                    if index == 0 {
                        settingModel.localMinDelFee = "0"
                    }
                    settingModel.localMinDelFee = items[index].replacingOccurrences(of: "元", with: "")
                    tableView.reloadData()
                }
                view.addToWindow()
                view.openView()
            } else if indexPath.row == 3 {
                let view = TRSimpleDataPicker(frame: .zero)
                view.titleLab.text = "同城送货接单价格大于"
                let items = ["不限","5元","10元","20元"]
                view.items = items
                view.block = {[weak self](index) in
                    guard let self  = self  else { return }
                    if index == 0 {
                        settingModel.delGoodsMinDelFee = "0"
                    }
                    settingModel.delGoodsMinDelFee = items[index].replacingOccurrences(of: "元", with: "")
                    tableView.reloadData()
                }
                view.addToWindow()
                view.openView()
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1_1", for: indexPath) as! TRPickupsetSelectTableViewCell
            cell.titleLab.text = "同时接单量"
            cell.valeTextField.placeholder = "最大（10单）"
            cell.valeTextField.isUserInteractionEnabled = true
            cell.valeTextField.rx.text.skip(1).subscribe(onNext: {[weak self](txt) in
                guard let self  = self  else { return }
                settingModel.maxReceive = txt ?? ""
            }).disposed(by: cell.bag)
            cell.valeTextField.text = settingModel.maxReceive
            return cell
        } else if indexPath.section == 1{
            
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1_3", for: indexPath) as! TRPickupsetSelectTableViewCell

                    cell.titleLab.text = "常驻送货区域"
                    cell.valeTextField.placeholder = "请选择常驻送货区域"
                    cell.valeTextField.text = settingModel.alwaysAddress
                 
                    return cell

                } else if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1_4", for: indexPath) as! TRPickupsetSelectTableViewCell
                    cell.titleLab.text = "商城配送接单价格大于"
                    cell.valeTextField.text = "不限"
                    cell.valeTextField.rx.text.skip(1).subscribe(onNext: {[weak self](txt) in
                        guard let self  = self  else { return }
                        settingModel.mallMinDelFee = txt ?? ""
                    }).disposed(by: cell.bag)
                    if settingModel.mallMinDelFee.elementsEqual("0") ||
                        settingModel.mallMinDelFee.elementsEqual("不限") {
                        cell.valeTextField.text = "不限"
                    } else {
                        cell.valeTextField.text = settingModel.mallMinDelFee + "元"
                    }
                    return cell

                } else if indexPath.row == 2 {
 
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1_2", for: indexPath) as! TRPickupsetSelectTableViewCell
                    cell.valeTextField.rx.text.skip(1).subscribe(onNext: {[weak self](txt) in
                        guard let self  = self  else { return }
                        settingModel.localMinDelFee = txt ?? ""
                    }).disposed(by: cell.bag)
                    cell.titleLab.text = "同城跑腿接单价格大于"
                    if settingModel.localMinDelFee.elementsEqual("0") ||
                        settingModel.localMinDelFee.elementsEqual("不限"){
                        cell.valeTextField.text = "不限"
                    } else {
                        cell.valeTextField.text = settingModel.localMinDelFee + "元"
                    }
                    return cell
                }  else  if indexPath.row == 3{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1_2", for: indexPath) as! TRPickupsetSelectTableViewCell
                    cell.valeTextField.rx.text.skip(1).subscribe(onNext: {[weak self](txt) in
                        guard let self  = self  else { return }
                        settingModel.delGoodsMinDelFee = txt ?? ""
                    }).disposed(by: cell.bag)
                    cell.titleLab.text = "同城送货接单价格大于"
                    if settingModel.delGoodsMinDelFee.elementsEqual("0") || settingModel.delGoodsMinDelFee.elementsEqual("不限"){
                        cell.valeTextField.text = "不限"
                    } else {
                        cell.valeTextField.text = settingModel.delGoodsMinDelFee + "元"
                    }
                    return cell

                } else  {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1_5", for: indexPath) as! TRPickupsetSelectTableViewCell

                    cell.titleLab.text = "自动接单时间"
                    cell.valeTextField.text = "8:00~24:00"
                    return cell

                }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            
            return cell
        }
        
    }

}

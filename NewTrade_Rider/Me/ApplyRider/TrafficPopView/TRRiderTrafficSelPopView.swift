//
//  TRRiderTrafficSelPopView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/26.
//

import UIKit

class TRRiderTrafficSelPopView: TRBottomPopBasicView, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    
    var bottomView : TRBottomButton1View!
    
    var currentVehicelID : String = ""
    
    var block : Any_Block?
    var addBlock : Void_Block?
    //0 两组 1 单组可选 2 单组不可选 3 无数据
    private var type = 3
    var containerModel : TRRidderApplyVehicleSelContainer? {
        didSet {
            guard let containerModel = containerModel else { return }
            for tm in containerModel.allowVehicleList {
                tm.isUseful = true
            }
            for tm in containerModel.notAllowVehicleList {
                tm.isUseful = false
            }
            
            if containerModel.allowVehicleList.isEmpty {
                if containerModel.notAllowVehicleList.isEmpty {
                    type = 3
                } else {
                    type = 2
                }
            } else {
                if containerModel.notAllowVehicleList.isEmpty {
                    type = 1
                } else {
                    type = 0
                }
            }
            tableView.reloadData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        configTitleCancelView()
        titleLab.text = "选择车辆"
        
        bottomView = TRBottomButton1View(frame: .zero)
        bottomView.saveBtn.setTitle("添加车辆", for: .normal)
        bottomView.saveBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        contentView.addSubview(bottomView)
        
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRRiderTrafficSelPopHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")

        tableView.register(TRTrafficSelCell.self, forCellReuseIdentifier: "cell")
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(bottomView.snp.top)
            make.top.equalTo(titleLab.snp.bottom).offset(16)
        }
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
        }
    }
    @objc func addAction(){
        if addBlock != nil {
            addBlock!()
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRRiderTrafficSelPopHeader
        // //0 两组 1 单组可选 2 单组不可选 3 无数据
        if type == 0 {
            if section == 0 {
                header.itemLab.text = "可用车辆"
            } else {
                header.itemLab.text = "不符合配送业务的车辆"
            }
        } else if type == 1 {
            header.itemLab.text = "可用车辆"
        } else if type == 2 {
            header.itemLab.text = "不符合配送业务的车辆"
        } else if type == 3 {
            //不会执行
            header.itemLab.text = "不符合配送业务的车辆"
        }

        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
        footer?.contentView.backgroundColor = .bgColor()
        return footer
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == 0 {
            if indexPath.section == 0 {
                let m = containerModel!.allowVehicleList[indexPath.row]
                currentVehicelID = m.id
                if block != nil {
                    block!(m)
                    self.closeView()
                }
            }
        } else if type == 1 {
            let m = containerModel!.allowVehicleList[indexPath.row]
            currentVehicelID = m.id
            if block != nil {
                block!(m)
                self.closeView()
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // //0 两组 1 单组可选 2 单组不可选 3 无数据
        if type == 3 {
            return 0
        } else if type == 0 {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == 0 {
            if section == 0 {
                return containerModel!.allowVehicleList.count
            } else {
                return containerModel!.notAllowVehicleList.count
            }
        } else if type == 1 {
            return containerModel!.allowVehicleList.count
        } else if type == 2 {
            return containerModel!.notAllowVehicleList.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRTrafficSelCell
        
        var model : TRRidderApplyVehicleSelModel?
        if type == 0 {
            if indexPath.section == 0 {
                 model = containerModel!.allowVehicleList[indexPath.row]
                
            } else {
                 model =  containerModel!.notAllowVehicleList[indexPath.row]
            
            }
        } else if type == 1 {
             model = containerModel!.allowVehicleList[indexPath.row]
        } else if type == 2 {
             model =  containerModel!.notAllowVehicleList[indexPath.row]
        }
        if model != nil {
            cell.isApplySel = model!.id == currentVehicelID
        }

        cell.applyVehiclemodel = model
        return cell
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

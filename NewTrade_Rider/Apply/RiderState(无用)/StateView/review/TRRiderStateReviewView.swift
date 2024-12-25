//
//  TRRiderStateReviewView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit
import RxSwift
import RxCocoa
class TRRiderStateReviewView: UIView, UITableViewDataSource, UITableViewDelegate {
    //审核结果
    var result : Bool = false
    var sections = ["骑手证件信息","骑手车辆信息","车辆照片","审核信息"]
    var card_items = ["证件","姓名","性别","民族","出生日期","住址","身份证账号","证件有效期"]
    var traffic_items = ["骑手类型","骑手车辆","车辆类型","驾照","车牌号","下次年检时间"]
    var tableView : UITableView!
    
    var riderModel : TRRiderUserModel!
    
    let bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configData()
        setupView()
    }
    private func configData(){
        riderModel = TRRiderUserModel()
    }
    private func setupView(){
        
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRRiderReviewSimpleCell.self, forCellReuseIdentifier: "simple")
        
        tableView.register(TRRiderReviewImgCell.self, forCellReuseIdentifier: "img")

        tableView.register(TRRiderReViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
            
        tableView.register(TRRiderReviewTrafficCodeCell.self, forCellReuseIdentifier: "trafficCode")

        
        tableView.register(TRStoreStateBrandImgCell.self, forCellReuseIdentifier: "trafficImg")

        tableView.register(TRRiderReViewStateCell.self, forCellReuseIdentifier: "state")
        
        tableView.register(TRRiderReViewResultCell.self, forCellReuseIdentifier: "result")

        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRRiderReViewHeader
        header.titleLab.text = sections[section]
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == card_items.count - 1 {
                return 34
            }
        } else if indexPath.section == 1 {
            if indexPath.row == traffic_items.count - 1 {
                return 34
            }
        }
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return card_items.count
        } else if section == 1 {
            return 6
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
// MARK: - 骑手信息
        if indexPath.section == 0 {
            let item = card_items[indexPath.row]
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "img", for: indexPath) as! TRRiderReviewImgCell
                cell.type = 1 // 有背景
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "simple", for: indexPath) as! TRRiderReviewSimpleCell
            if item.elementsEqual("姓名"){
                cell.valueLab.text = riderModel.name
            } else if item.elementsEqual("性别"){
                cell.valueLab.text = riderModel.sex
            } else if item.elementsEqual("民族"){
                cell.valueLab.text = riderModel.nation
            } else if item.elementsEqual("出生日期"){
                cell.valueLab.text = riderModel.birth
            } else if item.elementsEqual("住址"){
                cell.valueLab.text = riderModel.address
            } else if item.elementsEqual("身份证账号"){
                cell.valueLab.text = riderModel.idCard
            } else if item.elementsEqual("证件有效期"){
                cell.valueLab.text = riderModel.idCardDate
            }
            if item.elementsEqual("证件有效期"){
                cell.cornderType = 2
            } else {
                cell.cornderType = 0
            }
            cell.itemLab.text = item
            return cell
// MARK: - 车辆信息
        } else if indexPath.section == 1 {
            let item = traffic_items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "simple", for: indexPath) as! TRRiderReviewSimpleCell
            if item.elementsEqual("骑手类型"){
                cell.valueLab.text = riderModel.trafficInfo.riderType
            } else if item.elementsEqual("骑手车辆"){
                cell.valueLab.text = riderModel.trafficInfo.traffic
            } else if item.elementsEqual("车辆类型"){
                cell.valueLab.text = riderModel.trafficInfo.type
            } else if item.elementsEqual("车辆所有人"){
                cell.valueLab.text = riderModel.trafficInfo.owner
            } else if item.elementsEqual("下次年检时间"){
                cell.valueLab.text = riderModel.trafficInfo.nextCheckTime
            } else if item.elementsEqual("驾照"){
                let cell0 = tableView.dequeueReusableCell(withIdentifier: "img", for: indexPath) as! TRRiderReviewImgCell
                cell0.leftImgV.image = UIImage(named: "driver_card")
                cell0.rightImgV.image = UIImage(named: "driver_card")
                cell0.type = 0
                return cell0
            } else if item.elementsEqual("车牌号"){
                let cell0 = tableView.dequeueReusableCell(withIdentifier: "trafficCode", for: indexPath) as! TRRiderReviewTrafficCodeCell
                cell0.codeView.isUserInteractionEnabled = false
                cell0.codeView.code = "湘A·529863"
                cell0.itemLab.text = item
                return cell0
            }
            if item.elementsEqual("下次年检时间"){
                cell.cornderType = 2
            } else {
                cell.cornderType = 0
            }
            cell.itemLab.text = item
            return cell
// MARK: - 车辆照片
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "trafficImg", for: indexPath) as! TRStoreStateBrandImgCell
            cell.leading = 15
            cell.hasLab = false
            cell.cloum = 2
            cell.space = 13
            cell.imgHeight = 150
            cell.imgCorner = 10
            cell.imgs = ["car_1","car_2"]

            return cell
            
// MARK: - 审核信息
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "state", for: indexPath) as! TRRiderReViewStateCell
                if result{
                    
                    cell.failedBtn.setImage(UIImage(named: "uncheck_circle"), for: .normal)
                    cell.passBtn.setImage(UIImage(named: "check_circle_point"), for: .normal)

                } else {
                    
                    cell.failedBtn.setImage(UIImage(named: "check_circle_point"), for: .normal)
                    cell.passBtn.setImage(UIImage(named: "uncheck_circle"), for: .normal)
                    
                }
                cell.failedBtn.rx.tap.subscribe(onNext: {[weak self] in
                    guard let self = self else {return}
                    self.result = false
                    tableView.reloadData()
                }).disposed(by: bag)
                cell.passBtn.rx.tap.subscribe(onNext: {[weak self] in
                    guard let self = self else {return}
                    self.result = true
                    tableView.reloadData()
                }).disposed(by: bag)
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath) as! TRRiderReViewResultCell
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "simple", for: indexPath)
        
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

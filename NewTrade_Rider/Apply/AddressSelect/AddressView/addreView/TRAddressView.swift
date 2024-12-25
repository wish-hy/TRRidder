//
//  TRAddressView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/21.
//

import UIKit
//竖向的选择的器（不用了）
class TRAddressView: UIView, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    
    var itemLab : UILabel!
    var items : [TRAddressModel] = [] {
        didSet {
            if items.count >= 4 {
                isEnd = true
            } else {
                isEnd = false
            }
            tableView.reloadData()
            let h = isEnd ? 20 + items.count * 40 : 20 + 40 * (items.count + 1)
            tableView.snp.remakeConstraints { make in
                make.left.right.top.equalTo(self)
                make.height.equalTo(h)
            }
            if items.count <= 3 {
                itemLab.text = titles[items.count]
            }
        }
    }
    
    var titles = ["请选择省份","请选择城市","请选择区/县","请选择街道/乡镇"]
    var isEnd : Bool = false
    
    var block : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    private func setupView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(TRSelectStepViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(tableView)
        
        let line = UIView()
        line.backgroundColor = .lineColor()
        self.addSubview(line)
        
        itemLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 18), text: "选择街道/乡镇", textColor: .txtColor(), superView: self)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(0)
            make.height.equalTo(1)
            make.top.equalTo(tableView.snp.bottom).offset(0)
        }
        
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.top.equalTo(line.snp.bottom).offset(21)
            make.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        var newItems : [String] = []
//
//        var new = ""
//        let progress = indexPath.row
//        if progress == 0 {
//            newItems = []
//        } else if progress == 1 {
//            newItems.append(items[0])
//            new =  citys[indexPath.row]
//        } else if progress == 2 {
//            newItems.append(items[0])
//            newItems.append(items[1])
//
//            new = xians[indexPath.row]
//        } else {
//            newItems.append(items[0])
//            newItems.append(items[1])
//            newItems.append(items[2])
//
//            new = streets[indexPath.row]
//        }
        
//        newItems.append(new)
        itemLab.text = titles[indexPath.row]
        if self.block != nil {
            self.block!(indexPath.row)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEnd ? items.count : items.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRSelectStepViewCell
        if isEnd {
            let model = items[indexPath.row]
            cell.lab.text = model.name
            cell.circleType = 1
            if indexPath.row == 0 {
                cell.topLine.isHidden = true
                cell.bottomLine.isHidden = false
            } else if indexPath.row == items.count - 1 {
                cell.bottomLine.isHidden = true
                cell.topLine.isHidden = false
            } else {
                cell.bottomLine.isHidden = false
                cell.topLine.isHidden = false
            }
        } else {
            if items.count == 0 {
                cell.topLine.isHidden = true
                cell.bottomLine.isHidden = true
                cell.circleType = 0
                cell.lab.text = titles[items.count]

            } else {
                if indexPath.row == 0 {
                    let model = items[indexPath.row]
                    cell.lab.text = model.name
                    cell.topLine.isHidden = true
                    cell.bottomLine.isHidden = false
                    cell.circleType = 1
                } else if indexPath.row == items.count {
                    cell.bottomLine.isHidden = true
                    cell.topLine.isHidden = false
                    cell.circleType = 0
                    cell.lab.text = titles[items.count]
                } else {
                    let model = items[indexPath.row]
                    cell.lab.text = model.name
                    cell.topLine.isHidden = false
                    cell.bottomLine.isHidden = false
                    cell.circleType = 1
                }
            }
        }
       
        
        return cell
    }

}

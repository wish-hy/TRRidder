//
//  TRContactBottomView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRContactBottomView: TRBottomPopBasicView, UITableViewDelegate, UITableViewDataSource {

    

    var tableView : UITableView!
    //先复制type 1 待接单 2 取货中 3 配送中
    var type : Int = 1
    var order : TROrderModel? {
        didSet {
            guard order != nil else { return }
            tableView.reloadData()
        }
    }
    //联系人 1 电话 2 短信 3 IM
    
    var block : Int_Block?
    
    var contactModel : TRPrivacyConcactModel?
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
        tableView.register(TRContactBottomTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRBottomPopTipHeader.self, forHeaderFooterViewReuseIdentifier: "header")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let cancelBtn = UIButton()
        view.addSubview(cancelBtn)
        cancelBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        cancelBtn.setTitleColor(UIColor.hexColor(hexValue: 0x141414), for: .normal)
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(view).offset(15)
            make.bottom.equalTo(view).inset(20)
            make.centerX.equalTo(view)
            make.height.equalTo(44)
            make.width.equalTo(152)
        }
        cancelBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self  = self  else { return }
            closeView()
        }).disposed(by: bag)
        return view
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRBottomPopTipHeader
        // // 1 抢单 2 取货 3 配送中
        if type == 2 {
            header.nameLab.text = order?.senderName

        } else {
            header.nameLab.text = order?.receiverName
        }
        return header
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //短信取消
        2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if block != nil {
                block!(3)
                closeView()
            }
        }else if indexPath.row == 0 {
            if block != nil {
                block!(1)
                closeView()
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRContactBottomTableViewCell
        /*
         var tipImgV : UIImageView!
         var tipLab : UILabel!
         */
        if (indexPath.row == 0) {
            cell.iconImgV.image = UIImage(named: "home_phone")
            cell.nameLab.text = "拨打电话"
//            if order != nil {
//                if type == 2 {
//                    cell.desLab.text = order!.senderPhone
//                } else {
//                    cell.desLab.text = order!.receiverPhone
//                }
//            }
            if contactModel != nil {
                cell.desLab.text = contactModel!.phoneNo
            }
//            cell.actionBtn.isHidden = false
            cell.tipImgV.isHidden = false
            cell.tipLab.isHidden = false
            cell.actionBtn.setTitle("打电话", for: .normal)
            cell.actionBtn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self  = self  else { return }
                if block != nil {
                    block!(1)
                    closeView()

                }
            }).disposed(by: cell.bag)
        } else if (indexPath.row == 100){
            cell.iconImgV.image = UIImage(named: "information")
            cell.nameLab.text = "发短信"
            if order != nil {
                if type == 2 {
                    cell.desLab.text = order!.senderPhone
                } else {
                    cell.desLab.text = order!.receiverPhone
                }
            }
            cell.actionBtn.setTitle("发短信", for: .normal)
            cell.actionBtn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self  = self  else { return }
                if block != nil {
                    block!(2)
                    closeView()
                }
            }).disposed(by: cell.bag)
        } else if (indexPath.row == 1){
            cell.iconImgV.image = UIImage(named: "pop_message")
            cell.nameLab.text = "在线联系"
            cell.tipImgV.isHidden = true
            cell.tipLab.isHidden = true
            if order != nil {
                if type == 2 {
                    cell.desLab.text = "电话联系不上商家？试试在线沟通"
                } else {
                    cell.desLab.text = "电话联系不上顾客？试试在线沟通"
                }
            }

        }
        
        
        return cell
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRHomeStateSelView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/6.
//

import UIKit

class TRHomeStateSelView: UIView, UITableViewDelegate, UITableViewDataSource {
  
    var bgView : UIView!
    var contentView : UIView!
    var tableView : UITableView!
    var currentSel : Int = 0
    var block : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    @objc func hiddenSelf(){
        self.isHidden = true
    }
    private func setupView(){
        
        bgView = UIView()
        bgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(hiddenSelf))
        bgView.addGestureRecognizer(tap)
        self.addSubview(bgView)
        
        contentView = UIView()
        self.addSubview(contentView)
        
        let bgImgV = UIImageView()
        bgImgV.image = UIImage(named: "home_pop")
        bgImgV.contentMode = .scaleToFill
        contentView.addSubview(bgImgV)
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.register(TRHomeStateSelTableViewCell.self, forCellReuseIdentifier: "cell1")
        contentView.addSubview(tableView)
        //self.selectView = TRHomeStateSelView(frame: CGRect(x: 16, y: 120, width: 180, height: 188))

        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(StatusBar_Height + 44)
            make.left.equalTo(bgView).offset(40)
            make.width.equalTo(180)
            make.height.equalTo(210)
        }
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(30)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRHomeStateSelTableViewCell
        if indexPath.row == 0 {
            cell.stateImgV.image = UIImage(named: "home_state_kg")
            cell.stateLab.text = "开工"
            cell.line.isHidden = false

        }else if indexPath.row == 1 {
            cell.stateImgV.image = UIImage(named: "home_state_xx")
            cell.stateLab.text = "收工"
            cell.line.isHidden = false

        }else if indexPath.row == 2 {
            cell.stateImgV.image = UIImage(named: "home_state_ml")
            cell.stateLab.text = "忙碌"
            cell.line.isHidden = true
        }
        if currentSel == indexPath.row {
            cell.arrowImgV.isHidden = false
            cell.stateLab.textColor = UIColor.hexColor(hexValue: 0x333333)

        } else {
            cell.arrowImgV.isHidden = true
            cell.stateLab.textColor = UIColor.hexColor(hexValue: 0x97989A)

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == currentSel {
            return
        }
        var status = "ONLINE"
        if indexPath.row == 0 {
            status = "ONLINE"
        } else if indexPath.row == 1 {
            status = "OFFLINE"
        } else if indexPath.row == 2 {
            status = "BUSY"
        }
        SVProgressHUD.show()
        TRNetManager.shared.put_no_lodding(url: URL_Home_State_Changed, pars: ["workStatus" : status]) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                currentSel = indexPath.row
                tableView.reloadData()
                if self.block != nil {
                    self.block!(indexPath.row)
                }
            }else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
            }
        }
        
        
        
        self.isHidden = true
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

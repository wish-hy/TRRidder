//
//  TRHomeBeginSetView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit
import RxCocoa
import RxSwift
class TRHomeBeginSetView: UIView,UITableViewDelegate, UITableViewDataSource {
    
    var height = IS_IphoneX ? 470.0 : 450.0 {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.contentView.frame = CGRect(x: 0, y: Screen_Height - self.height, width: Screen_Width, height: self.height)
            }
        }
    }
    weak var vc : UIViewController?
    var tableView : UITableView!
    var bgView : UIView!
    var contentView : UIView!
    var header : UIView!
    let bag = DisposeBag()
    
    var yuyueType = 1
    var startTime : String = ""
    var endTime : String = ""
    private var data : [TRApplerVehicleInfoModel] = []
    var setModel : TRUserModel = TRUserModel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        if TRTool.isNullOrEmplty(s: TRDataManage.shared.riderModel.id) {
            SVProgressHUD.showInfo(withStatus: "骑手信息获取失败，请重新登录")
        } else {
            let m = TRDataManage.shared.riderModel
            setModel.appoBeginTime = m.appoBeginTime
            setModel.appoEndTime = m.appoEndTime
            setModel.hasAppo = m.hasAppo
            setModel.hasReal = m.hasReal
            setModel.codeName = m.codeName
            setModel.curVehicleId = m.curVehicleId
            setModel.iconUrl = m.iconUrl
            setModel.arId = m.arId
            setModel.arName = m.arName
            setModel.numberplate = m.numberplate
        }
        setupView()
    }
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .black.withAlphaComponent(0.5)
        self.addSubview(bgView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        
        header = UIView()
        header.backgroundColor = .bgColor()
        let infoLab = UILabel()
        infoLab.text = "点击开工，马上开始接单"
        infoLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        infoLab.font = UIFont.trFont(fontSize: 18)
        header.addSubview(infoLab)
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 13, height: 13))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer;
        
        
        let downBtn = UIButton()
        downBtn.setImage(UIImage(named: "shouqi"), for: .normal)
        header.addSubview(downBtn)
        let downLab = UILabel()
        // 收起设置
        downLab.text = "收起"
        downLab.font = UIFont.trFont(fontSize: 12)
        downLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        header.addSubview(downLab)
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44;
        tableView.register(TRHomeBeginSetTableViewCell1.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRHomeBeginSetTableViewCell2.self, forCellReuseIdentifier: "cell2")
        tableView.register(TRHomeBeginSetTableViewCell2.self, forCellReuseIdentifier: "cell3")
        tableView.showsVerticalScrollIndicator = false
        contentView.addSubview(tableView)
        contentView.addSubview(header)
        
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }

        contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: height)
        header.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(52)
        }
        
        infoLab.snp.makeConstraints { make in
            make.centerY.equalTo(downBtn).offset(4)
            make.left.equalTo(16)
        }
        downBtn.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.equalTo(header).offset(20)
            make.right.equalTo(header).inset(30)
        }
        downLab.snp.makeConstraints { make in
            make.top.equalTo(downBtn.snp.bottom).offset(2)
            make.centerX.equalTo(downBtn)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalTo(contentView)
        }
        
        downBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self  else { return }
            
            self.closeView()
        }).disposed(by: bag)
       
    }
   
    func orderSetting(){
        //
        if setModel.curVehicleId.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请选择车辆")
            return
        }
        var pars = [:] as [String : Any]
        if setModel.hasAppo {
//            if setModel.appoEndTime.isEmpty || setModel.appoBeginTime.isEmpty {
//                SVProgressHUD.showInfo(withStatus: "请选择起止时间")
//                return
//            }
            pars = [
                "hasAppo" : setModel.hasAppo,
                "hasReal" : setModel.hasReal,
                "curVehicleId" : setModel.curVehicleId,
//                "appoBeginTime" : setModel.appoBeginTime,
//                "appoEndTime" : setModel.appoEndTime
            ]
        } else {
            pars = [
                "hasAppo" : setModel.hasAppo,
                "hasReal" : setModel.hasReal,
                "curVehicleId" : setModel.curVehicleId
            ]
        }
        
        TRNetManager.shared.put_no_lodding(url: URL_Home_Begin_Set, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let codeModel = TRCodeModel.deserialize(from: dict) else {return}
            if codeModel.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "设置成功")
                let m = TRDataManage.shared.riderModel
//                m.appoBeginTime = setModel.appoBeginTime
//                m.appoEndTime = setModel.appoEndTime
                m.curVehicleId = setModel.curVehicleId
                m.hasAppo = setModel.hasAppo
                m.hasReal = setModel.hasReal
                m.codeName = setModel.codeName
                self.closeView()
            } else {
                SVProgressHUD.showInfo(withStatus: codeModel.exceptionMsg)
            }
        }
        
    }

    
    func addToWindow(){
        let window = UIApplication.shared.delegate!.window as! UIWindow
        window.addSubview(self)
        self.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(window)
        }
    }
    func openView(){
        self.layoutIfNeeded()
        self.layoutSubviews()
        UIView.animate(withDuration: 0.3) {
            self.contentView.frame = CGRect(x: 0, y: Screen_Height - self.height, width: Screen_Width, height: self.height)
        }
        
    }
    func closeView(){
        self.layoutIfNeeded()
        self.layoutSubviews()

        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: self.height)
        }, completion: { _ in
            self.removeFromSuperview()
        })
   
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView()
            view.backgroundColor = .white
            let saveBtn = UIButton()
            saveBtn.setBackgroundImage(UIImage(named: "anniu"), for: .normal)
            saveBtn.setTitle("保存", for: .normal)
            saveBtn.setTitleColor(.white, for: .normal)
            saveBtn.titleLabel?.font = .trBoldFont(fontSize: 18)
        
            view.addSubview(saveBtn)
            saveBtn.snp.makeConstraints { make in
                make.left.right.equalTo(view).inset(16)
                make.top.equalTo(view).offset(40)
                make.bottom.equalTo(view).inset(54)
                make.height.equalTo(46)
            }
            
            saveBtn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self  = self else { return }
                orderSetting()
            }).disposed(by: bag)
            return view;
        } else {
            let view = UIView()
            view.backgroundColor = .bgColor()
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        } else {
            return 86
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRHomeBeginSetTableViewCell1
            cell.setModel = setModel
            return cell
        } else {
            if  indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRHomeBeginSetTableViewCell2
                cell.customSwitch.isOn = setModel.hasReal
                cell.titleLab.text = "抢实时单"
                    cell.type = 0
                    cell.block = {[weak self] x in
                        guard let self  = self else { return }
                        if x == 1 {
                            setModel.hasReal = false
                        } else {
                            setModel.hasReal = true
                        }
                    }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! TRHomeBeginSetTableViewCell2
//                    cell.type = 2
                cell.line.isHidden = true
                cell.titleLab.text = "抢预约单"
                cell.customSwitch.isOn = setModel.hasAppo
                cell.type = 0
                cell.block = {[weak self] x in
                    guard let self  = self else { return }
                    if x == 1 {
                        setModel.hasAppo = false
                    } else {
                        setModel.hasAppo = true
                    }
                }
//                cell.startTime = self.startTime
//                cell.endTime = self.endTime
//                    cell.block = {[weak self]x in
//                        guard let self  = self else { return }
//                        if x == 1 || x == 2 {
//                            self.yuyueType = x
//                            tableView.reloadData()
//                            if x == 1 {
//                                setModel.hasAppo = false
//                                self.height = IS_IphoneX ? 485.0 : 450.0
//                            } else {
//                                setModel.hasAppo = true
//                                self.height = IS_IphoneX ? 555.0 : 520.0
//                            }
//                        } else {
//                            if x == 3 {
//                              let picker = TRDatePicker(frame: .zero)
//                                picker.addToWindow()
//                                picker.openView()
//                                picker.block = {[weak self] (h,m) in
//                                    guard let self  = self  else { return  }
//                                    setModel.appoBeginTime = String(format: "%02d : %02d", h,m)
//                                    self.tableView.reloadData()
//                                }
//                            } else {
//                                let picker = TRDatePicker(frame: .zero)
//                                  picker.addToWindow()
//                                  picker.openView()
//                                  picker.block = {[weak self] (h,m) in
//                                      guard let self = self else { return  }
//                                      setModel.appoEndTime = String(format: "%02d : %02d", h,m)
//                                      self.tableView.reloadData()
//                                  }
//                            }
//                        }
//                    }
                return cell
            }
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            TRNetManager.shared.post_no_lodding(url: URL_Rider_Open_Vehicle, pars: [:]) {[weak self] dict in
                guard let self = self else {return}
                guard let model = TRRidderApplyVehicleSelManage.deserialize(from: dict) else {return}
                if model.code == 1 {
                    model.data.allowVehicleList = model.data.available
                    model.data.notAllowVehicleList = model.data.notAvailable
                    let popView = TRRiderTrafficSelPopView(frame: .zero)
                    popView.bottomView.saveBtn.setTitle("确定", for: .normal)
                    popView.containerModel = model.data
                    popView.contentHeight = Int(Screen_Height / 2)
                    popView.contentView.backgroundColor = .bgColor()
                    popView.addToWindow()
                    popView.openView()
                    popView.block = {[weak self] (vehicle) in
                        guard let self = self  else { return }
                        let m = vehicle as! TRRidderApplyVehicleSelModel
                        setModel.curVehicleId = m.id
                        setModel.iconUrl = m.iconUrl
                        setModel.codeName = m.codeName
                        setModel.arId = m.arId
                        setModel.arName = m.arName
                        setModel.numberplate = m.numberplate
                        tableView.reloadData()
                    }
                    popView.addBlock = {[weak self] in
                        guard let self = self  else { return }
                        popView.closeView()
//                        let editVC = TRRidderVehicleEditViewController()
//                        editVC.hidesBottomBarWhenPushed = true
//                        self.vc?.navigationController?.pushViewController(editVC , animated: true)
                    }
                    
                } else {
                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
                }
            }
            
            
        }
    }
    
   
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

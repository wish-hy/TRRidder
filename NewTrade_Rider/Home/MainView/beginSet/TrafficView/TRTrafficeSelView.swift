//
//  TRTrafficeSelView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/2/19.
//

import UIKit
import RxSwift
import RxCocoa
class TRTrafficeSelView: UIView,UITableViewDelegate, UITableViewDataSource {
    //60 + 46
    var height = Double(60 + 46 + 2 * 80) {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.contentView.frame = CGRect(x: 0, y: Screen_Height - self.height, width: Screen_Width, height: self.height)
            }
        }
    }
    var tableView : UITableView!
    var bgView : UIView!
    var contentView : UIView!
    var header : UIView!
    var saveBtn : UIButton!
    let bag = DisposeBag()
    
    var yuyueType = 1
    var startTime : String = ""
    var endTime : String = ""
    
    var setModel : TRBeginSetModel = TRBeginSetModel()
    
    var currentSel : Int = -1
    var data : [TRApplerVehicleInfoModel] = [] {
        didSet {
            self.height = Double(75 + 46 + data.count * 80 + (IS_IphoneX ? 30 : 15))
        }
    }
    var block : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        header.backgroundColor = .white
        let infoLab = UILabel()
        infoLab.text = "选择开工车辆"
        infoLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        infoLab.font = UIFont.trBoldFont(fontSize: 18)
        header.addSubview(infoLab)
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 13, height: 13))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer;
        
        
        let closeBtn = UIButton()
        closeBtn.setImage(UIImage(named: "close_black"), for: .normal)
        header.addSubview(closeBtn)

        let line = UIView()
        line.backgroundColor = .lineColor()
        header.addSubview(line)

        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44;
        tableView.register(TRTrafficSelCell.self, forCellReuseIdentifier: "cell1")
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        contentView.addSubview(tableView)
        contentView.addSubview(header)
        
        saveBtn = TRFactory.buttonWithCorner(title: "确定", bgColor: .themeColor(), font: .trBoldFont(18), corner: 23)
        contentView.addSubview(saveBtn)
        
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }

        contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: height)
        header.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(60)
        }
        
        infoLab.snp.makeConstraints { make in
            make.top.equalTo(header).offset(17)
            make.centerX.equalTo(header)
        }
        closeBtn.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(infoLab)
            make.right.equalTo(header).inset(16)
        }
        line.snp.makeConstraints { make in
            make.bottom.equalTo(header).inset(5)
            make.left.right.equalTo(header)
            make.height.equalTo(1)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalTo(saveBtn.snp.top).offset(-15)
        }
        saveBtn.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(IS_IphoneX ? 30 : 15)
            make.height.equalTo(46)
        }
        closeBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self else { return  }
            self.closeView()
        }).disposed(by: bag)
        saveBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self else { return }
            if self.block != nil {
                self.block!(currentSel)
            }
            closeView()
        }).disposed(by: bag)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRTrafficSelCell
        
        cell.model = data[indexPath.row]
        if indexPath.row == currentSel {
            cell.isSel = true
        } else {
            cell.isSel = false
        }
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSel = indexPath.row
        tableView.reloadData()
    }
    
   
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TRMineSetBottomView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRMineSetBottomView: UIView {

    var btn : UIButton!
    
    var tipLab : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = .white
        
        btn = UIButton()
        btn.setTitle("退出登录", for: .normal)
        btn.setTitleColor(UIColor.hexColor(hexValue: 0xF93F3F), for: .normal)
        btn.titleLabel?.font = UIFont.trFont(fontSize: 16)
        self.addSubview(btn)
        btn.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        tipLab = UILabel()
        tipLab.text = "保证金申请退款后，不可进行接单任务"
        tipLab.isHidden = true
        tipLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        tipLab.font = UIFont.trFont(fontSize: 12)
        self.addSubview(tipLab)
        
        btn.snp.makeConstraints { make in
            make.top.equalTo(self).offset(12)
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(44)
            
        }
        
        tipLab.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(btn.snp.bottom).offset(3)
        }
    }
    @objc func logoutAction(){
        TRNetManager.shared.userLogoutService {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "退出成功")
                TRTool.saveData(value: "", key: Save_Key_Token)
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let loginController = TRLoginViewController()
                let navController = BasicNavViewController(rootViewController: loginController)
                delegate.window?.rootViewController = navController;
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

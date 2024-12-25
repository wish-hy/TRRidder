//
//  TRMineSettingViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineSettingViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {
    let sectionTitles = ["信息管理","账号安全","其他",""]

    var model : TRUserModel!
    let titleAs = ["个人信息"]
    let titleBs = ["更改手机号码","修改登录密码"]
    let titleCs = ["服务条款" ,"免责声明" ,"关于我们"]
    let titleDs = ["注销账号"]

    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configNavBar()
        configNavTitle(title: "设置")
        configNavLeftBtn()
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRMineSetHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRMineSetTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(self.Nav_Height)
        }
        
        let bottomView = TRMineSetBottomView(frame: .zero)
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(56 + 35 - (IS_IphoneX ? 0 : 25))
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
               let vc = TRMineDetailViewController()
                vc.userModel = model
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let vc = TRChangePhoneOldViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = TRChangePwdViewController()
                self.navigationController?.pushViewController(vc, animated: true)

            }
        } else if indexPath.section == 2 {
            //     let titleCs = ["服务条款" ,"免责声明" ,"关于我们"]

            let vc = TRWebViewController()
            
            if indexPath.row == 0 {
                vc.type = .txt_service
            } else if indexPath.row == 1 {
                vc.type = .txt_disclaimer
            } else if indexPath.row == 2 {
                vc.type = .txt_about
            }
            self.navigationController?.pushViewController(vc , animated: true)
        } else if indexPath.section == 3 {
            let vc = TRCancelAccountViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 10
        }
        return 65
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {return nil}
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRMineSetHeader
        header.titleLab.text = sectionTitles[section]
        return header
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRMineSetTableViewCell
        if indexPath.section == 0 {
            cell.titleLab.text = titleAs[indexPath.row]
            cell.desLab.isHidden = true
            
        } else if indexPath.section == 1 {
            cell.titleLab.text = titleBs[indexPath.row]
            cell.desLab.isHidden = true
            if indexPath.row == 0 {
                cell.desLab.isHidden = false
                cell.desLab.text = model.phone
            }
        }  else if indexPath.section == 2{
            cell.titleLab.text = titleCs[indexPath.row]
            cell.desLab.isHidden = true
        } else {
            cell.titleLab.text = titleDs[indexPath.row]
            cell.desLab.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 3
        }else if section == 3 {
            return 1
        }
        return 0
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

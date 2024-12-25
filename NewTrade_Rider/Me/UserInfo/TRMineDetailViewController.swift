//
//  TRMineDetailViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit
import ZLPhotoBrowser

class TRMineDetailViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    let infoTips = ["头像","姓名","性别","所在地","手机号码","联系地址"]
    var tableView : UITableView!
    var userModel : TRUserModel = TRUserModel()
    
    private var sexList = ["男","女"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configNavBar()
        configNavTitle(title: "个人详情")
        configNavLeftBtn()
        configMainView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    private func configMainView(){
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
        tableView.separatorStyle = .none
        tableView.register(TRMineDetailAddressCell.self, forCellReuseIdentifier: "cell2")
        tableView.register(TRMineDetailHeadTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(navBar!.snp.bottom)
        }
    }
    private func openCalbum(){
        TKPermissionPhoto.auth(withAlert: true , level: .readWrite) { ret in
            if ret {
                let config = ZLPhotoConfiguration.default()
                config.allowEditImage = true
                config.allowSelectGif = false
                config.allowSelectVideo = false
                config.maxSelectCount = 1
                let vc = ZLPhotoPreviewSheet(results: nil)
                vc.showPhotoLibrary(sender: self)
                vc.selectImageBlock = { [weak self] results, isOriginal in
                    guard let `self` = self else { return }
                    var imgs : [UIImage] = []
                    var datas : [Data] = []
                    for m in results {
                        let data = TRTool.compressImage(m.image)
                        imgs.append(m.image)
                        datas.append(data!)
                    }

                    
                    TRNetManager.shared.common_upload_pic(files: datas, URLString: URL_V1_HeadPic_Upload) {[weak self] responseObject in
                        guard let self  = self else { return }
                        guard let picModel  = TRPicModel.deserialize(from: responseObject) else { return }
                        if picModel.code == 1 && !picModel.data.isEmpty {
                            userModel.netLoclImgModel.removeAll()
                            //netName 不必理会
                            userModel.netLoclImgModel.addLocalImg(img: imgs.last!, netName: picModel.data.last!)
                            updateHeadPic()
//                                SVProgressHUD.showSuccess(withStatus: "信息更新成功")
//                                NotificationCenter.default.post(name: .init("loadAccountInfo"), object: nil)
//                                tableView.reloadData()
                        }
                        
                        
                    }
                    
                    
                }
            }
        }

    }
    private func updateHeadPic(){
        let pars = [
            "profilePic" : userModel.netLoclImgModel.getName()
        ]
        let url = URL_Me_Update_Info + "?profilePic=\(userModel.netLoclImgModel.getName())"
        TRNetManager.shared.put_no_lodding(url: url, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "信息更新成功")
                NotificationCenter.default.post(name: .init("loadAccountInfo"), object: nil)
                tableView.reloadData()
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    //更新区域
    private func updateUserAera(addList : [TRAddressModel]){
        var area : String = ""
        for m in addList {
            area = area +  m.name
        }
        let pars = [
            "areaAddress" : area
        ]
        TRNetManager.shared.put_no_lodding(url: URL_Me_Update_Info, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "信息更新成功")
                userModel.areaAddress = area
                tableView.reloadData()
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    
    private func updateUserSex(sex : Int){
        var sexBool = true
        if sex == 0 {
            sexBool = true
        } else {
            sexBool = false
        }
        let pars = [
            "sex" : sexBool
        ] as [String : Any]
        TRNetManager.shared.put_no_lodding(url: URL_Me_Update_Info, pars: pars) {[weak self] dict in
            guard let self = self else {return}
            guard let model = TRCodeModel.deserialize(from: dict) else {return}
            if model.code == 1 {
                SVProgressHUD.showSuccess(withStatus: "信息更新成功")
                userModel.sex = sexBool
                tableView.reloadData()
            } else {
                SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 71
        } else {
            return UITableView.automaticDimension
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openCalbum()
        } else if indexPath.row == 1 {
            let vc = TRModifyInfoViewController()
            vc.type = .name
            vc.userModel = userModel
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            //性别
            let picker = TRSimpleDataPicker(frame: .zero)
            picker.titleLab.text = "选择性别"
             picker.items = sexList
             picker.addToWindow()
             picker.openView()
             picker.block = {[weak self](index) in
                 guard let self = self else { return }
                updateUserSex(sex: index)
             }
        } else if indexPath.row == 3 {
            let vc = TRAddressSelectVC()
            vc.isLimited = false
            vc.block = {[weak self](arr) in
                guard let self = self else { return }
                updateUserAera(addList: arr as! [TRAddressModel])
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            
        } else if indexPath.row == 5 {
            let vc = TRModifyInfoViewController()
            vc.type = .detailAddress
            vc.userModel = userModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.01
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRMineDetailHeadTableViewCell
            cell.netLoclImgModel = userModel.netLoclImgModel
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRMineDetailAddressCell
        cell.titleLab.text = infoTips[indexPath.row]
       

        if indexPath.row == 1 {
            if userModel.getRealName().isEmpty {
                cell.valeLab.text = "请设置昵称"
                cell.valeLab.textColor = .hexColor(hexValue: 0xC6C9CB)
            } else {
                cell.valeLab.text = userModel.getRealName()
                cell.valeLab.textColor = .txtColor()
            }
        } else if indexPath.row == 2 {
            if userModel.sex {
                cell.valeLab.text = "男"
            } else {
                cell.valeLab.text = "女"

            }

        } else if indexPath.row == 3 {
            if userModel.areaAddress.isEmpty {
                cell.valeLab.text = "请选择省份、市、区/县"
                cell.valeLab.textColor = .hexColor(hexValue: 0xC6C9CB)
            } else {
                cell.valeLab.text = userModel.areaAddress
                cell.valeLab.textColor = .txtColor()
            }

        } else if indexPath.row == 4 {
            cell.valeLab.text = userModel.phone
            if userModel.phone.isEmpty {
                cell.valeLab.text = "未获取到手机号"
                cell.valeLab.textColor = .hexColor(hexValue: 0xC6C9CB)
            } else {
                cell.valeLab.text = userModel.phone
                cell.valeLab.textColor = .txtColor()
            }
        } else if indexPath.row == 5 {
            if userModel.residentialAddress.isEmpty {
                cell.valeLab.text = "请输入楼道、楼栋、小区"
                cell.valeLab.textColor = .hexColor(hexValue: 0xC6C9CB)
            } else {
                cell.valeLab.text = userModel.residentialAddress
                cell.valeLab.textColor = .txtColor()
            }

        }
        
        return cell
        
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

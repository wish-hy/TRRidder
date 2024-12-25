//
//  TRBottomReportPopVIew.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit
import RxCocoa
import RxSwift
import ZLPhotoBrowser
class TRBottomReportPopVIew: TRBottomPopBasicView , UITableViewDelegate, UITableViewDataSource {
    var orderModel : TROrderModel!
    var netLocImgModel : NetLocImageModel = NetLocImageModel()
    var type : Int = 1 // 1 抢单 2 待取货 3 配送中
    var tableView : UITableView!
    var selIndex : Int = 0
    var reasonList : [TROrderReasonModel] = [] {
        didSet {
            if reasonList.count > 0 {
                currentReason = reasonList.first
            }
        }
    }
    var state : Int = 0;//0 一行图片  1 2行图片

    weak var viewController : UIViewController!
    var currentReason : TROrderReasonModel? {
        didSet {
            if currentReason!.hasCanCancel {
                currentReason!.hasMustCancel = true
            }
            tableView.reloadData()
        }
    }
    var block : Void_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubView()
    }
    private func openCalbum(_ type : String){
        TKPermissionPhoto.auth(withAlert: true , level: .readWrite) {[self] ret in
            if ret {
                let config = ZLPhotoConfiguration.default()
                config.allowEditImage = true
                config.allowSelectGif = false
                config.allowSelectVideo = false
                config.maxSelectCount = IMG_UP_MAX
                let vc = ZLPhotoPreviewSheet(results: nil)
                
                vc.showPhotoLibrary(sender: viewController)
                vc.selectImageBlock = { [weak self] results, isOriginal in
                    guard let `self` = self else { return }
                    var imgs : [UIImage] = []
                    var datas : [Data] = []
                    for m in results {
                        //                        let data = m.image.jpegData(compressionQuality: 0.2)
                        let data = TRTool.compressImage(m.image)
                        imgs.append(m.image)
                        datas.append(data!)
                    }
                    TRNetManager.shared.common_upload_pic(files: datas, URLString: URL_V1_Exception_Upload) {[weak self] response in
                        guard let self = self else {return}
                        guard let picModel = TRPicModel.deserialize(from: response) else { return }
                        
                        if  picModel.code == Net_Code_Success && !picModel.data.isEmpty {
                            let nameArr = picModel.data
                            netLocImgModel.addLocalImgArr(imgs: imgs, netNames: nameArr)
                            tableView.reloadData()
                        } else {
                            SVProgressHUD.showInfo(withStatus: "图片上传出错")
                        }
                    }
                    
                }
            }
        }
        
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
        tableView.register(TRBottomReportReasonCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRBottomReportPicCell.self, forCellReuseIdentifier: "cell2")

        tableView.register(TRBottomReportPopHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRBottomReportPopFooter.self, forHeaderFooterViewReuseIdentifier: "footer")

        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(contentView)
        }
        whiteView.snp.makeConstraints { make in
            make.left.right.equalTo(tableView)
            make.bottom.equalTo(contentView)
            make.top.equalTo(tableView).offset(15)
        }
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 109
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if type == 3 {
            return 95
        }
        return 134
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        } else if indexPath.row == 1 {
            return  UITableView.automaticDimension
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as! TRBottomReportPopFooter
        if type == 3 {
            footer.hiddenCancelOrder = true
        }
        footer.siCancel = currentReason!.hasCanCancel
        footer.cancelBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self  else { return }
            closeView()
        }).disposed(by: footer.bag)
        footer.sureBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self else { return }
            if block != nil {block!()}
        }).disposed(by: footer.bag)
        footer.qxddBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self = self else { return }
            if currentReason!.hasCanCancel {
                SVProgressHUD.showInfo(withStatus: "此原因要取消订单")
                return
            }
            currentReason!.hasCanCancel = !currentReason!.hasCanCancel
            tableView.reloadData()
        }).disposed(by: footer.bag)
        return footer
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //异常原因
            let view = TRSimpleDataPicker(frame: .zero)
            var datas : [String] = []
            for m in reasonList {
                datas.append(m.exceptionReason)
            }
            view.items = datas
            view.index = selIndex
            view.addToWindow()
            view.openView()
            view.block = {[weak self] (index) in
                guard let self  = self  else { return }
                selIndex = index
                currentReason = reasonList[index]
                tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRBottomReportReasonCell
            if currentReason != nil {
                cell.reasonLab.text = currentReason!.exceptionReason
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRBottomReportPicCell
        cell.netLocModel = netLocImgModel

        cell.chooseImgV.block = {[weak self] in
            guard let self = self else { return }
            openCalbum(orderModel.orderNo)
        }

        cell.chooseImgV.heightChangedBlock = {[weak self] in
            guard let self  = self  else { return }
            //处理高度的 现在只有一行
//            if netLocImgModel.localImgArr.count >= 4 {
//                if state == 0 {
//                    state = 1
//                    let space = (4 - 1) * 10
//                    let w = (Screen_Width - 32.0 - 30.0) / 4.0
//                    self.actionHeight = Int(385 + 80 - (IS_IphoneX ? 0 : 25) + w)
//                    tableView.reloadData()
//                }
//            } else {
//                if state == 1 {
//                    state = 0
//                    self.actionHeight = 385 + 80 - (IS_IphoneX ? 0 : 25)
//                    tableView.reloadData()
//                }
//            }
        }
        
        return cell
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

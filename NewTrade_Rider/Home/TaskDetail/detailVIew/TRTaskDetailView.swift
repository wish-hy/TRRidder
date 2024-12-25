//
//  TRTaskDetailView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/7.
//

import UIKit

class TRTaskDetailView: UIView,UITableViewDataSource,UITableViewDelegate {

    
    weak var vc : TRTaskDetailViewController!
    var tableView : UITableView!

    var type : Int = 1
    
    var model : TROrderModel? {
        didSet {
            if model == nil{
                return
            }
            //   // MALL LOCAL_DEL_GOODS
            tableView.reloadData()
        }
    }
    //携带 去还是送 1 取 2 送 ， 导航方式 1 walk 2 rider 3 drive
    var block : Int_Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false

        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        tableView.register(TRTaskDetailTableViewCell1.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRDoneDetailTableViewCell.self, forCellReuseIdentifier: "done_cell1")
        
        // TRTaskDetailOrderNoCell
        tableView.register(TRTaskDetailOrderNoCell.self, forCellReuseIdentifier: "orderNo_Cell")
        tableView.register(TRPickupTableViewCell1.self, forCellReuseIdentifier: "pick_cell1")

        tableView.register(TRTaskDetailDelMethodCell.self, forCellReuseIdentifier: "del_cell")
        
        tableView.register(TRTaskDetailTableViewCell2.self, forCellReuseIdentifier: "cell2")
        tableView.register(TRTaskDetailTableViewCell3.self, forCellReuseIdentifier: "cell3")
        
        tableView.register(TROrderPatchOrderCell.self, forCellReuseIdentifier: "patchOrder")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
        
        tableView.register(TRTaskDetailItemCell.self, forCellReuseIdentifier: "item")
        
        
        tableView.register(TRTaskDetailTotalItemCell.self, forCellReuseIdentifier: "totalItem")

        //  TRTaskDetailRemarkHeader
        tableView.register(TRTaskDetailRemarkHeader.self, forHeaderFooterViewReuseIdentifier: "remarkHeader")

        tableView.register(TRTaskDetailTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        
        tableView.register(TRTaskDetailItemFooter.self, forHeaderFooterViewReuseIdentifier: "itemFooter")
        
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")

        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    //使用事件分发
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//
//        if point.y <= (Screen_Height - 470 * APP_Scale - tableView.contentOffset.y) {
//            let view = self.vc.mapView as! TRMapView
//            let  locBtnPoint = self.convert(point, to: view.locBtn)
//            let refreshPoint = self.convert(point, to: view.refreshBtn)
//            let footerPoint = self.convert(point, to: view.footerBtn)
//            let elePoint = self.convert(point, to: view.eleBtn)
//            let carPoint = self.convert(point, to: view.carBtn)
//            if (view.locBtn.point(inside: locBtnPoint, with: event)){
//                return view.locBtn
//            }
//            if (view.carBtn.point(inside: carPoint, with: event)){
//                return view.carBtn
//            }
//            if (view.eleBtn.point(inside: elePoint, with: event)){
//                return view.eleBtn
//            }
//            if (view.footerBtn.point(inside: footerPoint, with: event)){
//                return view.footerBtn
//            }
//            if (view.refreshBtn.point(inside: refreshPoint, with: event)){
//                return view.refreshBtn
//            }
//            return self.vc.mapView
//
//        }
//            return super.hitTest(point, with: event)
//
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        //第四区 都是子订单 如果没有就把高度改了
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            if !model!.deliveryType.elementsEqual("LOCAL_DEL_GOODS") {
                return mallItemInfo.count
            }
            return itemInfo.count
        } else if section == 2 {
            if model!.deliveryType.elementsEqual("MALL") {
                return model!.orderItemList.count

            }
            return 1
        } else if section == 4 {
            if !model!.deliveryType.elementsEqual("LOCAL_DEL_GOODS") {
                return mallOrderInfo.count
            }
            return orderInfo.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRTaskDetailTableViewHeader
        if section == 1 {
            header.nameLab.text = "物品信息"
            header.numLab.isHidden = true
            header.priceLab.isHidden = true
            header.unitLab.isHidden = true
            header.numLab.text = "\(model!.orderItemList.count)份"
            header.priceLab.text = model!.deliverAmount
            return header
        } else if section == 4 {
            header.nameLab.text = "订单信息"
            header.numLab.isHidden = true
            header.priceLab.isHidden = true
            header.unitLab.isHidden = true
            return header
        } else if section == 2 {
            if !model!.remark.isEmpty {
                let remarkHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "remarkHeader") as! TRTaskDetailRemarkHeader
                remarkHeader.remarkLab.text = model!.remark
                return remarkHeader
            }
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 4 {
            return 47
        } else if section == 2 {
            //备注
            if model!.remark.isEmpty {
                return 0.01
            } else {
                return UITableView.automaticDimension
            }
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            if model!.deliveryType.elementsEqual("MALL") {
                let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "itemFooter") as! TRTaskDetailItemFooter
                if model!.orderItemList.count == 0 {
                    footer.itemLab.text = "1"

                } else {
                    footer.itemLab.text = "\(model!.orderItemList.count)"
                }
                return footer
            }
            
        }
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
        footer?.contentView.backgroundColor = .bgColor()
        return footer
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 || section == 3{
            return 0.01
        } else if section == 2 {
            if !model!.deliveryType.elementsEqual("LOCAL_DEL_GOODS") {
                return UITableView.automaticDimension
            }
        }
        
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 {
            if model!.subOrder.subOrderNo.isEmpty {
                return 0.01
            }
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {

            if type == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRTaskDetailTableViewCell1
                cell.model = model
                cell.block = {[weak self](nav) in
                    guard let self  = self  else { return }
                    if block != nil {
                        block!(nav, type)
                    }
                }
                return cell
            } else if type == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "pick_cell1", for: indexPath) as! TRPickupTableViewCell1
                if model != nil{
                    cell.model = model
                }
                cell.block = {[weak self](nav) in
                    guard let self  = self  else { return }
                    if block != nil {
                        block!(nav, type)
                    }
                }
                return cell
            } else if type == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "done_cell1", for: indexPath) as! TRDoneDetailTableViewCell
                if model != nil{
                    cell.model = model
                }
                cell.block = {[weak self](nav) in
                    guard let self  = self  else { return }
                    if block != nil {
                        block!(nav, type)
                    }
                }
                return cell
            }
            //不会出现
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TRTaskDetailTableViewCell1
            return cell
           
        } else if indexPath.section == 1 {
            //
            let icell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)  as! TRTaskDetailTableViewCell3
            var item = ""
            if !model!.deliveryType.elementsEqual("LOCAL_DEL_GOODS") {
                item = mallItemInfo[indexPath.row]
            } else {
                item = itemInfo[indexPath.row]
            }
            icell.nameLab.text = item
            if item.elementsEqual("物品类型") {
                icell.detailLab.text = model!.ptName
            } else if item.elementsEqual("物品包装") {
                icell.detailLab.text = model!.packTypeName
            } else if item.elementsEqual("物品总重量") || item.elementsEqual("物品重量"){
                var weigh = ""
                if model!.weight >= 1000 {
                    weigh = "\(model!.weight / 1000)kg"
                } else {
                    weigh = "\(model!.weight)g"
                }
                icell.detailLab.text = weigh
            } else if item.elementsEqual("物品总体积") {
                icell.detailLab.text = model!.totalVolume + "立方米"
            } else if item.elementsEqual("物品总件数") {
                icell.detailLab.text = model!.totalCount.isEmpty ? "1" : model!.totalCount
            } else if item.elementsEqual("最大件尺寸") {
                icell.detailLab.text = String.init(format: "长：%@米；高：%@米", model!.maxLength, model!.maxHeight)
            }
            return icell
        } else if indexPath.section == 2 {
            if model!.deliveryType.elementsEqual("MALL") {
                let mCell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! TRTaskDetailItemCell
                let item = model!.orderItemList[indexPath.row]
                mCell.titleLab.text = item.productName
                mCell.numLab.text = "X\(item.num)"
                if item.weight < 1000 {
                    mCell.snsLab.text = "规格：\(item.weight)g"
                } else {
                    var price =  Double(item.weight)
                    mCell.snsLab.text = String.init(format: "规格：%.2fkg ", price / 1000.00)
                }
                mCell.itemImgV.sd_setImage(with: URL.init(string: item.productPicUrl), placeholderImage: Net_Default_Img)
                mCell.picDidBlock  = {[weak self] index in
                    guard let self = self else {return}
                    let previewController = TRImagePreviewController(images: [item.productPicUrl] ,currentIndex: indexPath.row)
                    previewController.modalPresentationStyle = .fullScreen
                    TRTool.getCurrentWindow()?.rootViewController!.present(previewController, animated: true)
                }
                return mCell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalItem", for: indexPath)  as! TRTaskDetailTotalItemCell
            cell.goodInfoUrls = model!.goodInfoUrls

            return cell
        } else if indexPath.section == 3 {

            let patchCell = tableView.dequeueReusableCell(withIdentifier: "patchOrder", for: indexPath) as! TROrderPatchOrderCell
            if model!.subOrder.subOrderNo.isEmpty {
                //不存在
                patchCell.bgView.isHidden = true
            } else {
                patchCell.bgView.isHidden = false
                patchCell.model = model!.subOrder
            }
            return patchCell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! TRTaskDetailTableViewCell3

            cell.type = 0
            var item = ""
            if model!.deliveryType.elementsEqual("MALL") {
                item = mallOrderInfo[indexPath.row]
            } else {
                item = orderInfo[indexPath.row]
            }
            cell.nameLab.text = item
            if item.elementsEqual("订单类型") {
                cell.detailLab.text = " \(model!.ptName) "
            } else if item.elementsEqual("订单重量") {
                if model!.weight > 1000 {
                    cell.detailLab.text = String.init(format: " %.2fg ", model!.weight / 1000)
                } else {
                    cell.detailLab.text = " \(model!.weight)g "
                }
            } else if item.elementsEqual("订单编号") {
                let oCell = tableView.dequeueReusableCell(withIdentifier: "orderNo_Cell", for: indexPath) as! TRTaskDetailOrderNoCell
                oCell.detailLab.text = model!.orderNo
                return oCell
            } else if item.elementsEqual("配送方式") {
                let mCell = tableView.dequeueReusableCell(withIdentifier: "del_cell", for: indexPath) as! TRTaskDetailDelMethodCell
                //先根据骑手区分订单 是否是专送
                if model!.deliveryType.elementsEqual("LOCAL_DEL_GOODS") {
                    mCell.detailLab.text = model!.delGoodsMethodDesc
                    mCell.detailLab.textColor = .txtColor()
                    mCell.specView.isHidden = true
                } else {
//                    if model!.riderTypeDesc.elementsEqual("普通") {
//                        mCell.detailLab.text = "专员配送"
//                        mCell.detailLab.textColor = .txtColor()
//                        mCell.specView.isHidden = true
//                    } else {
//                        mCell.detailLab.text = "专人直达"
//                        mCell.detailLab.textColor = .hexColor(hexValue: 0xD87043)
//                        mCell.specView.isHidden = false
//                    }
                    mCell.detailLab.text = model?.riderTypeDesc
                    mCell.specView.isHidden = true
                }
                return mCell
            } else if item.elementsEqual("支付方式") {
                cell.detailLab.text = model!.payType
            } else if item.elementsEqual("下单时间") {
                cell.detailLab.text = model!.createTime
            } else if item.elementsEqual("发票信息") {
                //发票信息
                cell.detailLab.text = "-"
            } else if item.elementsEqual("小费") {
                cell.detailLab.text = "¥" + model!.memberTipAmount
            } else if item.elementsEqual("保价费") {
                cell.detailLab.text = "¥" + model!.insureAmount
            } else if item.elementsEqual("期望送达") {
                cell.detailLab.text = "" //model!.senderRemark
            } else if item.elementsEqual("配送费") {
                cell.detailLab.text =  "¥" + model!.deliverAmount
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        return cell
    }
  
   

    
    



    
    let mallOrderInfo = ["订单编号",  "下单时间", "配送方式","配送费", "小费",  "支付方式"]
    
    let orderInfo = ["订单编号", "下单时间", "配送方式", "配送费", "小费", "保价费", "支付方式"]

    
    
    let mallItemInfo = ["物品类型","物品重量"]
    let itemInfo = ["物品类型","物品包装","物品总重量","物品总体积","物品总件数","最大件尺寸"]
//    var mallPayInfo = [" 送建材 ", " 约50kg ", "886455036687", "专员配送", "无备注信息", "-", "在线支付", "2023-07-05 12:30:59"]
//    var payInfo = [" 送建材 ", " 约50kg ", "886455036687", "专员配送", "无备注信息", "-", "在线支付", "2023-07-05 12:30:59"]


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

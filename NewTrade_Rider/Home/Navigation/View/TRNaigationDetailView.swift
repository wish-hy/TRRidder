//
//  TRNaigationDetailView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/14.
//

import UIKit

class TRNaigationDetailView: UIView,UITableViewDataSource,UITableViewDelegate{
    
    //1 取 2 送
    var nagType : Int = 1
    var order : TROrderModel!
    weak var vc : TRNavigationViewController!
    var tableView : UITableView!
    var navBlock : Void_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = .white
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.register(TRNavLineTableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.showsVerticalScrollIndicator = false
        tableView.register(TRNavLineHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TRNavLineFooter.self, forHeaderFooterViewReuseIdentifier: "footer")

        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
    }
//    //使用事件分发
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        
//         if point.y <= (Screen_Height -  470 * APP_Scale - tableView.contentOffset.y) {
//             let view = self.vc.mapView as! TRMapView
//             let  locBtnPoint = self.convert(point, to: view.locBtn)
//             let refreshPoint = self.convert(point, to: view.refreshBtn)
//             let footerPoint = self.convert(point, to: view.footerBtn)
//             let elePoint = self.convert(point, to: view.eleBtn)
//             let carPoint = self.convert(point, to: view.carBtn)
//             if (view.locBtn.point(inside: locBtnPoint, with: event)){
//                 return view.locBtn
//             }
//             if (view.carBtn.point(inside: carPoint, with: event)){
//                 return view.carBtn
//             }
//             if (view.eleBtn.point(inside: elePoint, with: event)){
//                 return view.eleBtn
//             }
//             if (view.footerBtn.point(inside: footerPoint, with: event)){
//                 return view.footerBtn
//             }
//             if (view.refreshBtn.point(inside: refreshPoint, with: event)){
//                 return view.refreshBtn
//             }
//             return self.vc.mapView
//             
//         }
//             return super.hitTest(point, with: event)
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TRNavLineHeader
            return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
   
        return 100
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
     
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as! TRNavLineFooter
        footer.navBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            if navBlock != nil {
                navBlock!()
            }
        }).disposed(by: footer.bag)
        return footer
    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//  
//        return 0.01
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRNavLineTableViewCell
        
        if nagType == 1 {
            //取
            cell.type = 0
            cell.numLab.isHidden = true
            cell.nameLab.text = order.senderAddress
            cell.locLab.text = order.senderAreaAddress
        } else {
            //送
            cell.type = 1
            cell.numLab.isHidden = false
            cell.nameLab.text = order.receiverAddress
            cell.locLab.text = order.receiverAreaAddress
        }
        return cell
    }
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let y = scrollView.contentOffset.y
//        if y <= -10 {
//            scrollView.setContentOffset(CGPoint(x: 0, y: 230), animated: true)
//        } else if y >= -100 && y < 90 {
//            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//
//        }
//
//    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        let y = scrollView.contentOffset.y
//        if y <= -10 {
//            scrollView.setContentOffset(CGPoint(x: 0, y: 230), animated: true)
//        } else if y >= -100 && y < 90 {
//            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//
//        }
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

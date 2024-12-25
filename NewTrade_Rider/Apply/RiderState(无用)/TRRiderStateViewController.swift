//
//  TRRiderStateViewController.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit
import RxSwift
import RxCocoa
enum RiderManageState {
    case toBeReview
    case toBeSign
    case toBeTrain
    case duty //已上岗
}
class TRRiderStateViewController: BasicViewController{

    var state : RiderManageState?
    var bar : TRRiderStateBar!
    var header : TRRiderStateHeader!
    var bottom2View : TRBottomButton2View!
    var bottom1View : TRBottomButton1View!
//    var reviewView : TRRiderStateReviewView!
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        coustomTopView()
        header = TRRiderStateHeader(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 233))
        
        var index = 0
        if state == .toBeReview {
            index = 0
            bar.titleLab.text = "骑手待审核"
        } else if state == .toBeSign {
            index = 1
            bar.titleLab.text = "骑手待签约"
            header.progressView.fixTitle("已审核", index: 0)
        } else if state == .toBeTrain {
            index = 2
            bar.titleLab.text = "骑手待培训"
            header.progressView.fixTitle("已审核", index: 0)
            header.progressView.fixTitle("已签约", index: 1)
        } else if state == .duty {
            bar.titleLab.text = "骑手上岗信息"

            header.progressView.fixTitle("已审核", index: 0)
            header.progressView.fixTitle("已签约", index: 1)
            header.progressView.fixTitle("已培训", index: 2)
            header.progressView.fixTitle("已上岗", index: 3)
            index = 3
        }
        header.progressView.progress = index
        if state == .toBeReview {
            coustomBottom2View()
            let reviewView = TRRiderStateReviewView(frame: .zero)
            reviewView.tableView.tableHeaderView = header
            self.view.addSubview(reviewView)
            
            reviewView.snp.makeConstraints { make in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.view).offset(Nav_Height)
                make.bottom.equalTo(bottom2View.snp.top)
            }
            
        } else if (state == .toBeSign){
            coustomBottom1View()
            bottom1View.saveBtn.setTitle("发送签约提醒", for: .normal)
            let signView = TRRiderStateSignView(frame: .zero)
            signView.tableView.tableHeaderView = header
            self.view.addSubview(signView)
            
            signView.snp.makeConstraints { make in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.view).offset(Nav_Height)
                make.bottom.equalTo(bottom1View.snp.top)
            }
            
        } else if (state == .toBeTrain) {
            coustomBottom1View()
            let trainView = TRRiderStateTrainView(frame: .zero)
            bottom1View.saveBtn.setTitle("提交培训结果", for: .normal)
            trainView.tableView.tableHeaderView = header
            self.view.addSubview(trainView)
            
            trainView.snp.makeConstraints { make in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.view).offset(Nav_Height)
                make.bottom.equalTo(bottom1View.snp.top)
            }
        } else if (state == .duty){
            coustomBottom2View()
            bottom2View.leftBtn.setTitle("解约专送骑手", for: .normal)
            bottom2View.rightBtn.setTitle("签约专送骑手", for: .normal)
            bottom2View.rightBtn.setTitleColor(.themeColor(), for: .normal)
            bottom2View.rightBtn.backgroundColor = .white
            bottom2View.rightBtn.layer.borderColor = UIColor.lightThemeColor().cgColor
            bottom2View.rightBtn.layer.borderWidth = 1
            let dutyView = TRRiderStateDutyView(frame: .zero)
            dutyView.tableView.tableHeaderView = header
            self.view.addSubview(dutyView)
            
            dutyView.snp.makeConstraints { make in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.view).offset(Nav_Height)
                make.bottom.equalTo(bottom2View.snp.top)
            }
        }
       
    }
    private func coustomBottom2View(){
        bottom2View = TRBottomButton2View(frame: .zero)
        bottom2View.backgroundColor = .white
        self.view.addSubview(bottom2View)
        bottom2View.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
    }
    private func coustomBottom1View(){
        bottom1View = TRBottomButton1View(frame: .zero)
        bottom1View.backgroundColor = .white
        self.view.addSubview(bottom1View)
        bottom1View.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
        }
    }
    private func coustomTopView(){
//        let topImgV = UIImageView(image: UIImage(named: "rider_state_top_bg"))
//        topImgV.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 182.0)
//        self.view.addSubview(topImgV)
        
        bar = TRRiderStateBar(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Nav_Height))
        
        self.view.addSubview(bar)
        bar.backBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
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

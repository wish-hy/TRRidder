//
//  TRHistoryOrderViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxSwift
import RxCocoa
class TRHistoryOrderViewController: BasicViewController {

    var mainView : TRHistoryOrderMainVIew!
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        configHeader()
        setupMainView()
        
        configNavBar()
        configNavLeftBtn()
        configNavTitle(title: "历史订单")
    }
    private func setupMainView(){
        mainView = TRHistoryOrderMainVIew(frame: .zero)
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height + 44)
        }
    }
    private func configHeader(){
        let header = TRHistoryOrderHeader(frame: .zero)
        self.view.addSubview(header)
        header.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.height.equalTo(44)
        }
        
        header.moneyOrderBtn.rx.tap.subscribe(onNext:{[weak self] in
            let view = TROrderMonthPicker(frame: .zero)
            view.offsetY = self!.Nav_Height + 54
            view.addToWindow()
            view.openView()
        }).disposed(by: bag)
        header.todayOrderBtn.rx.tap.subscribe(onNext:{[weak self] in
            let view = TROrderDatePickView(frame: .zero)
            view.offsetY = self!.Nav_Height + 54
            view.addToWindow()
            view.openView()
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

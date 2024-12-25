//
//  TROrderPayMethodView.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/10/9.
//

import UIKit

class TROrderPayMethodView: UIView {

    var wxpayView : TROrderPayMethodSubView!
    var alipayView : TROrderPayMethodSubView!
    var ylpayView : TROrderPayMethodSubView!

    var block : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    @objc func updateView(btn :TROrderPayMethodSubView){
        wxpayView.selImgV.image = UIImage(named: "loaction_nor")
        alipayView.selImgV.image = UIImage(named: "loaction_nor")
        ylpayView.selImgV.image = UIImage(named: "loaction_nor")
        btn.selImgV.image = UIImage(named: "address_default")

        if block != nil {
            self.block!(btn.tag - 1000)
        }
    }
    private func setupView(){
        wxpayView = TROrderPayMethodSubView(frame: .zero)
        wxpayView.tag = 1000 + 1
        wxpayView.imgV.image = UIImage(named: "pay_wx")
        wxpayView.selImgV.image = UIImage(named: "address_default")
        wxpayView.titleLab.text = "微信支付"
        self.addSubview(wxpayView)
        
        alipayView = TROrderPayMethodSubView(frame: .zero)
        alipayView.tag = 1000 + 2
        alipayView.imgV.image = UIImage(named: "pay_zfb")
        alipayView.selImgV.image = UIImage(named: "loaction_nor")
        alipayView.titleLab.text = "支付宝支付"
        self.addSubview(alipayView)
        
        //银联支付先取消
        ylpayView = TROrderPayMethodSubView(frame: .zero)
        ylpayView.isHidden = true
        ylpayView.tag = 1000 + 3
        ylpayView.imgV.image = UIImage(named: "pay_yl")
        ylpayView.selImgV.image = UIImage(named: "loaction_nor")
        ylpayView.titleLab.text = "银联支付"
        self.addSubview(ylpayView)
        let h = 168 / 3
        wxpayView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(h)
        }
        alipayView.snp.makeConstraints { make in
            make.left.right.equalTo(wxpayView)
            make.top.equalTo(wxpayView.snp.bottom)
            make.height.equalTo(h)
        }
//        ylpayView.snp.makeConstraints { make in
//            make.left.right.equalTo(wxpayView)
//            make.top.equalTo(alipayView.snp.bottom)
//            make.height.equalTo(h)
//        }
        
        wxpayView.addTarget(self, action: #selector(updateView(btn: )), for: .touchUpInside)
        alipayView.addTarget(self, action: #selector(updateView(btn: )), for: .touchUpInside)
        ylpayView.addTarget(self, action: #selector(updateView(btn: )), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

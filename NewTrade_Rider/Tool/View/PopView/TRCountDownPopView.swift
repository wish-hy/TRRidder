//
//  TRCountDownPopView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit
import RxCocoa
import RxSwift
class TRCountDownPopView: TRPopBaseView {

    
    var cancelBtn : UIButton!
    var tipLab : UILabel!
    var numLab : UILabel!
    var progressImagV : UIImageView!
    
    var time = 1
    let bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubView()
        
    }
    private func setupTimer(){
        TRGCDTimer.share.createTimer(withName: "countDown", timeInterval: 1, queue: .main, repeats: true) {
            
            self.time += 1
            if self.time <= 0 {
                if self.suceBlock != nil {
                    self.suceBlock!(1)
                }
                self.removeFromSuperview()
                TRGCDTimer.share.destoryTimer(withName: "countDown")
            } else {
                self.numLab.text = "\(self.time)"
            }
        }
    }
    private func configSubView(){
        contentView.backgroundColor = .clear
        let bgImgV = UIImageView()
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.isUserInteractionEnabled = true
        bgImgV.image = UIImage(named: "countDownBG")
        contentView.addSubview(bgImgV)
        
        progressImagV = UIImageView()
        progressImagV.image = UIImage(named: "loading")
        bgImgV.addSubview(progressImagV)
        
        cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(named: "cancel"), for: .normal)
        bgImgV.addSubview(cancelBtn)
        
        numLab = UILabel()
        numLab.text =  "1"
        numLab.textColor = UIColor.hexColor(hexValue: 0x13D066)
        numLab.font = UIFont.trBoldFont(fontSize: 43)
        bgImgV.addSubview(numLab)
        
        tipLab = UILabel()
        tipLab.text = "正在抢单中，请耐心等待…"
        tipLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        tipLab.font = UIFont.trFont(fontSize: 16)
        bgImgV.addSubview(tipLab)
        
        bgImgV.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(0)
            make.top.bottom.equalTo(contentView)
            make.height.equalTo(273 * (Screen_Width - 64) / 302)
        }
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImgV)
            make.bottom.equalTo(bgImgV.snp.top)
            make.height.width.equalTo(38)
        }
        
        progressImagV.snp.makeConstraints { make in
            make.centerX.equalTo(bgImgV)
            make.bottom.equalTo(bgImgV).offset(-58)
            make.width.height.equalTo(82)
        }
        numLab.snp.makeConstraints { make in
            make.center.equalTo(progressImagV)
        }
        tipLab.snp.makeConstraints { make in
            make.centerX.equalTo(bgImgV)
            make.bottom.equalTo(bgImgV).inset(20)
        }
        
        cancelBtn.rx.tap.subscribe(onNext:{[weak self] in
            guard let self  = self  else { return  }
            TRGCDTimer.share.destoryTimer(withName: "countDown")
            if self.cancelBlock != nil {
                self.cancelBlock!(0)
            }
            self.removeFromSuperview()
        }).disposed(by: bag)
        
        startAnimation()
    }
    func successAction(){
        if suceBlock != nil {
            suceBlock!(1)
        }
        self.removeFromSuperview()
    }
    func failAction(){
        if cancelBlock != nil {
            cancelBlock!(0)
        }
        self.removeFromSuperview()
    }
    override func addToWindow() {
        super.addToWindow()
        setupTimer()
    }

    private func startAnimation(){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
            self.progressImagV.transform = self.progressImagV.transform.rotated(by: CGFloat(Double.pi))
        }) { finished in
            self.startAnimation()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

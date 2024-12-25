//
//  TRLocAddressSelView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/6.
//

import UIKit

class TRLocAddressSelView: UIView {
    
    var proLab : UILabel!
    var cityLab : UILabel!
    var disLab : UILabel!
    var streetLab : UILabel!
    
    var block : Int_Block?

    private var las : [UILabel] = []
    
    var items : [TRAddressModel] = [] {
        didSet {
            if items.count >= 4 {
                isEnd = true
            } else {
                isEnd = false
            }
            resetLabs()
            
        }
    }
    var titles = ["请选择省份","请选择城市","请选择区/县","请选择街道/乡镇"]
    var isEnd : Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func resetLabs(){
        for lab in las {
            lab.text = "A"
            lab.textColor = .white
        }
        if items.count > 1 {
            for i in 0...items.count - 1 {
                let item = items[i]
                las[i].text = item.name
                las[i].textColor = .txtColor()
            }
        } else if items.count == 1 {
            las[0].text = items[0].name
            las[0].textColor = .txtColor()
        }
        
        if items.count < 4 {
            las[items.count].text = "请选择"
            las[items.count].textColor = .hexColor(hexValue: 0x2C96FF)
        }
        
        
    }
    
    private func setupView(){
        proLab = TRFactory.labelWith(font: .trFont(14), text: "", textColor: .txtColor(), superView: self)
        proLab.tag = 1000
        proLab.numberOfLines = 0
        
        cityLab = TRFactory.labelWith(font: .trFont(14), text: "", textColor: .txtColor(), superView: self)
        cityLab.tag = 1001
        cityLab.numberOfLines = 0
        
        disLab = TRFactory.labelWith(font: .trFont(14), text: "", textColor: .txtColor(), superView: self)
        disLab.tag = 1002
        disLab.numberOfLines = 0
        
        streetLab = TRFactory.labelWith(font: .trFont(14), text: "", textColor: .txtColor(), superView: self)
        streetLab.tag = 1003
        streetLab.numberOfLines = 0
        
        
        las = [proLab, cityLab, disLab, streetLab]
//        las.snp.makeConstraints { make in
//            make.top.equalTo(self).offset(15)
//            make.bottom.equalTo(self)
//            make.height.greaterThanOrEqualTo(35)
//        }
//        las.snp.distributeViewsAlong(axisType: 0, fixedSpacing: 12, leadSpacing: 16, tailSpacing: 16)
                
        for lab in las {
            lab.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer()
            tapGes.addTarget(self, action: #selector(labTapAction))
            lab.addGestureRecognizer(tapGes)
        }
        
        
    }
    @objc func labTapAction(gesture : UITapGestureRecognizer){
        guard let view  = gesture.view else { return }
        let index = view.tag - 1000
        for i in index...las.count - 1 {
            let lab = las[i]
            if i == index {
                lab.text = "请选择"
                lab.textColor = .hexColor(hexValue: 0x2C96FF)
            } else {
                lab.text = "A"
                lab.textColor = .white
            }
        }
        if block != nil {
            block!(index)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

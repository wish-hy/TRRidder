//
//  TRRiderAddHeader.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRRiderAddHeader: UIView {

    var progressView : TRAddStepView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        let bgView = UIImageView()
        bgView.contentMode = .scaleAspectFill
        self.addSubview(bgView)
        
        let v = TRFactory.imageViewWith(image: UIImage(named: "store_top_func_bg"), mode: .scaleAspectFill, superView: self)
        v.trCorner(10)
        self.addSubview(v)
        progressView = TRAddStepView(frame: .zero)
        progressView.titles = ["骑手信息","证件信息","车辆信息"]
        self.addSubview(progressView)
        progressView.progress = 0
        
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        v.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(206)
            make.height.equalTo(90)
        }
        progressView.snp.makeConstraints { make in
            make.left.right.equalTo(bgView)
            make.centerY.equalTo(v)
        }
    }
    
    func xxView()->UIView{
        let layerView = UIView()
        layerView.frame = CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 102)
        // strokeCode
        let borderLayer1 = CALayer()
        borderLayer1.frame = layerView.bounds
        borderLayer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layerView.layer.addSublayer(borderLayer1)
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.85).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        bgLayer1.locations = [0, 0.45, 0.76, 1]
        bgLayer1.frame = CGRect(x: 1, y: 1, width: 341, height: 100)
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 0.28, y: 0.28)
        layerView.layer.addSublayer(bgLayer1)
        
        return layerView
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

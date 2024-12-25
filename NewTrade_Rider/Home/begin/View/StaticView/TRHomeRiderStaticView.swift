//
//  TRHomeRiderStaticView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/16.
//

import UIKit

class TRHomeRiderStaticView: UIView {

    var incomeView : TRHomeRiderStaticSubView!
    var orderNumView : TRHomeRiderStaticSubView!
    var timeView : TRHomeRiderStaticSubView!
    var scoreView : TRHomeRiderStaticSubView!
    
    var staticsModel : TRRiderStaticsModel? {
        didSet {
            guard let staticsModel = staticsModel else { return }
            let incomStr = String.init(format: "%.2f", staticsModel.todayTotalActualIncome)
            incomeView.valueLab.attributedText = TRTool.richText(str1: "¥", font1: .trFont(13), color1: .white, str2: "\(incomStr)", font2: .trMediumFont(22), color2: .white)
            
            orderNumView.valueLab.attributedText = TRTool.richText(str1: "\(staticsModel.orderNumber)", font1: .trMediumFont(22), color1: .white, str2: "单", font2: .trFont(13), color2: .white)
            
            timeView.valueLab.attributedText = TRTool.richText(str1: "\(staticsModel.onLineTime)", font1: .trMediumFont(22), color1: .white, str2: "小时", font2: .trFont(fontSize: 13), color2: .white)
            
            scoreView.valueLab.attributedText = TRTool.richText(str1: "\(staticsModel.userEvaluateScore)", font1: .trMediumFont(22), color1: .white, str2: "%", font2: .trFont(13), color2: .white)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        let bgImgV = TRFactory.imageViewWith(image: UIImage(named: "home_rider_static_bg"), mode: .scaleAspectFill, superView: self)
        bgImgV.trCorner(15)
        
        let line = UIView()
        line.backgroundColor = .hexColor(hexValue: 0xB3EECC)
        bgImgV.addSubview(line)
        
        incomeView = TRHomeRiderStaticSubView(frame: .zero)
        incomeView.itemLab.text = "昨日收入"
        bgImgV.addSubview(incomeView)
        
        
        orderNumView = TRHomeRiderStaticSubView(frame: .zero)
        orderNumView.itemLab.textColor = .hexColor(hexValue: 0xEFFDF5)
        orderNumView.itemLab.text = "昨日接单"
        bgImgV.addSubview(orderNumView)
        
        
        timeView = TRHomeRiderStaticSubView(frame: .zero)
        timeView.itemLab.textColor = .hexColor(hexValue: 0xEFFDF5)
        timeView.itemLab.text = "昨日在线"
        bgImgV.addSubview(timeView)
        
        
        scoreView = TRHomeRiderStaticSubView(frame: .zero)
        scoreView.itemLab.textColor = .hexColor(hexValue: 0xEFFDF5)
        scoreView.itemLab.text = "总评分"
        bgImgV.addSubview(scoreView)
        
        incomeView.valueLab.attributedText = TRTool.richText(str1: "¥", font1: .trFont(13), color1: .white, str2: "32", font2: .trMediumFont(22), color2: .white)
        
        orderNumView.valueLab.attributedText = TRTool.richText(str1: "8", font1: .trMediumFont(22), color1: .white, str2: "单", font2: .trFont(13), color2: .white)
        
        timeView.valueLab.attributedText = TRTool.richText(str1: "0.85", font1: .trMediumFont(22), color1: .white, str2: "小时", font2: .trFont(fontSize: 13), color2: .white)
        
        scoreView.valueLab.attributedText = TRTool.richText(str1: "98", font1: .trMediumFont(22), color1: .white, str2: "%", font2: .trFont(13), color2: .white)
        
        let views = [incomeView, orderNumView, timeView, scoreView]
        
        
        bgImgV.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(self)
            make.height.equalTo(88)
            make.bottom.equalTo(self)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(incomeView.snp.right)
            make.width.equalTo(1)
            make.height.equalTo(26)
            make.centerY .equalTo(bgImgV)
        }
        
        views.snp.distributeViewsAlong(axisType: 0, fixedSpacing: 0, leadSpacing: 0, tailSpacing: 0)
        views.snp.makeConstraints { make in
            make.top.bottom.equalTo(bgImgV)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

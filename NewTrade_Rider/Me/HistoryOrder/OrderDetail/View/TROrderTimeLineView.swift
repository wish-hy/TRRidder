//
//  TRTimeLineView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TROrderTimeLineView: UIView {
    
    var contentView : UIView!
    
    var time1Lab : UILabel!
    var time2Lab : UILabel!
    var time3Lab : UILabel!
    var time4Lab : UILabel!
    
    var timeTip1Lab : UILabel!
    var timeTip2Lab : UILabel!
    var timeTip3Lab : UILabel!
    var timeTip4Lab : UILabel!
    
    var timeCircel1View : UIView!
    var timeCircel2View : UIView!
    var timeCircel3View : UIView!
    var timeCircel4View : UIView!
    
    var type : Int = 3 {
        didSet{
            if type == 1 {//完成
                time4Lab.textColor = UIColor.hexColor(hexValue: 0x141414)
                timeTip4Lab.textColor = UIColor.hexColor(hexValue: 0x141414)
                timeCircel4View.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
            } else if type == 2 {//取消
                time3Lab.textColor = UIColor.hexColor(hexValue: 0x141414)
                timeTip3Lab.textColor = UIColor.hexColor(hexValue: 0x141414)
                timeCircel3View.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
                timeTip3Lab.text = "取消时间"
            } else if type == 3 {//转单
                time3Lab.textColor = UIColor.hexColor(hexValue: 0x141414)
                timeTip3Lab.textColor = UIColor.hexColor(hexValue: 0x141414)
                timeCircel3View.backgroundColor = UIColor.hexColor(hexValue: 0x141414)
                timeTip4Lab.text = "转单时间"

            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        self.addSubview(contentView)
        
        time1Lab = UILabel()
        time1Lab.text = "10:30"
        time1Lab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        time1Lab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(time1Lab)
        
        timeTip1Lab = UILabel()
        timeTip1Lab.text = "下单时间"
        timeTip1Lab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        timeTip1Lab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(timeTip1Lab)
        
        time2Lab = UILabel()
        time2Lab.text = "11:00"
        time2Lab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        time2Lab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(time2Lab)
        
        timeTip2Lab = UILabel()
        timeTip2Lab.text = "接单时间"
        timeTip2Lab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        timeTip2Lab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(timeTip2Lab)
        
        
        time3Lab = UILabel()
        time3Lab.text = "12:20"
        time3Lab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        time3Lab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(time3Lab)
        
        timeTip3Lab = UILabel()
        timeTip3Lab.text = "取消时间"
        timeTip3Lab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        timeTip3Lab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(timeTip3Lab)
        
        
        
        time4Lab = UILabel()
        time4Lab.text = "13:00"
        time4Lab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        time4Lab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(time4Lab)
        
        timeTip4Lab = UILabel()
        timeTip4Lab.text = "送达时间"
        timeTip4Lab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        timeTip4Lab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(timeTip4Lab)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        contentView.addSubview(line)
        
        timeCircel1View = UIView()
        timeCircel1View.layer.cornerRadius = 5
        timeCircel1View.layer.masksToBounds = true
        timeCircel1View.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        contentView.addSubview(timeCircel1View)
        
        timeCircel2View = UIView()
        timeCircel2View.layer.cornerRadius = 5
        timeCircel2View.layer.masksToBounds = true
        timeCircel2View.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        contentView.addSubview(timeCircel2View)
        
        timeCircel3View = UIView()
        timeCircel3View.layer.cornerRadius = 5
        timeCircel3View.layer.masksToBounds = true
        timeCircel3View.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        contentView.addSubview(timeCircel3View)
        
        timeCircel4View = UIView()
        timeCircel4View.layer.cornerRadius = 5
        timeCircel4View.layer.masksToBounds = true
        timeCircel4View.backgroundColor = UIColor.hexColor(hexValue: 0xEAECED)
        contentView.addSubview(timeCircel4View)
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(19)
            make.height.equalTo(1)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        
        timeCircel1View.snp.makeConstraints { make in
            make.centerY.equalTo(line)
            make.centerX.equalTo(line.snp.left)
            make.width.height.equalTo(10)
        }
        timeCircel2View.snp.makeConstraints { make in
            make.centerY.equalTo(line)
            make.centerX.equalTo(line.snp.centerX).offset(-60 * APP_Scale)
            make.width.height.equalTo(10)
        }
        timeCircel3View.snp.makeConstraints { make in
            make.centerY.equalTo(line)
            make.centerX.equalTo(line.snp.centerX).offset(60 * APP_Scale)
            make.width.height.equalTo(10)
        }
        timeCircel4View.snp.makeConstraints { make in
            make.centerY.equalTo(line)
            make.centerX.equalTo(line.snp.right)
            make.width.height.equalTo(10)
        }
        time1Lab.snp.makeConstraints { make in
            make.centerX.equalTo(timeCircel1View)
            make.bottom.equalTo(line.snp.top).offset(-10)
        }
        timeTip1Lab.snp.makeConstraints { make in
            make.centerX.equalTo(timeCircel1View)
            make.top.equalTo(line.snp.bottom).offset(10)
        }
        time2Lab.snp.makeConstraints { make in
            make.centerX.equalTo(timeCircel2View)
            make.bottom.equalTo(line.snp.top).offset(-10)
        }
        timeTip2Lab.snp.makeConstraints { make in
            make.centerX.equalTo(timeCircel2View)
            make.top.equalTo(line.snp.bottom).offset(10)
        }
        time3Lab.snp.makeConstraints { make in
            make.centerX.equalTo(timeCircel3View)
            make.bottom.equalTo(line.snp.top).offset(-10)
        }
        timeTip3Lab.snp.makeConstraints { make in
            make.centerX.equalTo(timeCircel3View)
            make.top.equalTo(line.snp.bottom).offset(10)
        }
        time4Lab.snp.makeConstraints { make in
            make.centerX.equalTo(timeCircel4View)
            make.bottom.equalTo(line.snp.top).offset(-10)
        }
        timeTip4Lab.snp.makeConstraints { make in
            make.centerX.equalTo(timeCircel4View)
            make.top.equalTo(line.snp.bottom).offset(10)
        }
        self.type = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

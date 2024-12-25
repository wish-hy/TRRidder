//
//  TRAppleyComQuesCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/25.
//

import UIKit

class TRAppleyComQuesCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        let noticeLab = TRFactory.labelWith(font: .trFont(12), text: "注：填写以上信息，三个工作日内获得反馈。", textColor: .txtColor(), superView: contentView)
        
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.trCorner(10)
        contentView.addSubview(bgView)
        
        let leftImgV = TRFactory.imageViewWith(image: UIImage(named: "apply_rider_noti"), mode: .scaleAspectFit, superView: bgView)
        let titleLab = TRFactory.labelWith(font: .trBoldFont(20), text: "常见问题", textColor: .txtColor(), superView: bgView)
        titleLab.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(bgView).offset(15)
        }
        leftImgV.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.height.equalTo(4)
            make.left.right.equalTo(bgView).inset(45)
        }
        
        var perView : UIView?
        for i in 0...titles.count - 1 {
            let v = TRApplyComQuesSubView(frame: .zero)
            v.titleLab.text = titles[i]
            v.detailLab.text = details[i]
            bgView.addSubview(v)
            
            v.snp.makeConstraints { make in
                make.left.right.equalTo(bgView).inset(0)
                if perView == nil {
                    make.top.equalTo(titleLab.snp.bottom).offset(0)
                } else {
                    make.top.equalTo(perView!.snp.bottom).offset(20)
                }
                
                if i == titles.count - 1 {
                    make.bottom.equalTo(bgView).inset(15)
                }
            }
            
            perView = v
            
        }
        
        
        noticeLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(12)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(noticeLab.snp.bottom).offset(20)
            make.bottom.equalTo(contentView)
            make.left.right.equalTo(contentView).inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    private let titles = [
        "1. 报名之后多久会联系我?",
        "2. 报名会收取费用吗?",
        "3. 加入后会提供免费电瓶车吗?",
        "4. 成为骑手有什么要求吗?",
        "5、请问摩托车、三轮车、小货车、小汽车等"
    ]
    
    private let details = [
        "填写信息后，我们会在三个工作日内联系您，请保持电话畅通！",
        "平台及加盟商不会以任何名义收取报名费。(温馨提示: 请勿上当受骗)",
        "普通骑手需自己配备符合国家标准的电动车等交通工具(温馨提示:请勿相信分期购买电动车等骗局)",
        "身体健康、年龄18-60周岁、会使用智能手机、具备电动车驾驶经验。",
        "可以申请，因嘉马平台旗下同城跑腿海量订单，满足不同车型的接单任务；申请需要拥有有效的机动车行驶证、机动车年检证明、车辆保险和本人驾驶证。"
    ]
    

}

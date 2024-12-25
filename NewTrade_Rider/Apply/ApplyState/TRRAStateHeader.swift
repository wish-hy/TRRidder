//
//  TRRAStateHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/25.
//

import UIKit

class TRRAStateHeader: UITableViewHeaderFooterView {
    var stateImgV : UIImageView!
    var stateLab : UILabel!
    
    var model : TRApplerRiderContainer? {
        didSet {
            guard let model = model else { return }
            //请等待管理员进行审核，审核期间请保持电话
            if model.riderInfo.curAuthStatus.elementsEqual("UNAUDITED") {
                stateLab.attributedText = TRTool.richText(str1: "您的资料已提交\n", font1: .trBoldFont(18), color1: .txtColor(), str2: "\n请等待管理员进行审核，\n审核期间请保持电话畅通", font2: .trFont(fontSize: 14), color2: .hexColor(hexValue: 0x9B9C9C))
                stateImgV.image = UIImage(named: "apply_state_top_pending")

            } else if model.riderInfo.curAuthStatus.elementsEqual("REJECTED") {
                stateLab.attributedText = TRTool.richText(str1: "您提交的资料审核不通过\n", font1: .trBoldFont(18), color1: .txtColor(), str2: "\n请修改后再提交", font2: .trFont(fontSize: 14), color2: .hexColor(hexValue: 0x9B9C9C))
                stateImgV.image = UIImage(named: "apply_state_top_fail")
            } else if model.riderInfo.curAuthStatus.elementsEqual("UNTRAINED") {
                //审核通过，为训练
                stateLab.attributedText = TRTool.richText(str1: "您提交的资料审核通过\n", font1: .trBoldFont(18), color1: .txtColor(), str2: "\n请尽快签约接单哦！", font2: .trFont(fontSize: 14), color2: .hexColor(hexValue: 0x9B9C9C))
                stateImgV.image = UIImage(named: "apply_state_top_success")

            } else if model.riderInfo.curAuthStatus.elementsEqual("UNSIGNED") {
                //审核通过，未签约
                stateLab.attributedText = TRTool.richText(str1: "您提交的资料审核通过\n", font1: .trBoldFont(18), color1: .txtColor(), str2: "\n请尽快签约接单哦！", font2: .trFont(fontSize: 14), color2: .hexColor(hexValue: 0x9B9C9C))
                stateImgV.image = UIImage(named: "apply_state_top_success")

            }
        }
        
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    
    private func setupView(){
        sss()
        stateImgV = TRFactory.imageViewWith(image: UIImage(named: "apply_state_top_fail"), mode: .scaleAspectFit, superView: contentView)
        stateLab = UILabel()
        stateLab.numberOfLines = 0
        stateLab.textAlignment = .center
        stateLab.attributedText = TRTool.richText(str1: "您提交的资料审核不通过\n", font1: .trBoldFont(18), color1: .txtColor(), str2: "\n请修改后再提交", font2: .trFont(fontSize: 14), color2: .hexColor(hexValue: 0x9B9C9C))
        contentView.addSubview(stateLab)
        
        stateImgV.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView)
            make.width.height.equalTo(184 * TRWidthScale)
        }
        stateLab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(stateImgV.snp.bottom)
            make.bottom.equalTo(contentView).inset(25)
        }
    }
    func sss(){
        let layerView = UIView()
        layerView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 286)
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.35).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor]
        bgLayer1.locations = [0, 0, 0.85, 0.85]
        bgLayer1.frame = layerView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 0.55, y: 1)
        layerView.layer.addSublayer(bgLayer1)
        contentView.addSubview(layerView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

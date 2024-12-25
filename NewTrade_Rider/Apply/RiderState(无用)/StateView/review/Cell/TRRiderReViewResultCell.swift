//
//  TRRiderReViewResultCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderReViewResultCell: UITableViewCell {
    var cornderType : Int = 0 {
        didSet {
            if cornderType == 0 { // 无圆角
              
                contentView.layer.mask = nil;
            } else if cornderType == 1 {//上圆角
                self.layoutIfNeeded()

                let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: self.frame.height), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 12, height: 12))
                let maskLayer = CAShapeLayer()
                maskLayer.path = maskPath.cgPath
                bgView.layer.mask = maskLayer;
            } else if cornderType == 2 {//下圆角
                let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: self.frame.height), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 12, height: 12))
                let maskLayer = CAShapeLayer()
                maskLayer.path = maskPath.cgPath
                bgView.layer.mask = maskLayer;
            }
        }
    }
    var bgView : UIView!
    var limitView : TRLimitTextView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        let itemLab = TRFactory.labelWithImportant(font: .trFont(fontSize: 16), text: "审核结果", textColor: .txtColor(), superView: bgView)
        limitView = TRLimitTextView(frame: .zero)
//        limitView.LimitNum = 200
        limitView.placeHolder = "请输入"
        limitView.textView.font = .trFont(fontSize: 14)
        limitView.textView.textColor = .txtColor()
        limitView.layer.cornerRadius = 8
        limitView.layer.masksToBounds = true
        limitView.backgroundColor = .bgColor()
        bgView.addSubview(limitView)
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(18)
            make.top.equalTo(bgView)
        }
        limitView.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(12)
            make.top.equalTo(itemLab.snp.bottom).offset(10)
            make.height.equalTo(150)
            make.bottom.equalTo(bgView).inset(15)
        }
        
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
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

}

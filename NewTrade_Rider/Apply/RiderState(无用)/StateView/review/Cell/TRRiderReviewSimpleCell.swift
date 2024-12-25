//
//  TRRiderReviewSimpleCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderReviewSimpleCell: UITableViewCell {

    var itemLab : UILabel!
    var valueLab : UILabel!
    var bgView : UIView!
    var cornderType : Int = 0 {
        didSet {
            if cornderType == 0 { // 无圆角
              
                contentView.layer.mask = nil;
            } else if cornderType == 1 {//上圆角
                self.layoutIfNeeded()

                let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 34), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
                let maskLayer = CAShapeLayer()
                maskLayer.path = maskPath.cgPath
                bgView.layer.mask = maskLayer;
            } else if cornderType == 2 {//下圆角
                let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 34), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
                let maskLayer = CAShapeLayer()
                maskLayer.path = maskPath.cgPath
                bgView.layer.mask = maskLayer;
            }
        }
    }
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
        
        itemLab = TRFactory.labelWith(font: .trFont(fontSize: 16), text: "item", textColor: .txtColor(), superView: contentView)
        itemLab.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        itemLab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        valueLab = TRFactory.labelWith(font: .trMediumFont(fontSize: 16), text: "value", textColor: .txtColor(), superView: contentView)
          
        valueLab.numberOfLines = 0
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
        }
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(12)
            make.top.equalTo(contentView)
        }
        valueLab.snp.makeConstraints { make in
            make.top.equalTo(itemLab)
            make.right.equalTo(contentView).inset(12)
//            make.left.equalTo(bgView).offset(120)
            make.left.greaterThanOrEqualTo(bgView).offset(90)
            make.bottom.equalTo(contentView).inset(15)

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

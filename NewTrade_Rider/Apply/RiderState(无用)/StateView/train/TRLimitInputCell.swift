//
//  TRLimitInputCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRLimitInputCell: UITableViewCell {
    var limitView : TRLimitTextView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 165), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer;
        
        limitView = TRLimitTextView(frame: .zero)
//        limitView.LimitNum = 200
        limitView.placeHolder = "请输入"
        limitView.textView.font = .trFont(fontSize: 14)
        limitView.textView.textColor = .txtColor()
        limitView.layer.cornerRadius = 8
        limitView.layer.masksToBounds = true
        limitView.backgroundColor = .bgColor()
        contentView.addSubview(limitView)

        limitView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(12)
            make.top.equalTo(contentView).offset(0)
            make.height.equalTo(150)
            make.bottom.equalTo(contentView).inset(15)
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

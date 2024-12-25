//
//  TRRiderStateTrainCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderStateTrainCell: UITableViewCell {
    var imgV : UIImageView!
    var itemLab : UILabel!
    var bgView : UIView!
    var cornderType : Int = 0 {
        didSet {
            if cornderType == 0 { // 无圆角
              
                contentView.layer.mask = nil;
            } else if cornderType == 1 {//上圆角
                self.layoutIfNeeded()

                let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 35), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
                let maskLayer = CAShapeLayer()
                maskLayer.path = maskPath.cgPath
                bgView.layer.mask = maskLayer;
            } else if cornderType == 2 {//下圆角
                let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 35), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
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
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        imgV = UIImageView(image: UIImage(named: "uncheck_circle"))
        bgView.addSubview(imgV)
        
        itemLab = TRFactory.labelWith(font: .trFont(fontSize: 16), text: "骑行安全", textColor: .txtColor(), superView: bgView)
        imgV.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView)
            make.bottom.equalTo(bgView).inset(15)
            make.width.height.equalTo(20)
    
        }
        itemLab.snp.makeConstraints { make in
            make.centerY.equalTo(imgV)
            make.left.equalTo(imgV.snp.right).offset(10)
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

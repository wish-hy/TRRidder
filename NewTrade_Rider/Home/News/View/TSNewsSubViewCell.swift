//
//  TSStoreSubViewCell.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/10/23.
//

import UIKit

class TSNewsSubViewCell: UITableViewCell {
    var titleLab : UILabel!
    var desLab : UILabel!
    var contentImgV : UIImageView!
    
    var viewLab : UILabel!
    var timeLab : UILabel!
    var bgView = UIView()
    var model : TRADModel? {
        didSet{
            guard let model = model else { return }
            timeLab.text = model.createTime
            titleLab.text = model.title
            var url =  URL.init(string: model.pictureUrl)
            contentImgV.sd_setImage(with: URL.init(string: model.pictureUrl), placeholderImage: nil, context: nil)
            viewLab.text = model.readCount   
        }
    }
    var cornderType : Int = 0 {
        didSet {
            if cornderType == 0 { // 无圆角
              
                contentView.layer.mask = nil;
            } else if cornderType == 1 {//上圆角
                self.layoutIfNeeded()

                let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 106), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
                let maskLayer = CAShapeLayer()
                maskLayer.path = maskPath.cgPath
                bgView.layer.mask = maskLayer;
            } else if cornderType == 2 {//下圆角
                let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 106), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
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
        
        titleLab = TRFactory.labelWith(font: .trMediumFont(fontSize: 15), text: "震惊！某商家竟然给用户放了这种东西，到底", textColor: .hexColor(hexValue: 0x333333), superView: contentView)
        titleLab.numberOfLines = 2
        
        let viewImgV = UIImageView(image: UIImage(named: "view")?.withRenderingMode(.alwaysOriginal))
        contentView.addSubview(viewImgV)
        viewLab = TRFactory.labelWith(font: .trFont(fontSize: 12), text: "100w", textColor: .hexColor(hexValue: 0x9B9C9C), superView: contentView)
        
        timeLab = TRFactory.labelWith(font: .trFont(fontSize: 12), text: "100w", textColor: .hexColor(hexValue: 0x9B9C9C), superView: contentView)
        
        contentImgV = UIImageView(image: UIImage(named: "content"))
        contentImgV.contentMode = .scaleAspectFill
        contentImgV.layer.cornerRadius = 8
        contentImgV.layer.masksToBounds = true
        contentView.addSubview(contentImgV)
        
        let line = UIView()
        line.backgroundColor = .lineColor()
        contentView.addSubview(line)

        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView).offset(20)
            make.right.equalTo(contentImgV.snp.left).offset(-15)
        }
        viewImgV.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.bottom.equalTo(contentImgV).offset(-8)
            make.width.height.equalTo(16)
        }
        viewLab.snp.makeConstraints { make in
            make.centerY.equalTo(viewImgV)
            make.left.equalTo(viewImgV.snp.right).offset(5)
        }
        timeLab.snp.makeConstraints { make in
            make.centerY.equalTo(viewImgV)
            make.right.equalTo(contentImgV.snp.left).offset(-15)
        }
        
        contentImgV.snp.makeConstraints { make in
            make.right.equalTo(bgView).offset(-12)
            make.top.equalTo(bgView).offset(15)
            make.height.equalTo(76)
            make.width.equalTo(96)
            make.bottom.equalTo(contentView).inset(15)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo( bgView).inset(12)
            make.bottom.equalTo(bgView)
            make.height.equalTo(1)
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

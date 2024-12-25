//
//  TRStoreStateBrandImgCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/15.
//

import UIKit

class TRStoreStateBrandImgCell: UITableViewCell {
    var itemLab : UILabel!
    //图片配置 赋值 imgs 之前配置
    var hasLab : Bool = true
    var leading : CGFloat = 12.0
    var imgHeight : CGFloat?
    var cloum : Int = 3
    var imgCorner : CGFloat = 6
    var space : Int = 10
    
    var imgs : [String] = []{
        didSet {
            for iv in imgViews {iv.removeFromSuperview()}
            if imgs.count > 0 {
                setupImgView()
            }
        }
    }
    var imgViews : [UIImageView] = []
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView(){
        itemLab = TRFactory.labelWith(font: .trFont(fontSize: 16), text: "品牌图片", textColor: .txtColor(), superView: contentView)
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(12)
            make.top.equalTo(contentView)
        }
    }
    private func setupImgView(){
        if hasLab {
            itemLab.isHidden = false
        } else {
            itemLab.isHidden = true
        }
        var line = imgs.count / cloum
        if imgs.count % cloum != 0 {
            line = line + 1
        }
        let tw = Int(Screen_Width) - 24 - space * (cloum - 1)
        let w = tw / cloum
            
        if imgHeight == nil {
            imgHeight = CGFloat(w)
        }
        
        for x in 1...line {
            var temps : [UIImageView] = []
            for _ in 0...cloum - 1 {
                let iv1 = UIImageView(image: UIImage(named: "banner_1"))
                iv1.layer.cornerRadius = 4
                iv1.layer.masksToBounds = true
                iv1.contentMode = .scaleAspectFill
                iv1.clipsToBounds = true
                contentView.addSubview(iv1)
                temps.append(iv1)
            }
            
            temps.snp.makeConstraints { make in
                make.height.equalTo(imgHeight!)
                if hasLab {
                    make.top.equalTo(itemLab.snp.bottom).offset(10 + Int(imgHeight!) * (line - 1))
                } else {
                    make.top.equalTo(itemLab).offset(Int(imgHeight!) * (line - 1))
                }
                if x == line {
                    make.bottom.equalTo(contentView).inset(15)
                }
            }
            temps.snp.distributeViewsAlong(axisType: 0, fixedSpacing: leading, leadSpacing: CGFloat(space), tailSpacing: leading)
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

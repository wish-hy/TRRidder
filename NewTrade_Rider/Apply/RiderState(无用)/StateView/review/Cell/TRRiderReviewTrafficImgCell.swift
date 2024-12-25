//
//  TRRiderReviewTrafficImgCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderReviewTrafficImgCell: UITableViewCell {
    var itemLab : UILabel!
    
    var imgs : [String] = [] {
        didSet {
            setupView()
        }
    }
    var bgView : UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        contentView.addSubview(whiteView)
        
        bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        bgView.layer.cornerRadius = 10
        
        whiteView.snp.makeConstraints { make in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(11)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
        }
    }
    
    
    private func setupView(){
        if imgs.count <= 0 {return}
        var leftImgViews : [UIImageView] = []
        var rightImgViews : [UIImageView] = []

        for i in 0...imgs.count - 1 {
            let imgV = UIImageView(image: UIImage(named: imgs[i]))
            imgV.clipsToBounds = true
            imgV.layer.cornerRadius = 8
            imgV.layer.masksToBounds = true
            imgV.contentMode = .scaleAspectFill
            bgView.addSubview(imgV)
            if i % 2 == 0 {
                leftImgViews.append(imgV)
            } else {
                rightImgViews.append(imgV)
            }
            
            if imgs.count - 1 == i {
                imgV.snp.makeConstraints { make in
                    make.bottom.equalTo(bgView).inset(10)
                }
            }
        }
        if leftImgViews.count > 1 {
            leftImgViews.snp.makeConstraints { make in
                make.left.equalTo(bgView).offset(16)
                make.right.equalTo(bgView.snp.centerX).offset(-6.5)
                make.height.equalTo(150)
            }
            leftImgViews.snp.distributeViewsAlong(axisType: 1, fixedSpacing: 10, leadSpacing: 0, tailSpacing: 10)
        } else if leftImgViews.count == 1 {
            leftImgViews.snp.makeConstraints { make in
                make.top.equalTo(bgView)
                make.left.equalTo(bgView).offset(16)
                make.right.equalTo(bgView.snp.centerX).offset(-6.5)
                make.height.equalTo(150)
            }
        }
        
        if rightImgViews.count > 1 {
            rightImgViews.snp.makeConstraints { make in
                make.right.equalTo(bgView).offset(-16)
                make.left.equalTo(bgView.snp.centerX).offset(6.5)
                make.height.equalTo(150)
            }
            rightImgViews.snp.distributeViewsAlong(axisType: 1, fixedSpacing: 10, leadSpacing: 0, tailSpacing: 10)
        } else if rightImgViews.count == 1 {
            rightImgViews.snp.makeConstraints { make in
                make.top.equalTo(bgView)
                make.right.equalTo(bgView).offset(-16)
                make.left.equalTo(bgView.snp.centerX).offset(6.5)
                make.height.equalTo(150)
            }
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

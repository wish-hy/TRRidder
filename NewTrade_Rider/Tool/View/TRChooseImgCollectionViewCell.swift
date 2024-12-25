//
//  TRChooseImgCollectionViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/9.
//

import UIKit
import RxSwift
import RxCocoa
class TRChooseImgCollectionViewCell: UICollectionViewCell {
    var deleteBtn : UIButton!
    var imgV : UIImageView!
    var infoLab : UILabel!
    var numLab : UILabel!
    var type = 0 {
        didSet {
            if type == 0 {
                deleteBtn.isHidden = false
            } else {
                imgV.image = UIImage(named: "image_add")
                deleteBtn.isHidden = true
            }
        }
    }
    
    var bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    private func setupView(){
        self.backgroundColor = .white
        imgV = UIImageView()
        imgV.clipsToBounds = true
        imgV.contentMode = .scaleAspectFill
//        imgV.layer.cornerRadius = 5
//        imgV.layer.masksToBounds = true
        imgV.image = UIImage(named: "content")
        contentView.addSubview(imgV)
        
        deleteBtn = UIButton()
        deleteBtn.setImage(UIImage(named: "img_delete"), for: .normal)
        contentView.addSubview(deleteBtn)
        
        numLab = TRFactory.labelWith(font: .trFont(fontSize: 13), text: "0/4", textColor: .hexColor(hexValue: 0x9B9C9C), superView: contentView)
        
        infoLab = TRFactory.labelWith(font: .trFont(fontSize: 12), text: "0/4", textColor: .hexColor(hexValue: 0xFFFFFF), superView: contentView)
        infoLab.textAlignment = .center
        infoLab.backgroundColor = .hexColor(hexValue: 0x000000).withAlphaComponent(0.6)
        infoLab.frame = CGRect(x: 0, y: 0, width: 30, height: 16)
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 30, height: 16), byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 6, height: 6))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        infoLab.layer.mask = maskLayer

        
        imgV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView).inset(0)
            
        }
        deleteBtn.snp.makeConstraints { make in
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.width.equalTo(15)
        }
        infoLab.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 16))
            make.top.left.equalTo(imgV)
        }
        numLab.snp.makeConstraints { make in
            make.centerX.equalTo(imgV)
            make.bottom.equalTo(imgV).offset(-10)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TRDashBtn.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRImgAddDashBtn: UIButton {
    
    var preImgView : UIImageView!
    private var imgV : UIImageView!
    var titleLab : UILabel!
    
    var hashTitleLab : Bool = true {
        didSet {
            if hashTitleLab{
                titleLab.isHidden = false
                imgV.snp.updateConstraints { make in
                    make.centerY.equalTo(self).inset(16)
                }
            } else {
                titleLab.isHidden = true
                imgV.snp.updateConstraints { make in
                    make.centerY.equalTo(self).inset(0)
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        let border = CAShapeLayer()
        border.strokeColor = UIColor.hexColor(hexValue: 0xC6C9CB).cgColor
        border.fillColor = UIColor.white.cgColor
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8)
        border.path = path.cgPath
        border.frame = self.frame
        border.lineWidth = 1
        border.lineDashPattern = [5,5]
        self.layer.addSublayer(border)
        

        
        imgV = UIImageView(image: UIImage(named: "camera"))
        self.addSubview(imgV)
        
        titleLab = TRFactory.labelWith(font: .trFont(fontSize: 14), text: "车头照片", textColor: .hexColor(hexValue: 0x9B9C9C), superView: self)
        
        preImgView = UIImageView()
        preImgView.contentMode = .scaleAspectFit
        preImgView.layer.masksToBounds = true
        preImgView.image = UIImage(named: "")
        preImgView.layer.cornerRadius = 8
        self.addSubview(preImgView)
        imgV.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).inset(16)
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(imgV.snp.bottom).offset(5)
        }
        
        preImgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

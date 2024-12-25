//
//  TRMessgeNavBar.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/25.
//

import UIKit

class TRMessgeNavBar: UIView {

    var backBtn : UIButton!
    var titleLab : UILabel!
    
    var clearBtn : UIButton!
    var setBtn : UIButton!
    
    var tipView : TRMessageNotiTipView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        let bgImgV = UIImageView(image: UIImage(named: "cart_nav_bg"))
        bgImgV.contentMode = .scaleAspectFill
        self.addSubview(bgImgV)
        self.backgroundColor = .white
        titleLab = UILabel()
        titleLab.text = "消息中心"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        titleLab.font = UIFont.trMediumFont(18)
        self.addSubview(titleLab)
        backBtn = TRFactory.buttonWith(image: UIImage(named: "nav_back"), superView: self)
        // MARK: - 暂时隐藏
        clearBtn = UIButton()
        clearBtn.isHidden = true
        clearBtn.setImage(UIImage(named: "chat_clear"), for: .normal)
        self.addSubview(clearBtn)
        
        setBtn = UIButton()
        //chat_set
        setBtn.setImage(UIImage(named: "chat_clear"), for: .normal)
        self.addSubview(setBtn)
        
        tipView = TRMessageNotiTipView(frame: .zero)
        // MARK: - 暂时隐藏
        tipView.isHidden = true
        self.addSubview(tipView)
        
        bgImgV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self).inset(0)
        }
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(titleLab)
        }
        titleLab.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(7 + 66)
            make.centerX.equalTo(self).offset(0)
        }
        
        setBtn.snp.makeConstraints { make in
            make.right.equalTo(self).inset(16)
            make.centerY.equalTo(titleLab)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        clearBtn.snp.makeConstraints { make in
            make.right.equalTo(setBtn.snp.left).offset(-16)
            make.centerY.equalTo(titleLab)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        tipView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(titleLab.snp.bottom).offset(18)
            make.height.equalTo(30)
        }
    }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

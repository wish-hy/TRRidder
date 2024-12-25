//
//  TRPopBaseView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRPopBaseView: UIView {
    var contentView : UIView!
    
    var cancelBlock : Int_Block?
    var suceBlock : Int_Block?
    var bgView : UIView!
    var isAutoHidden = false {
        didSet {
            if isAutoHidden == true {
                UIView.animate(withDuration: 3, delay: 3) {
                    self.removeFromSuperview()
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    private func setView(){
        bgView = UIView()
        bgView.backgroundColor = .black.withAlphaComponent(0.35)
        self.addSubview(bgView)
        
        contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        self.addSubview(contentView)
        
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        contentView.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.left.right.equalTo(bgView).inset(32)
        }
    }
    func addToWindow(){
        let window = UIApplication.shared.delegate!.window!!
        window.addSubview(self)
        self.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(window)
        }
    }
    func addToView(_ view : UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

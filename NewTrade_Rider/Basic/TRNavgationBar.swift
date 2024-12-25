//
//  TRNavgationBar.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/18.
//

import UIKit

class TRNavgationBar: UIView {

    var contentView : UIView!
    var titleLab : UILabel?{
        didSet{
            if titleLab == nil {
                return;
            }
            if !contentView.subviews.contains(titleLab!) {
                contentView.addSubview(titleLab!)
            }
            titleLab!.snp.makeConstraints { make in
                make.centerX.equalTo(contentView)
                make.bottom.equalTo(contentView).inset(15)
                
            }
        }
    }
    
    var leftView : UIView?{
        didSet{
            if leftView == nil {
                return;
            }
            let v = self.viewWithTag(1001)
            v?.removeFromSuperview()
            leftView?.tag = 1001
            leftView?.isUserInteractionEnabled = true
            if !contentView.subviews.contains(leftView!) {
                contentView.addSubview(leftView!)
            }
            leftView!.snp.makeConstraints { make in
                make.bottom.equalTo(contentView).inset(8)
                make.left.equalTo(contentView).offset(16)
                make.width.equalTo(leftView!.frame.size.width)
                make.height.equalTo(leftView!.frame.size.height)
            }
        }
    }
    
    var rightView : UIView?{
        didSet{
            if rightView == nil {
                return;
            }
            if !contentView.subviews.contains(rightView!) {
                contentView.addSubview(rightView!)
            }
            rightView!.snp.makeConstraints { make in
                make.bottom.equalTo(contentView).inset(8)
                make.right.equalTo(contentView).inset(16)
                make.width.equalTo(rightView!.frame.size.width)
                make.height.equalTo(rightView!.frame.size.height)
            }
        }
    }
    
    var middleView : UIView?{
        didSet{
            if middleView == nil {
                return;
            }
            if !contentView.subviews.contains(middleView!) {
                contentView.addSubview(middleView!)
            }
            middleView!.snp.makeConstraints { make in
                make.bottom.equalTo(contentView).inset(5)
                make.right.equalTo(rightView!.snp.left).offset(-5)
                make.width.equalTo(middleView!.frame.size.width)
                make.height.equalTo(middleView!.frame.size.height)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
//        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

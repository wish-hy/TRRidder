//
//  TRBottomPopView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit
import RxCocoa
import RxSwift
class TRBottomPopBasicView: UIView {
    var contentHeight = 800 {
        didSet{
            contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.contentHeight))
        }
    }
    var actionHeight = 90{//中途高度变化
        didSet{
            UIView.animate(withDuration: 0.3) {
                self.contentView.frame = CGRect(x: 0, y: Screen_Height - CGFloat(self.actionHeight), width: Screen_Width, height: CGFloat(self.actionHeight))

            }
        }
    }
    var bgView : UIView!
    var contentView : UIView!
    var titleLab : UILabel!
    var cancelBtn : UIButton!
    var bag = DisposeBag()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        bgView = UIView()
        bgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        bgView.addGestureRecognizer(tap)
        bgView.backgroundColor = .black.withAlphaComponent(0.0)
        self.addSubview(bgView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        
        contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.contentHeight))
        tap.rx.event.debug("Tap").subscribe(onNext : {_ in
            self.closeView()
        }).disposed(by: bag)
    }
    func configTitleCancelView(){
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width, height: 1000), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer;
        
        titleLab = UILabel()
        titleLab.text = "要对骑手说点什么"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x333333)
        titleLab.font = UIFont.trBoldFont(fontSize: 20)
        contentView.addSubview(titleLab)
        
        let line = UIView()
        line.backgroundColor = .hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(named: "close_black"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        contentView.addSubview(cancelBtn)
        
        titleLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(20)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.left.right.equalTo(contentView)
            make.height.equalTo(1)
        }
        cancelBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(titleLab)
            make.right.equalTo(contentView).inset(16)
        }
        
        
    }
    func addToView(v : UIView?){
        if v == nil {return}
        v!.addSubview(self)
        self.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(v!)
        }
    }
    func addToWindow(){
        let window = UIApplication.shared.delegate!.window!!
        window.addSubview(self)
        self.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(window)
        }
    }
    func openView(){
        self.layoutIfNeeded()
        self.layoutSubviews()
        UIView.animate(withDuration: 0.3) {
            self.bgView.backgroundColor = .black.withAlphaComponent(0.5)

            self.contentView.frame = CGRect(x: 0, y: Int(Screen_Height) - self.contentHeight, width: Int(Screen_Width), height: self.contentHeight)
        }
        
    }
    func closeViewWithAction(completion: ((Bool) -> Void)? = nil){
        NotificationCenter.default.removeObserver(self)

        self.layoutIfNeeded()
        self.layoutSubviews()

        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.contentHeight))
        }, completion: { _ in
            self.removeFromSuperview()
            completion?(true)
        })
    }
    @objc func closeView(){
        NotificationCenter.default.removeObserver(self)
        self.layoutIfNeeded()
        self.layoutSubviews()

        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.bgView.backgroundColor = .black.withAlphaComponent(0.0)

            self.contentView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: CGFloat(self.contentHeight))
        }, completion: { _ in
            self.removeFromSuperview()
        })
   
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

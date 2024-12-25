//
//  TRChatSendView.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/9/26.
//

import UIKit

enum SendState : Int{
    case normal = 0
    case more = 1
    case emj = 2
}

class TRChatSendView: UIView , UITextViewDelegate {
    var isSending = false
    var contentView : UIView!
    var moreView : TRChatMoreView!
    var switchBtn : UIButton!
    var textView : UITextView!
    
    var sendBtn : UIButton!
    var moreBtn : UIButton!
    var emjBtn : UIButton!
    var block : Int_Str_Block?
    var testBlock : Int_Str_Block?
    
    var state : SendState = .normal
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        contentView = UIView()
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        
        textView = UITextView()
//        textField.placeholder = "输入"
        textView.returnKeyType = .send
        textView.delegate = self;
        textView.font = UIFont.trFont(fontSize: 15)
        textView.textColor = UIColor.hexColor(hexValue: 0x333333)
        textView.backgroundColor = UIColor.bgColor()
        textView.layer.cornerRadius = 5
        
        textView.layer.masksToBounds = true
        contentView.addSubview(textView)
        
//        sendBtn = UIButton()
//        sendBtn.setTitle("发送", for: .normal)
//        sendBtn.layer.cornerRadius = 4
//        sendBtn.layer.masksToBounds = true
//        sendBtn.titleLabel?.font = UIFont.trFont(fontSize: 14)
//        sendBtn.setTitleColor(UIColor.hexColor(hexValue: 0x333333), for: .normal)
//        sendBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
//        contentView.addSubview(sendBtn)
        
        moreView = TRChatMoreView(frame: .zero)
        contentView.addSubview(moreView)
        
        moreBtn = TRFactory.buttonWith(image: UIImage(named: "chat_more"), superView: contentView)
        moreBtn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        //暂时不做emj
//        emjBtn = TRFactory.buttonWith(image: UIImage(named: "chat_emj"), superView: contentView)
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        textView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.height.equalTo(38)
            make.top.equalTo(contentView).offset(15)
            make.right.equalTo(moreBtn.snp.left).offset(-10)
        }
        moreView.isHidden = true
        moreView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView).offset(31 + 38)
            make.height.equalTo(0)
            make.bottom.equalTo(contentView).offset(IS_IphoneX ? -35 : -0)
        }
        moreBtn.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalTo(contentView).offset(-16)
        }

        

    }
    @objc func moreAction(){
        
        textView.resignFirstResponder()
        if state == .normal {
            moreView.isHidden = false
            moreView.snp.remakeConstraints { make in
                make.left.right.equalTo(contentView)
                make.top.equalTo(contentView).offset(31 + 38)
                make.height.equalTo(190)
                make.bottom.equalTo(contentView).offset(IS_IphoneX ? -35 : -0)
            }
            state = .more
        } else if state == .more {
            moreView.isHidden = true
            moreView.snp.remakeConstraints { make in
                make.left.right.equalTo(contentView)
                make.top.equalTo(contentView).offset(31 + 38)
                make.height.equalTo(0)
                make.bottom.equalTo(contentView).offset(IS_IphoneX ? -35 : -0)
            }
            state = .normal
        }
    }
    @objc func sendMsg(){
        guard !isSending else { return } // 如果已经在发送消息，则直接返回
        isSending = true // 标记为正在发送
        if block != nil {
            block!(MsgType.text.rawValue,textView.text)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1秒后重置标志
            self.isSending = false
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if state != .normal {
            moreView.isHidden = true
            moreView.snp.remakeConstraints { make in
                make.left.right.equalTo(contentView)
                make.top.equalTo(contentView).offset(31 + 38)
                make.height.equalTo(0)
                make.bottom.equalTo(contentView).offset(IS_IphoneX ? -35 : -0)
            }
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.elementsEqual("\n") {
          sendMsg()
            
            return false
        }
        
        return true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

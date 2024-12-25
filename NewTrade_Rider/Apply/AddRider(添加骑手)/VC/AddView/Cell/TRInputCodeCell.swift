//
//  TRInputCodeCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit
import RxSwift
import RxCocoa
class TRInputCodeCell: UITableViewCell {
    private var itemLab : UILabel!
    var valueTextField : TRPlaceHolderTextView!
    var model : TRApplerRiderContainer!
    var sendBtn : UIButton!
    //遇到*变红
    var item : String = "" {
        didSet {
            if (item.first == Character("*")) {
                item.remove(at: item.startIndex)
                itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .hexColor(hexValue: 0xF54444), str2: item, font2: .trFont(fontSize: 15), color2: .txtColor())

            } else {
                itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .white, str2: item, font2: .trFont(fontSize: 15), color2: .txtColor())

            }
        }
    }
    //bgView是否内缩，没内缩 item left间距16 内缩12
    var inset = false {
        didSet {
            if inset {
                bgView.snp.updateConstraints { make in
                    make.left.right.equalTo(contentView).inset(16)
                }
                self.innerSpad = 12
            } else {
                bgView.snp.updateConstraints { make in
                    make.left.right.equalTo(contentView).inset(0)
                }
                self.innerSpad = 16
            }
        }
    }
    let bgView = UIView()

    var bag = DisposeBag()
    private var innerSpad = 16 {
        didSet {
            itemLab.snp.updateConstraints { make in
                make.left.equalTo(bgView).offset(innerSpad)
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    private func setupView(){
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
      
        itemLab = UILabel()
        itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .hexColor(hexValue: 0xF54444), str2: "商品名称", font2: .trFont(fontSize: 15), color2: .txtColor())
        bgView.addSubview(itemLab)
        
        valueTextField = TRPlaceHolderTextView()
        valueTextField.font = .trMediumFont(fontSize: 15)
        valueTextField.placeholder = "请输入"
        valueTextField.textView.keyboardType = .numberPad
        valueTextField.configuration.maxLines = 1
        valueTextField.textColor = .txtColor()
        bgView.addSubview(valueTextField)
        
//        TRFactory.labelWith(font: .trBoldFont(fontSize: 15), text: "肉禽蛋", textColor: .txtColor(), superView: contentView)
        sendBtn = TRFactory.buttonWithCorner(title: "获取验证码", bgColor: .hexColor(hexValue: 0xEEF2FF), font: .trMediumFont(fontSize: 12), corner: 15)
        sendBtn.setTitleColor(.themeColor(), for: .normal)
        bgView.addSubview(sendBtn)
        sendBtn.rx.tap.subscribe(onNext: {[weak self] in
            //发送验证码  暂时不用了
//            TRGCDTimer.share.destoryTimer(withName: "sendx33xLoginCode")
//            guard let self = self else { return }
//            if model.phone.isEmpty {
//                SVProgressHUD.showInfo(withStatus: "请输入手机号")
//                return
//            }
//            let pars = ["phone":model.phone]
//          
//            TRNetManager.shared.userAuthService(url: URL_Send_Code, method: .get, pars: pars) {[weak self] dict in
//                guard let self = self else {return}
//                guard let model = TRCodeModel.deserialize(from: dict) else {return}
//                if model.code == 1 {
//                    TRGCDTimer.share.destoryTimer(withName: "sendLoginCode")
//                    sendBtn!.isUserInteractionEnabled = false
//                    
//                    SVProgressHUD.showSuccess(withStatus: "验证码发送成功")
//                    var time = Time_Send_Code
//                    TRGCDTimer.share.createTimer(withName: "sendLoginCode", timeInterval: 1, queue: .main, repeats: true) {
//                        time -= 1
//                        if time <= 0 {
//                            self.sendBtn!.isUserInteractionEnabled = true
//                            self.sendBtn!.setTitle("重新发送", for: .normal)
//                            TRGCDTimer.share.destoryTimer(withName: "sendLoginCode")
//                        } else {
//                            self.sendBtn!.setTitle("\(time)" + "s", for: .normal)
//                        }
//                    }
//                } else {
//                    SVProgressHUD.showInfo(withStatus: model.exceptionMsg)
//                }
//            }
        }).disposed(by: bag)
        
        let line = UIView()
        line.backgroundColor = .hexColor(hexValue: 0xF4F6F8)
        bgView.addSubview(line)
        
        itemLab.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(20)
            make.bottom.equalTo(bgView).offset(-20)
            make.left.equalTo(bgView).offset(16)
        }
        valueTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(bgView).inset(16)
            make.right.equalTo(sendBtn.snp.left).offset(-5)
            make.left.equalTo(bgView).offset(104)
        }
        
        sendBtn.snp.makeConstraints { make in
            make.centerY.equalTo(itemLab)
            make.right.equalTo(bgView).offset(-12)
            make.height.equalTo(30)
            make.width.equalTo(78)
        }
        
        
        line.snp.makeConstraints { make in
            make.left.equalTo(valueTextField)
            make.right.equalTo(bgView).inset(16)
            make.bottom.equalTo(bgView)
            make.height.equalTo(1)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
            make.height.equalTo(62)
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

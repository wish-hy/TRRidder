//
//  TRInputVihicleCodeCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit
import RxSwift
import RxCocoa
class TRInputVihicleCodeCell: UITableViewCell {
    var itemLab : UILabel!
    var codeView : TRTrafficCodeView!
    
    var bag = DisposeBag()
    var proBtn : UIButton! // 省份选择按钮
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        
        contentView.addSubview(bgView)
        
        
        let w = (Screen_Width - 32 - 28 - 3 * 6 - 9) / 8

        itemLab = TRFactory.labelWith(font: .trFont(fontSize: 16), text: "", textColor: .txtColor(), superView: bgView)
        itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .hexColor(hexValue: 0xF54444), str2: "车牌号", font2: .trFont(fontSize: 15), color2: .txtColor())

        
        codeView = TRTrafficCodeView(frame: .zero)
        codeView.w = w
        bgView.addSubview(codeView)
        
        let btn = UIButton()
        btn.addTarget(self, action: #selector(aaaa ), for: .touchUpInside)
        codeView.addSubview(btn)
        let arrowImgV = UIImageView(image: UIImage(named: "code_down_arrow"))
        btn.addSubview(arrowImgV)
        
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView)
        }
        codeView.snp.makeConstraints { make in
            make.top.equalTo(itemLab.snp.bottom).offset(10)
            make.left.right.equalTo(bgView).inset(16)
            make.height.equalTo(w)
            make.bottom.equalTo(bgView).inset(15)
        }
        
        btn.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(codeView.firstView)
        }
        arrowImgV.snp.makeConstraints { make in
            make.centerX.equalTo(btn)
            make.bottom.equalTo(btn).inset(1)
            make.height.equalTo(8)
            make.width.equalTo(8)
        }
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
    }
    @objc func aaaa(){
        codeView.textFiled.resignFirstResponder()
        codeView.tempIndex = 0
        codeView.switchKeyBoardType(type: .provice)
//        let h = ((Screen_Width - 87) / 8 + 8 ) * 4 + 40 + (IS_IphoneX ? 25 : 0)
//        let aa = TRProvinceKeyBoard(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: h))
//
//        aa.block = {[weak self](value) in
//            guard let self = self else {return}
//            if codeView.tempCode.isEmpty {
//                codeView.tempCode = value
//                codeView.textFiled.text = value
//                
//            } else {
//                var s = codeView.tempCode
//                s.removeFirst()
//                codeView.tempCode = value + s
//                codeView.textFiled.text = value + s
//            }
//            codeView.tempIndex += 1
//            codeView.updateBorder(codeView.tempIndex)
//            //输入一个后要切换成字母键盘
//            let letterBoard = TRLetterNumKeyBoard(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: h))
//            letterBoard.cancelBlock = {[weak self] in
//                guard let self = self  else { return }
//                var s = NSMutableString(string: codeView.tempCode)
//                if s.length > 1 {
//                    s.deleteCharacters(in: .init(location: s.length - 1, length: 1))
//                    codeView.textFiled.text = s as String
//                    codeView.tempCode = s as String
//                }
//                                
//            }
//            letterBoard.block = {[weak self](value) in
//                guard let self = self else {return}
//       
//                var s = NSMutableString(string: codeView.tempCode)
//                if codeView.tempIndex <= s.length - 1 {
//                    let last = s.replacingCharacters(in: .init(location: codeView.tempIndex, length: 1), with: value)
//                    codeView.tempCode =  last
//                    codeView.textFiled.text =  last
//                } else {
//                    s.append(value)
//                    codeView.tempCode =  s as String
//                    codeView.textFiled.text =  s as String
//                }
//                codeView.tempIndex += 1
//                codeView.updateBorder(codeView.tempIndex)
//            }
//            codeView.textFiled.resignFirstResponder()
//            codeView.textFiled.inputView = letterBoard
//            codeView.textFiled.becomeFirstResponder()
//            
//        }
//        codeView.textFiled.inputView = aa
//        codeView.textFiled.becomeFirstResponder()
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

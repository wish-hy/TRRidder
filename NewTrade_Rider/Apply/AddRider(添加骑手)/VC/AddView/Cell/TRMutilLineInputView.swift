//
//  TRMutilLineInputView.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/5/31.
//

import UIKit
import RxSwift
import RxCocoa
import NextGrowingTextView
class TRMutilLineInputView: UITableViewCell {

    private var itemLab : UILabel!
    var valueTextField : NGView!
    var arrowImgV : UIImageView!
    var isInput = false {
        didSet {
            valueTextField.isUserInteractionEnabled = isInput
            arrowImgV.isHidden = isInput
        }
    }
    //遇到*变红
    var item : String = "" {
        didSet {
            if (item.first == Character("*")) {
                item.remove(at: item.startIndex)
                itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .hexColor(hexValue: 0xF54444), str2: item, font2: .trFont(fontSize: 15), color2: .txtColor())
                itemLab.snp.updateConstraints { make in
                    make.left.equalTo(bgView).offset(innerSpad)
                }
            } else {
                itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .white, str2: item, font2: .trFont(fontSize: 15), color2: .txtColor())
                itemLab.snp.updateConstraints { make in
                    make.left.equalTo(bgView).offset(innerSpad)
                }
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
    var bag = DisposeBag()
    private var innerSpad = 16 {
        didSet {
            itemLab.snp.updateConstraints { make in
                make.left.equalTo(bgView).offset(innerSpad)
            }
        }
    }
    var bgView : UIView!
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    
    
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        itemLab = UILabel()
        itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .hexColor(hexValue: 0xF54444), str2: "商品名称", font2: .trFont(fontSize: 15), color2: .txtColor())
        bgView.addSubview(itemLab)
        
        valueTextField = NGView()
        valueTextField.font = .trMediumFont(fontSize: 15)
        valueTextField.placeholder = "请输入"
        arrowImgV = UIImageView(image: UIImage(named: "advance_gray"))
        bgView.addSubview(arrowImgV)
//        valueTextField.configuration.maxLines = 200
//        valueTextField.textColor = .txtColor()
        bgView.addSubview(valueTextField)
        
//        valueTextField.actionHandler = {[weak self] _ in
//            guard let self  = self  else { return }
//            
//            valueTextField.snp.remakeConstraints { make in
//                make.top.bottom.equalTo(self.bgView).inset(16)
//                make.right.equalTo(self.arrowImgV.snp.left).offset(-5)
//                make.left.equalTo(self.bgView).offset(104)
//                if self.valueTextField!.textView.frame.size.height > 35 {
//                    make.height.equalTo(80)
//                } else {
//                    make.height.equalTo(35)
//                }
//            }
//        }
//        valueTextField.configuration.a
        


        
        let line = UIView()
        line.backgroundColor = .hexColor(hexValue: 0xF4F6F8)
        bgView.addSubview(line)
        itemLab.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(20)
//            make.bottom.equalTo(bgView).offset(-20)
            make.left.equalTo(bgView).offset(12)
        }
        valueTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(bgView).inset(16)
            make.right.equalTo(arrowImgV.snp.left).offset(-5)
            make.left.equalTo(bgView).offset(104)
            make.height.equalTo(44)
        }
        
        arrowImgV.snp.makeConstraints { make in
            make.height.width.equalTo(18)
            make.centerY.equalTo(itemLab)
            make.right.equalTo(bgView).offset(-10)
        }

        line.snp.makeConstraints { make in
            make.left.equalTo(valueTextField)
            make.right.equalTo(bgView).inset(16)
            make.bottom.equalTo(bgView)
            make.height.equalTo(1)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(0)
            make.top.bottom.equalTo(contentView)
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

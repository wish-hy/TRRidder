//
//  TRFactory.swift
//  NewTrade_Mall
//
//  Created by xph on 2023/10/12.
//

import UIKit

class TRFactory: NSObject {
    class func labelWith(font : UIFont, text : String,textColor : UIColor, alignment : NSTextAlignment, lines : Int, superView : UIView)->UILabel{
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = alignment
        label.textColor = textColor
        label.numberOfLines = lines
        superView.addSubview(label)
        return label
    }
    class func labelWith(font : UIFont, text : String,textColor : UIColor, superView : UIView)->UILabel{
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        superView.addSubview(label)
        return label
    }
    class func labelWithImportant(font : UIFont, text : String,textColor : UIColor, superView : UIView)->UILabel{
        let unitLab = UILabel()
        unitLab.text = "*"
        unitLab.font = font
        unitLab.textColor = .hexColor(hexValue: 0xFF3141)
        superView.addSubview(unitLab)
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        superView.addSubview(label)
        
        unitLab.snp.makeConstraints { make in
            make.bottom.equalTo(label)
            make.right.equalTo(label.snp.left).offset(0)
        }
        return label
    }
    //带删除线的lab
    class func labelWithDeleteLine(font : UIFont, text : String,textColor : UIColor, superView : UIView)->UILabel{
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        let line = UIView()
        line.backgroundColor = textColor
        label.addSubview(line)
        superView.addSubview(label)
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.equalTo(label)
            make.centerY.equalTo(label)
        }
        return label
    }
    //带小字号人民币符号的lab
    class func labelWithUnit(font : UIFont, text : String,textColor : UIColor, superView : UIView)->UILabel{
        let unitLab = UILabel()
        unitLab.text = "￥"
        unitLab.font = font.withSize(font.pointSize - 4)
        unitLab.textColor = textColor
        superView.addSubview(unitLab)
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        superView.addSubview(label)
        
        unitLab.snp.makeConstraints { make in
            make.bottom.equalTo(label).offset(-1)
            make.right.equalTo(label.snp.left).offset(1)
        }
        return label
    }
    
    class func buttonWith(image : UIImage?, superView : UIView)->UIButton{
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.setImage(image, for: .selected)
        button.setImage(image, for: .highlighted)
        superView.addSubview(button)
        return button
    }
    
    class func buttonWith(title : String, textColor : UIColor, font : UIFont, superView : UIView)->UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.setTitleColor(textColor, for: .selected)
        button.setTitleColor(textColor, for: .highlighted)

        button.titleLabel?.font = font
        superView.addSubview(button)
        
        return button
    }
    
    class func imageViewWith(image: UIImage?, mode : UIView.ContentMode, superView : UIView)->UIImageView
    {
        let imageView = UIImageView()
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = mode
        superView.addSubview(imageView)
        return imageView
    }
    
    class func buttonWithCorner(title : String, bgColor : UIColor ,font : UIFont, corner : CGFloat)->UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.setTitleColor(.white, for: .selected)
//        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = bgColor
        button.layer.cornerRadius = corner
        button.layer.masksToBounds = true
        button.titleLabel?.font = font
        
        return button
    }
    class func buttonWithBorder(title : String, txtColor : UIColor,borderColor : UIColor ,font : UIFont, corner : CGFloat)->UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(txtColor, for: .normal)
//        button.setTitleColor(txtColor, for: .selected)
//        button.setTitleColor(txtColor, for: .highlighted)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = corner
        button.layer.masksToBounds = true
        button.titleLabel?.font = font
        
        return button
    }
}

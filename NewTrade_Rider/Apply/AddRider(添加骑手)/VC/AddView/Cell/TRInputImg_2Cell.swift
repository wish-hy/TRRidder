//
//  TRInputImg_2Cell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRInputImg_2Cell: UITableViewCell {
    var itemLab : UILabel!
    
    var leftImgV : UIImageView!
    var rightImgV : UIImageView!
    
    var leftBtn : UIButton!
    var rightBtn : UIButton!
    
    var item : String = "" {
        didSet {
            if (item.first == Character("*")) {
                item.remove(at: item.startIndex)
                itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .hexColor(hexValue: 0xF54444), str2: item, font2: .trFont(fontSize: 15), color2: .txtColor())

            } else {
                itemLab.attributedText = NSAttributedString(string: item, attributes: [.foregroundColor : UIColor.txtColor(), .font : UIFont.trFont(fontSize: 15)])

            }
        }
    }
    var block : Int_Block?
    var leftNetModel : NetLocImageModel? {
        didSet {
            guard let leftNetModel = leftNetModel else { return }
            if leftNetModel.netUrlArr.isEmpty {return}
            
            let url = leftNetModel.netUrlArr.last!
            if url.isEmpty {
                leftImgV.image = leftNetModel.localImgArr.last!
            } else {
                leftImgV.sd_setImage(with: URL.init(string: leftNetModel.netUrlArr.last!), placeholderImage: UIImage(named: "add_rider_id_front"), context: nil)
            }
        }
    }
    var rightNetModel : NetLocImageModel? {
        didSet {
            guard let rightNetModel = rightNetModel else { return }
            if rightNetModel.netUrlArr.isEmpty {return}
            
            let url = rightNetModel.netUrlArr.last!
            if url.isEmpty {
                rightImgV.image = rightNetModel.localImgArr.last!
            } else {
                rightImgV.sd_setImage(with: URL.init(string: rightNetModel.netUrlArr.last!), placeholderImage: UIImage(named: "add_rider_id_front"), context: nil)
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        itemLab = UILabel()
        itemLab.attributedText = TRTool.richText(str1: "*", font1: .trFont(fontSize: 15), color1: .hexColor(hexValue: 0xF54444), str2: "商品名称", font2: .trFont(fontSize: 15), color2: .txtColor())
        bgView.addSubview(itemLab)
        
        leftImgV = UIImageView(image: UIImage(named: "add_rider_id_front"))
        leftImgV.clipsToBounds = true
        leftImgV.contentMode = .scaleAspectFill
        bgView.addSubview(leftImgV)
        
        leftBtn = TRFactory.buttonWith(title: "上传人像面", textColor: .themeColor(), font: .trFont(fontSize: 16), superView: bgView)
        leftBtn.setImage(UIImage(named: "album_them"), for: .normal)
        leftBtn.backgroundColor = .hexColor(hexValue: 0xEAFFF3 )
        
        rightImgV = UIImageView(image: UIImage(named: "add_rider_id_back"))
        rightImgV.clipsToBounds = true
        rightImgV.contentMode = .scaleAspectFill
        bgView.addSubview(rightImgV)
        
        rightBtn = TRFactory.buttonWith(title: "上传国徽面", textColor: .themeColor(), font: .trFont(fontSize: 16), superView: bgView)
        rightBtn.setImage(UIImage(named: "album_them"), for: .normal)
        rightBtn.backgroundColor = .hexColor(hexValue: 0xEAFFF3)
        
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView).offset(20)
        }
        
        leftImgV.snp.makeConstraints { make in
            make.left.equalTo(itemLab)
            make.top.equalTo(itemLab.snp.bottom).offset(7)
            make.right.equalTo(bgView.snp.centerX).offset(-2)
            make.height.equalTo(110)
        }
        leftBtn.snp.makeConstraints { make in
            make.left.right.equalTo(leftImgV).inset(2)
            make.top.equalTo(leftImgV.snp.bottom).offset(6)
            make.height.equalTo(36)
            make.bottom.equalTo(bgView)
        }
        
        rightImgV.snp.makeConstraints { make in
            make.right.equalTo(bgView).inset(9)
            make.top.equalTo(leftImgV)
            make.left.equalTo(bgView.snp.centerX).offset(2)
            make.height.equalTo(leftImgV)
        }
        rightBtn.snp.makeConstraints { make in
            make.left.right.equalTo(rightImgV).inset(2)
            make.top.equalTo(leftImgV.snp.bottom).offset(6)
            make.height.equalTo(36)
            make.bottom.equalTo(bgView)
        }
        bgView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.left.right.equalTo(contentView).inset(16)
        }
        
        
        leftBtn.addTarget(self, action: #selector(chooseLeftView), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(chooseRightView), for: .touchUpInside)
       

        let tapA = UITapGestureRecognizer()
        tapA.addTarget(self, action: #selector(chooseLeftView))
        leftImgV.isUserInteractionEnabled = true
        leftImgV.addGestureRecognizer(tapA)
        
        let tapB = UITapGestureRecognizer()
        tapB.addTarget(self, action: #selector(chooseRightView))
        rightImgV.isUserInteractionEnabled = true
        rightImgV.addGestureRecognizer(tapB)
    }
    @objc func chooseLeftView(){
        if block != nil {
            block!(1)
        }
    }
    @objc func chooseRightView(){
        if block != nil {
            block!(2)
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

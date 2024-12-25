//
//  TRRiderTrainContentCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/1/26.
//

import UIKit

class TRRiderTrainContentCell: UITableViewCell {
    
    var titleLab : UILabel!
    var model : TRApplerRiderContainer? {
        didSet {
            guard let model  = model  else { return }
            if model.riderInfo.curAuthStatus.elementsEqual("TRAINED") {
                for v in views {
                    v.stateImgV.isHidden = false
                    v.stateLab.isHidden = true
                }
            } else {
                for v in views {
                    v.stateImgV.isHidden = true
                    v.stateLab.isHidden = false
                }
            }
        }
    }
    private var views : [TRRiderTrainContentSubView] = []
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        bgView.trCorner(10)
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        titleLab = TRFactory.labelWith(font: .trBoldFont(20), text: "排序内容", textColor: .txtColor(), superView: bgView)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView).offset(15)
        }
        
        for i in 0...itemNames.count - 1 {
            let v = TRRiderTrainContentSubView(frame: .zero)
            v.itemImgV.image = UIImage(named: itemImgs[i])
            v.itemLab.text = itemNames[i]
            v.tag = 1001 + i
            bgView.addSubview(v)
            views.append(v)
        }
        views.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(12)
        }
        views.snp.distributeViewsAlong(axisType: 1, fixedSpacing: 10, leadSpacing: 58, tailSpacing: 15)
        
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

    
    
    
    private var itemImgs = [
        "train_safe","train_app","train_hi","train_other"
    ]
    private var itemNames = [
        "骑行安全","软件操作","礼貌用语","其他相关"
    ]
}

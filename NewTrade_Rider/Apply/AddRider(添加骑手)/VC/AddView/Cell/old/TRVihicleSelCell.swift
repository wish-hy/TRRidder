//
//  TRVihicleSelCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit
import RxSwift
import RxCocoa
//之前的类型选择，现在不用了
class TRVihicleSelCell: UITableViewCell {
    var titleLab : UILabel!
    var commonView : TRVihicleSelView!
    var specView : TRVihicleSelView!
    var bag = DisposeBag()
    var selIndex = 0 {
        didSet {
            if selIndex == 0 {
                commonView.isSel = true
                specView.isSel = false
            } else {
                commonView.isSel = false
                specView.isSel = true
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
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
//        bgView.layer.cornerRadius = 0
//        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
        
        titleLab = TRFactory.labelWith(font: .trFont(16), text: "骑手车辆信息", textColor: .txtColor(), superView: contentView)
        
        commonView = TRVihicleSelView(frame: .zero)
        commonView.layer.cornerRadius = 8
        commonView.selImgV.image = UIImage(named: "vihicle_common_sel")

        commonView.layer.borderColor = UIColor.themeColor().cgColor
        commonView.layer.borderWidth = 1
        commonView.isSel = true
        contentView.addSubview(commonView)
        
        specView = TRVihicleSelView(frame: .zero)
        specView.selTitleColor = .hexColor(hexValue: 0xE3933B)
        specView.selInfoColor = .hexColor(hexValue: 0xDCAD77)
        specView.layer.cornerRadius = 8
        specView.selImgV.image = UIImage(named: "vihicle_special_sel")
        specView.imgV.image = UIImage(named: "vihicle_special")
        specView.layer.borderColor = UIColor.hexColor(hexValue: 0xE28D30).cgColor
        specView.layer.borderWidth = 1
        specView.isSel = false
        contentView.addSubview(specView)
        
        let line = UIView()
        line.backgroundColor = .bgColor()
        contentView.addSubview(line)
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView).offset(15)
        }
        
        commonView.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.height.equalTo(95)
            make.right.equalTo(bgView.snp.centerX).offset(-7.5)
        }
        
        specView.snp.makeConstraints { make in
            make.top.height.equalTo(commonView)
            make.right.equalTo(bgView).inset(12)
            make.left.equalTo(bgView.snp.centerX).inset(7.5)
        }
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)

        }
        line.snp.makeConstraints { make in
            make.top.equalTo(specView.snp.bottom).offset(20)
            make.left.right.equalTo(bgView).inset(12)
            make.height.equalTo(1)
            make.bottom.equalTo(bgView)
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

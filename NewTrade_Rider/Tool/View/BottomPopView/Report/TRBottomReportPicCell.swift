//
//  TRBottomReportPicCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRBottomReportPicCell: UITableViewCell {
    let nameLab = UILabel()

    var chooseImgV : TRChooseImageView!
    var netLocModel : NetLocImageModel? {
        didSet {
            guard let netLocModel = netLocModel else { return }
            chooseImgV.netLocImgModel = netLocModel
            //处理高度变化，不用了
//            let space = (4 - 1) * 10
//            let w = (Screen_Width - 32.0 - 30.0) / 4.0
//            
//            if netLocModel.localImgArr.count >= 4 {
//                chooseImgV.snp.remakeConstraints { make in
//                    make.right.left.equalTo(contentView).inset(16)
//                    make.top.equalTo(nameLab.snp.bottom).offset(10)
//                    make.height.equalTo(w * 2 + 20)
//                    make.bottom.equalTo(contentView).inset(15)
//                }
//            } else {
//                chooseImgV.snp.remakeConstraints { make in
//                    make.right.left.equalTo(contentView).inset(16)
//                    make.top.equalTo(nameLab.snp.bottom).offset(10)
//                    make.height.equalTo(w)
//                    make.bottom.equalTo(contentView).inset(15)
//                }
//            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        
        let pointLab = UILabel()
        pointLab.text = "*"
        pointLab.textColor = UIColor.hexColor(hexValue: 0xF93F3F)
        pointLab.font = UIFont.trFont(fontSize: 16)
        contentView.addSubview(pointLab)
        
        nameLab.text = "图片"
        nameLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        nameLab.font = UIFont.trBoldFont(fontSize: 16)
        contentView.addSubview(nameLab)

        chooseImgV = TRChooseImageView(frame: .zero)
        chooseImgV.netLocImgModel = NetLocImageModel()

        contentView.addSubview(chooseImgV)
        
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        
        pointLab.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(16)
        }
        nameLab.snp.makeConstraints { make in
            make.centerY.equalTo(pointLab)
            make.left.equalTo(pointLab.snp.right).offset(0)
        }
        let space = (4 - 1) * 10
        let w = (Screen_Width - 32.0 - 30.0) / 4.0
        chooseImgV.snp.makeConstraints { make in

            make.right.left.equalTo(contentView).inset(16)
            make.top.equalTo(nameLab.snp.bottom).offset(10)
            make.height.equalTo(w)
            make.bottom.equalTo(contentView).inset(15)
        }

        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
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

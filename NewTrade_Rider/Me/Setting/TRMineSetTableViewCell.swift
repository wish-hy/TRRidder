//
//  TRMineSetTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineSetTableViewCell: UITableViewCell {
    var titleLab : UILabel!
    var desLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "个人信息"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(titleLab)
        
        desLab = UILabel()
        desLab.text = "150 8868 5540"
        desLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        desLab.font = UIFont.trBoldFont(fontSize: 14)
        contentView.addSubview(desLab)
        
        let arrowImgV = UIImageView(image: UIImage(named: "blance_arrow"))
        contentView.addSubview(arrowImgV)
        
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
            
        }
        arrowImgV.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.centerY.equalTo(titleLab)
            make.right.equalTo(contentView).inset(16)
        }
        desLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(arrowImgV.snp.left).offset(-2)
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
        var inset = false {
            didSet {
                if inset {
                    contentView.snp.updateConstraints { make in
                        make.left.right.equalTo(contentView).inset(16)
                    }
    //                self.innerSpad = 12
                } else {
                    contentView.snp.updateConstraints { make in
                        make.left.right.equalTo(contentView).inset(0)
                    }
    //                self.innerSpad = 16
                }
            }
        }

}

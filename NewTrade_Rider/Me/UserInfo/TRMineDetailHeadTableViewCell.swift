//
//  TRMineDetailHeadTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/11.
//

import UIKit

class TRMineDetailHeadTableViewCell: UITableViewCell {
    var titleLab : UILabel!
    var head : UIImageView!
    
    var netLoclImgModel : NetLocImageModel? {
        didSet {
            guard let netLoclImgModel = netLoclImgModel else { return }
            
            if !netLoclImgModel.localImgArr.isEmpty {
                if netLoclImgModel.netURL.elementsEqual("") {
                    head.image = netLoclImgModel.localImgArr.first

                } else {
                    head.sd_setImage(with: URL.init(string: netLoclImgModel.netURL), placeholderImage: Net_Def_Rider_Head, context: nil)
                }
            } else {
                head.image = netLoclImgModel.localImgArr.first
                
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        let topView = UIView()
        topView.backgroundColor = .bgColor()
        contentView.addSubview(topView)
        
        titleLab = UILabel()
        titleLab.text = "头像"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(titleLab)
        
        head = UIImageView(image: Net_Def_Rider_Head)
        head.contentMode = .scaleAspectFill
        head.trCorner(6)
        contentView.addSubview(head)
        
        let arrow = UIImageView(image: UIImage(named: "advance_gray"))
        contentView.addSubview(arrow)
        
        let line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
        topView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(6)
        }
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        
        head.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.right.equalTo(contentView).offset(-32)
            make.centerY.equalTo(contentView)
        }
        arrow.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-16)
            make.width.height.equalTo(18)
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

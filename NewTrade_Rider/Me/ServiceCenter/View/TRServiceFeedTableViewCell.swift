//
//  TRServiceFeedTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxSwift
import RxCocoa
class TRServiceFeedTableViewCell: UITableViewCell {

    var limitView : TRLimitTextView!
    var picTipLab  : UILabel!
    
    var picView : TRChooseImageView!
    
    var phoneTipLab : UILabel!
    var phoneTF : UITextField!
    var arrowImgV : UIImageView!
    var netLocImgModel : NetLocImageModel? {
        didSet {
            picView.netLocImgModel = netLocImgModel
//            if netLocImgModel != nil {
//                if netLocImgModel!.netNameArr.count <= 3 {
//                    picView.snp.updateConstraints { make in
//
//                        make.height.equalTo((Screen_Width - 62.0) / 4.0)
//                    }
//                } else {
//                    picView.snp.updateConstraints { make in
//
//                        make.height.equalTo((Screen_Width - 62.0) / 4.0 * 2 + 10)
//                    }
//                }
//            }
        }
    }
    var bag : DisposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        setupView()
    }
    private func setupView(){
        limitView = TRLimitTextView(frame: .zero)
        limitView.numLab.snp.remakeConstraints { make in
            make.left.right.equalTo(limitView)
            make.bottom.equalTo(limitView).inset(14)
        }
        limitView.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(limitView)
        
        picTipLab = UILabel()
        contentView.addSubview(picTipLab)
        
        picView = TRChooseImageView(frame: .zero)
        picView.netLocImgModel = NetLocImageModel()
        contentView.addSubview(picView)
        
        phoneTipLab = UILabel()
        phoneTipLab.text = "手机号"
        phoneTipLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        phoneTipLab.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(phoneTipLab)
        
        phoneTF = UITextField()
        phoneTF.placeholder = "请输入手机号"
        phoneTF.textColor = UIColor.hexColor(hexValue: 0x141414)
        phoneTF.textAlignment = .right
        phoneTF.font = UIFont.trFont(fontSize: 15)
        contentView.addSubview(phoneTF)
        
        let arrowImgV = UIImageView(image: UIImage(named: "advance_gray"))
        contentView.addSubview(arrowImgV)
        
        limitView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(120)
        }
        
        picTipLab.snp.makeConstraints { make in
            make.left.equalTo(limitView)
            make.top.equalTo(limitView.snp.bottom).offset(20)
            
        }
        picView.snp.makeConstraints { make in
            make.left.right.equalTo(limitView)
            make.top.equalTo(picTipLab.snp.bottom).offset(12)
            make.height.equalTo((Screen_Width - 62.0) / 4.0)
        }
        
        phoneTipLab.snp.makeConstraints { make in
            make.left.equalTo(limitView)
            make.top.equalTo(picView.snp.bottom).offset(30)
        }
        
        phoneTF.snp.makeConstraints { make in
            make.centerY.equalTo(phoneTipLab)
            make.right.equalTo(arrowImgV.snp.left).offset(-8)
            make.height.equalTo(28)
            make.left.equalTo(phoneTipLab.snp.right)
            make.bottom.equalTo(contentView).inset(15)
        }
        
        arrowImgV.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.centerY.equalTo(phoneTipLab)
            make.right.equalTo(contentView).offset(-16)
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

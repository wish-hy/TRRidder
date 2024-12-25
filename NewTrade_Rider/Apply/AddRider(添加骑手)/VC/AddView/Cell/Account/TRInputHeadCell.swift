//
//  TRInputHeadCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRInputHeadCell: UITableViewCell {
    var imgV : UIImageView!
    private var deletebtn : UIButton!
    
    var deleteBlock : Void_Block?
    var addPicBlock : Void_Block?
    
    var netLocModel : NetLocImageModel? {
        didSet {
            guard let netLocModel = netLocModel else { 
                imgV.image = UIImage(named: "upload_head_bg")
                deletebtn.isHidden = true
                return }
            if netLocModel.localImgArr.isEmpty {
                deletebtn.isHidden = true
                imgV.image = UIImage(named: "upload_head_bg")
            } else {
                deletebtn.isHidden = false
                if netLocModel.netURL.isEmpty {
                    imgV.image = netLocModel.localImgArr.last
                } else {
                    imgV.sd_setImage(with: URL.init(string: netLocModel.netUrlArr.last!), placeholderImage: UIImage(named: "upload_head_bg"), context: nil)
                }
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
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 125), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer;
        
        imgV = TRFactory.imageViewWith(image: UIImage(named: "upload_head_bg"), mode: .scaleAspectFill, superView: contentView)
        imgV.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(addPic))
        imgV.addGestureRecognizer(tapGes)
        
        imgV.snp.makeConstraints { make in
            make.left.equalTo(bgView).inset(12)
            make.top.equalTo(contentView).inset(15)
            make.bottom.equalTo(contentView).inset(20)
            make.height.width.equalTo(98)
        }
        
        deletebtn = TRFactory.buttonWith(image: UIImage(named: "image_delete"), superView: contentView)
        deletebtn.isHidden = true
        deletebtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)

        }
        deletebtn.snp.makeConstraints { make in
            make.top.right.equalTo(imgV)
            make.width.height.equalTo(20)
        }
    }
    @objc func addPic(){
        if addPicBlock != nil {
            addPicBlock!()
        }
    }
    @objc func deleteAction(){
        if deleteBlock != nil {
            deleteBlock!()
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

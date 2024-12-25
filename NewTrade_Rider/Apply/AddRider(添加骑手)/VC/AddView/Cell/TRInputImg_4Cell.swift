//
//  TRInputImg_4Cell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRInputImg_4Cell: UITableViewCell {
    
    var itemLab : UILabel!
    
    var oneBtn : TRImgAddDashBtn!
    
    var twoBtn : TRImgAddDashBtn!

    
    var threeBtn : TRImgAddDashBtn!

    var fourBtn : TRImgAddDashBtn!

    var block : Int_Block?
    var frontPictureNetModel : NetLocImageModel?{
        didSet {
            guard let frontPictureNetModel = frontPictureNetModel else { return }
            if frontPictureNetModel.netUrlArr.isEmpty {return}
            
            let url = frontPictureNetModel.netUrlArr.last!
            if url.isEmpty {
                oneBtn.preImgView.image = frontPictureNetModel.localImgArr.last!
            } else {
                oneBtn.preImgView.sd_setImage(with: URL.init(string: frontPictureNetModel.netUrlArr.last!), placeholderImage: UIImage(named: "camera"), context: nil)
            }
        }
    }
    var groupPictureNetModel : NetLocImageModel?{
        didSet {
            guard let groupPictureNetModel = groupPictureNetModel else { return }
            
            if groupPictureNetModel.netUrlArr.isEmpty {return}
            
            let url = groupPictureNetModel.netUrlArr.last!
            if url.isEmpty {
                fourBtn.preImgView.image = groupPictureNetModel.localImgArr.last!
            } else {
                fourBtn.preImgView.sd_setImage(with: URL.init(string: groupPictureNetModel.netUrlArr.last!), placeholderImage: UIImage(named: "camera"), context: nil)
            }
        }
    }
    var backPictureNetModel : NetLocImageModel?{
        didSet {
            guard let backPictureNetModel = backPictureNetModel else { return }
            
            if backPictureNetModel.netUrlArr.isEmpty {return}
            
            let url = backPictureNetModel.netUrlArr.last!
            if url.isEmpty {
                threeBtn.preImgView.image = backPictureNetModel.localImgArr.last!
            } else {
                threeBtn.preImgView.sd_setImage(with: URL.init(string: backPictureNetModel.netUrlArr.last!))
            }
        }
    }
    var sidePictureNetModel : NetLocImageModel?{
        didSet {
            guard let sidePictureNetModel = sidePictureNetModel else { return }
            
            
            if sidePictureNetModel.netUrlArr.isEmpty {return}
            
            let url = sidePictureNetModel.netUrlArr.last!
            if url.isEmpty {
                twoBtn.preImgView.image = sidePictureNetModel.localImgArr.last!
            } else {
                twoBtn.preImgView.sd_setImage(with: URL.init(string: sidePictureNetModel.netUrlArr.last!), placeholderImage: UIImage(named: "camera"), context: nil)
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
        bgView.trCorner(f: 10)
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        itemLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 20), text: "车辆照片", textColor: .txtColor(), superView: contentView)
        
        let w = (Screen_Width - 75) / 2
        oneBtn = TRImgAddDashBtn(frame: CGRect(x: 0, y: 0, width: w, height: w))
        
        oneBtn.titleLab.text = "车头照片"
        contentView.addSubview(oneBtn)
        
        twoBtn = TRImgAddDashBtn(frame: CGRect(x: 0, y: 0, width: w, height: w))
        twoBtn.titleLab.text = "侧面照片"
        contentView.addSubview(twoBtn)
        
        threeBtn = TRImgAddDashBtn(frame: CGRect(x: 0, y: 0, width: w, height: w))
        threeBtn.titleLab.text = "车尾照片"
        contentView.addSubview(threeBtn)
        
        fourBtn = TRImgAddDashBtn(frame: CGRect(x: 0, y: 0, width: w, height: w))
        fourBtn.titleLab.text = "骑手与车合照"
        contentView.addSubview(fourBtn)
        
        
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(contentView).offset(15)
        }
        oneBtn.snp.makeConstraints { make in
            make.left.equalTo(itemLab)
            
            make.top.equalTo(itemLab.snp.bottom).offset(15)
            make.width.height.equalTo(w)
        }
        twoBtn.snp.makeConstraints { make in
            make.left.equalTo(oneBtn.snp.right).offset(13)
            make.width.height.top.equalTo(oneBtn)
        }
        
        //>>
        threeBtn.snp.makeConstraints { make in
            make.left.right.equalTo(oneBtn)
            make.top.equalTo(oneBtn.snp.bottom).offset(10)
            make.width.height.equalTo(w)
        }
        fourBtn.snp.makeConstraints { make in
            make.left.right.equalTo(twoBtn)
            make.top.equalTo(threeBtn)
            make.width.height.equalTo(w)
            make.bottom.equalTo(contentView).inset(15)
        }
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)

        }
        oneBtn.tag = 3000
        twoBtn.tag = 4000
        threeBtn.tag = 5000
        fourBtn.tag = 6000
        oneBtn.addTarget(self, action: #selector(addPic), for: .touchUpInside)
        twoBtn.addTarget(self, action: #selector(addPic), for: .touchUpInside)
        threeBtn.addTarget(self, action: #selector(addPic), for: .touchUpInside)
        fourBtn.addTarget(self, action: #selector(addPic), for: .touchUpInside)

    }
    @objc func addPic(sender : UIButton) {
        if block != nil {
            block!(sender.tag / 1000)
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

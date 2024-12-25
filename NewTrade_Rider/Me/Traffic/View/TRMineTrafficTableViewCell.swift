//
//  TRMineTrafficTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit
import RxSwift
import RxCocoa

class TRMineTrafficTableViewCell: UITableViewCell {

    var carImagV : UIImageView!
    
    var carCode : UILabel!
    var userLab : UILabel!
    var typeLab : UILabel!
    
    var timeLab : UILabel!
    
    var editBtn : UIButton!
    
    var bag = DisposeBag()
    
    var trafficModel : TRApplerVehicleInfoModel? {
        didSet {
            guard let trafficModel = trafficModel else { return }
            carImagV.sd_setImage(with: URL(string: trafficModel.iconUrl), placeholderImage: UIImage(named: "traffic_car"), context: nil)
            carCode.text = trafficModel.numberplate
            userLab.text =  "所有人：" + trafficModel.owner
            timeLab.text = "下次年检时间：\(trafficModel.inspectionDate)"
            typeLab.text = " \(trafficModel.codeName) "
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()

    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        let bgView = UIView()
        bgView.layer.cornerRadius = 13
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        carImagV = UIImageView(image: UIImage(named: "traffic_car"))
        carImagV.layer.cornerRadius = 8
        carImagV.layer.masksToBounds = true
        contentView.addSubview(carImagV)
        
        carCode = UILabel()
        carCode.text = "粤B·88888A"
        carCode.textColor = .txtColor()
        carCode.font = .trMediumFont(20)
        contentView.addSubview(carCode)
        
        userLab = UILabel()
        userLab.text = "所有人：张三"
        userLab.textColor = UIColor.hexColor(hexValue: 0x97989A )
        userLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(userLab)
        
        typeLab = UILabel()
        typeLab.text = " 小汽车 "
        typeLab.layer.cornerRadius = 4
        typeLab.layer.masksToBounds = true
        typeLab.layer.borderWidth = 1
        typeLab.layer.borderColor = UIColor.hexColor(hexValue: 0xC6C9CB).cgColor
        typeLab.textColor = UIColor.hexColor(hexValue: 0xC6C9CB)
        typeLab.font = UIFont.trFont(fontSize: 13)
        contentView.addSubview(typeLab)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(lineView)
        
        
        timeLab = UILabel()
        timeLab.text = "下次年检时间：2030.05.20"
        timeLab.textColor = UIColor.hexColor(hexValue: 0x97989A )
        timeLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(timeLab)
        
        editBtn = UIButton()
        editBtn.setImage(UIImage(named: "edit"), for: .normal)
        editBtn.setImage(UIImage(named: "edit"), for: .normal)
        contentView.addSubview(editBtn)
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView)
        }
        carImagV.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.left.equalTo(bgView).offset(15)
            make.top.equalTo(bgView).offset(15)
        }
        carCode.snp.makeConstraints { make in
            make.top.equalTo(carImagV)
            make.left.equalTo(carImagV.snp.right).offset(10)
        }
        userLab.snp.makeConstraints { make in
            make.bottom.equalTo(carImagV)
            make.left.equalTo(carCode)
        }
        typeLab.snp.makeConstraints { make in
            make.centerY.equalTo(userLab)
            make.left.equalTo(userLab.snp.right).offset(15)
            make.height.equalTo(18)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(carImagV.snp.bottom).offset(19)
            make.height.equalTo(1)
        }
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(carImagV)
            make.top.equalTo(lineView).offset(16)
        }
        editBtn.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalTo(carCode)
            make.right.equalTo(bgView).offset(-13)
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

//
//  TRRiderApplyRecordDetailResonCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/24.
//

import UIKit

class TRRiderApplyRecordDetailResonCell: UITableViewCell {

    var titleLab : UILabel!
    var resonLab : UILabel!
    
    var auditorTipLab : UILabel!
    var timeTipLab : UILabel!
    var auditorLab : UILabel!
    var timeLab : UILabel!
    
    var recordModel : TRRiderApplyRecordModel? {
        didSet {
            guard let model = recordModel else { return }
            resonLab.text = model.authContext
            timeLab.text = model.authTime
            auditorLab.text = model.authOperator
            
            if model.authStatus.elementsEqual("UNAUDITED") {
               //不会出现
                titleLab.text = "正在审核中"
                timeTipLab.text = "申请时间"
                timeLab.text = model.createTime
            } else if model.authStatus.elementsEqual("REJECTED") {
                titleLab.text = "审核不通过原因"
            } else if model.authStatus.elementsEqual("APPROVE") {
                titleLab.text = "审核通过说明"
            } else if model.authStatus.elementsEqual("UNSIGNED") {
                titleLab.text = "审核通过说明"
            } else if model.authStatus.elementsEqual("UNTRAINED") {
                titleLab.text = "审核通过说明"
            } else if model.authStatus.elementsEqual("TRAINED") {
                titleLab.text = "审核通过说明"
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.trCorner(10)
        contentView.addSubview(bgView)
        
        titleLab = TRFactory.labelWith(font: .trMediumFont(16), text: "审核不通过原因：", textColor: .txtColor(), superView: bgView)
        
        let reasonbgView = UIView()
        reasonbgView.trCorner(8)
        reasonbgView.backgroundColor = .hexColor(hexValue: 0xF4F5F7)
        bgView.addSubview(reasonbgView)
        
        resonLab = TRFactory.labelWith(font: .trFont(14), text: "根据对比来思考并不会让人逻辑混乱，因为即使是对比也可以联结称一个和谐的整体", textColor: .txtColor(), superView: bgView)
        resonLab.numberOfLines = 0
        
        auditorTipLab = TRFactory.labelWith(font: .trFont(16), text: "审核人员", textColor: .hexColor(hexValue: 0x67686A), superView: bgView)
        auditorLab = TRFactory.labelWith(font: .trMediumFont(16), text: "系统处理", textColor: .txtColor(), superView: bgView)
        
        timeTipLab = TRFactory.labelWith(font: .trFont(16), text: "审核时间", textColor: .hexColor(hexValue: 0x67686A), superView: bgView)
        timeLab = TRFactory.labelWith(font: .trMediumFont(16), text: "----", textColor: .txtColor(), superView: bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).inset(15)
            make.top.equalTo(bgView).offset(15)
        }
        reasonbgView.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(15)
            make.top.equalTo(titleLab.snp.bottom).offset(12)
        }
        resonLab.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(reasonbgView).inset(8)
        }
        auditorTipLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(reasonbgView.snp.bottom).offset(16)
            
        }
        auditorLab.snp.makeConstraints { make in
            make.top.equalTo(auditorTipLab)
            make.left.equalTo(auditorTipLab.snp.right).offset(32)
        }
        
        timeTipLab.snp.makeConstraints { make in
            make.left.equalTo(auditorTipLab)
            make.top.equalTo(auditorTipLab.snp.bottom).offset(20)
        }
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(auditorLab)
            make.top.equalTo(timeTipLab)
            make.bottom.equalTo(bgView).inset(20)

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

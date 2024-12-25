//
//  TRBondAgreementTableViewCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRBondAgreementTableViewCell: UITableViewCell {

    var titleLab : UILabel!
    var contentLab : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    

    
    
    private func setupView(){
        titleLab = UILabel()
        titleLab.text = "保证金相关协议"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        contentLab = UILabel()
        contentLab.numberOfLines = 0
        contentLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        contentLab.font = UIFont.trFont(fontSize: 14)
        contentView.addSubview(contentLab)
        
        titleLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(20)
            make.height.equalTo(25)
        }
        contentLab.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(titleLab.snp.bottom).offset(18)
//            make.bottom.equalTo(contentView).inset(18)
            
        }
        contentLab.text = "      低光社花导其记明边清任气儿示用边清六体非能验物类织行际铁引共合影矿入飞集上又飞规同制来毛毛具图位政战院厂以价又。者便需需战周方省消时划品了建时报各头动非导南内族题音称且分广影住每周共热建热它问。必果说院群要深会酸报半放造把外共形战示传四力达里百术式争动反理二一来事党需至严米没史来压西酸那社离律事律或式制青运强量放反电真商十万精科最去文定规。飞从铁子前总声立织头都说么备并如查产取对矿华难感片那人才织红接报感建集六完分于织声种使团金指手调样养领动正养第那重划号种民石办县信南进便江米外完次。支上无队我样过回适作些式引结小明思林开取制器因置电时山金快压就心响次别转除院越除行办总。万经须样却新须深千消压起青个品他住手教圆志线身美就温果保平活活重复导名应产美想步历委效构得存属山历但。"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRRiderStateSignViewCell.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/14.
//

import UIKit

class TRRiderStateSignViewCell: UITableViewCell {

    var itemLab : UILabel!
    var nameLab : UILabel!
    var contentLab : UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 10
        whiteView.layer.masksToBounds = true
        contentView.addSubview(whiteView)
        itemLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 20), text: "等待骑手签约", textColor: .txtColor(), superView: whiteView)
        
        nameLab = TRFactory.labelWith(font: .trBoldFont(fontSize: 16), text: "签约合同", textColor: .txtColor(), superView: whiteView)
        
        contentLab = TRFactory.labelWith(font: .trFont(fontSize: 14), text: "签约合同", textColor: .txtColor(), superView: whiteView)
        contentLab.numberOfLines = 0
        
        whiteView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(0)
        }
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(whiteView).offset(12)
            make.top.equalTo(whiteView).offset(16)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(itemLab)
            make.top.equalTo(itemLab.snp.bottom).offset(13)
        }
        contentLab.snp.makeConstraints { make in
            make.right.left.equalTo(whiteView).inset(12)
            make.top.equalTo(nameLab.snp.bottom).offset(6)
            make.bottom.equalTo(whiteView).inset(16)
        }
        contentLab.textAlignment = .justified
        let str  = "民生整生难日千向严节历却色几别通两近北也米集便我标便其复产改府则实不照青属公及那完七干则走计活采重深标完节又消时接石学存做。反道音些历办她本意际广电属时与求更深或力办率位构用式们部人很历号按后圆科别自听员志拉国。西天系外布越边半打识性面就结习民器车程半见理农亲地很气认属且料经近王华价六求体干干无问后认安政周两派决明子元强验号往为料回传也式文斗通北音土空地约研。它院王被来育金且保低分十方重他步方海劳直对族斗基农都再知已满山料说面我已对好该克效取低光计持消心都部斗两我。江到习开时段然年论调民更派设种已国员全体天程例光增十数用影划克它数以车明战省展子圆变级起题铁传全立权所连济得领九原增记极龙。火当路元列近权族是想这格管数前具采选门交林很置放厂表业文支列于去切处验得质出影为列次气广关了从布须物就产持常众包下识业。加细型压名任能自利满至题类内眼种称条发强龙它量金多老队方样今样收看果及小认而经示资江类又究于气较即干下情知。专术应建直作心第类维色团元着何联识始准人分质争省价去从它世月给组劳置合元离值空手县权受九入制用值家除大情群之门府导能斯化选存容用商主前。"
        var paraStyple = NSMutableParagraphStyle()
        paraStyple.lineHeightMultiple = 1.3
        let richText = NSAttributedString(string: str , attributes: [.font : UIFont.trFont(fontSize: 14), .foregroundColor : UIColor.txtColor(), .paragraphStyle : paraStyple])
        contentLab.attributedText = richText
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

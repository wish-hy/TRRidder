//
//  TRHomeBeginSetTableViewCell2.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/5.
//

import UIKit
import RxCocoa
import RxSwift
class TRHomeBeginSetTableViewCell2: UITableViewCell {


    var titleLab : UILabel!
    var customSwitch : UISwitch!
    var line : UIView!
    
    var timeSetView : UIView!
    var block : Int_Block?
    var  startBtn : UIButton!
    var endBtn : UIButton!
    let bag = DisposeBag()
    
    var startTime : String = "" {
        didSet {
            
            if startTime == "" {
                startBtn.setTitle("从现在", for: .normal)
            }else {
                startBtn.setTitle(startTime, for: .normal)
            }
        }
    }
    var endTime : String = "" {
        didSet {
            if endTime == "" {
                endBtn.setTitle("任意时间", for: .normal)
            } else {
                endBtn.setTitle(endTime, for: .normal)
            }
        }
    }
    //0 正常 1 关闭 2 开启
    var type : Int = 0{
        didSet{

            titleLab.snp.removeConstraints()
            if type == 0 {
                titleLab.snp.makeConstraints { make in
                    make.top.equalTo(contentView).inset(15)
                    make.height.equalTo(26)
                    make.left.equalTo(contentView).offset(16)
                    make.bottom.equalTo(contentView).inset(15)
                }
            } else {
                configTimeView()
                timeSetView.snp.removeConstraints()
                if type == 1 {
                    timeSetView.isHidden = true
                    titleLab.snp.makeConstraints { make in
                        make.top.equalTo(contentView).inset(15)
                        make.height.equalTo(26)
                        make.left.equalTo(contentView).offset(16)
                        make.bottom.equalTo(contentView).inset(15)
                    }
                    
                } else {

                    timeSetView.isHidden = false
                    titleLab.snp.makeConstraints { make in
                        make.top.equalTo(contentView).inset(15)
                        make.height.equalTo(26)
                        make.left.equalTo(contentView).offset(16)
                    }
                    timeSetView.snp.makeConstraints { make in
                        make.left.right.equalTo(contentView)
                        make.height.equalTo(62)
                        make.top.equalTo(titleLab.snp.bottom).offset(15)
                        make.bottom.equalTo(contentView).inset(15)
                    }
                }
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
        titleLab = UILabel()
        titleLab.text = "抢实时单"
        titleLab.textColor = UIColor.hexColor(hexValue: 0x141414)
        titleLab.font = UIFont.trBoldFont(fontSize: 18)
        contentView.addSubview(titleLab)
        
        customSwitch = UISwitch()
        contentView.addSubview(customSwitch)
        
        line = UIView()
        line.backgroundColor = UIColor.hexColor(hexValue: 0xF4F6F8)
        contentView.addSubview(line)
      

        customSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalTo(contentView).inset(18)
        }
   
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
        
        customSwitch.rx.controlEvent(.valueChanged).subscribe(onNext : {[weak self] in
            guard let self  = self  else { return }
            let x = self.customSwitch.isOn ? 2 : 1
            if self.block != nil {
                self.block!(x)
            }
        }).disposed(by: bag)
        
    }
    private func configTimeView(){
        if timeSetView != nil {
            return
        }
        timeSetView = UIView()
        timeSetView.backgroundColor = UIColor.white
        contentView.addSubview(timeSetView)
        
        let timeTipLab = UILabel()
        timeTipLab.text = "配送预约时间"
        timeTipLab.textColor = UIColor.hexColor(hexValue: 0x686A6A)
        timeTipLab.font = UIFont.trFont(fontSize: 14)
        timeSetView.addSubview(timeTipLab)
        
        startBtn = UIButton()
        startBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        startBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A), for: .normal)
        startBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A), for: .highlighted)
        startBtn.setTitle("从现在", for: .normal)
        startBtn.titleLabel?.font = UIFont.trFont(fontSize: 14)
        timeSetView.addSubview(startBtn)
        
        let toLab = UILabel()
        toLab.text = "至"
        toLab.textColor = UIColor.hexColor(hexValue: 0x97989A)
        toLab.font = UIFont.trFont(fontSize: 14)
        timeSetView.addSubview(toLab)
        
        endBtn = UIButton()
        endBtn.backgroundColor = UIColor.hexColor(hexValue: 0xF1F3F4)
        endBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A), for: .normal)
        endBtn.setTitleColor(UIColor.hexColor(hexValue: 0x97989A), for: .highlighted)
        endBtn.setTitle("任意时间", for: .normal)
        endBtn.titleLabel?.font = UIFont.trFont(fontSize: 14)
        timeSetView.addSubview(endBtn)
        
        startBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self  = self  else { return }
            self.block!(3)
        }).disposed(by: bag)
        endBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self  else { return }
            self.block!(4)
        }).disposed(by: bag)
        timeSetView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.height.equalTo(62)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.bottom.equalTo(contentView).inset(15)
        }
        
        timeTipLab.snp.makeConstraints { make in
            make.left.equalTo(timeSetView).offset(16)
            make.top.equalTo(timeSetView)
        }
        startBtn.snp.makeConstraints { make in
            make.left.equalTo(timeTipLab)
            make.top.equalTo(timeTipLab.snp.bottom).offset(10)
            make.width.equalTo(114)
            make.height.equalTo(36)
        }
        toLab.snp.makeConstraints { make in
            make.centerY.equalTo(startBtn)
            make.left.equalTo(startBtn.snp.right).offset(5)
        }
        endBtn.snp.makeConstraints { make in
            make.left.equalTo(toLab.snp.right).offset(5)
            make.top.equalTo(timeTipLab.snp.bottom).offset(10)
            make.width.equalTo(114)
            make.height.equalTo(36)
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

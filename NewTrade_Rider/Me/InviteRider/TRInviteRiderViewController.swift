//
//  TRInviteRiderViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/10/19.
//

import UIKit

class TRInviteRiderViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bgImgV = UIImageView(image: UIImage(named: "invite_bg"))
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.frame = self.view.bounds
        self.view.addSubview(bgImgV)
        
        let titleImgV = UIImageView(image: UIImage(named: "invite_text_img"))
        titleImgV.contentMode = .scaleAspectFit
        self.view.addSubview(titleImgV)
        configNAV()

        
        titleImgV.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.size.equalTo(CGSize(width: 246 * APP_Scale, height: 66 * APP_Scale))
        }
        
        let redBgImgV = UIImageView(image: UIImage(named: "invite_redbag_bg"))
        redBgImgV.contentMode = .scaleAspectFill
//        redBgImgV.clipsToBounds = true
        self.view.addSubview(redBgImgV)
        // 726 × 894
        redBgImgV.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(8)
            make.top.equalTo(titleImgV.snp.bottom).offset(-25)
            make.height.equalTo((894.0 / 726 * (Screen_Width - 16)))
        }
        
        
        let tipLlab = UILabel()
        tipLlab.attributedText = TRTool.richText3(str1: "邀请骑手接单配送完成即可得", font1: .trFont(fontSize: 13), color1: .white, str2: "100", font2: .trFont(fontSize: 13), color2: .hexColor(hexValue: 0xFFF1A4), str3: "元", font3: .trFont(fontSize: 13), color3: .white)
        self.view.addSubview(tipLlab)
        tipLlab.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(redBgImgV).offset(-35)
        }
        
        let guizeBgImgV = UIImageView(image: UIImage(named: "invite_guize_bg"))
        guizeBgImgV.contentMode = .scaleAspectFill
        self.view.addSubview(guizeBgImgV)
        
        guizeBgImgV.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(redBgImgV.snp.bottom).offset(0)
            make.height.equalTo(30)
            make.width.equalTo(125)
        }
        
        let guizeLab = UILabel()
        guizeLab.text = "邀请规则"
        guizeLab.textColor = .white
        guizeLab.font = UIFont.trMiddleFont(fontSize: 16)
        self.view.addSubview(guizeLab)
        guizeLab.snp.makeConstraints { make in
            make.center.equalTo(guizeBgImgV)
        }
        
        let guizeContentLab = UILabel()
        guizeContentLab.text = "再大的愿景都是从小处着手，越大的图越要从小处搞，越小的东西越要从大处着眼"
        guizeContentLab.numberOfLines = 0
        guizeContentLab.textColor = .hexColor(hexValue: 0xEE4C42)
        guizeContentLab.font = UIFont.trFont(fontSize: 13)
        self.view.addSubview(guizeContentLab)
        guizeContentLab.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(18)
            make.top.equalTo(guizeBgImgV.snp.bottom).offset(5)
        }
        
        
        let layerView = UIView()
        layerView.frame = CGRect(x: 0, y: 0, width: Screen_Width - 32, height: 46)
        // fillCode
        layerView.layer.cornerRadius = 23
        layerView.layer.masksToBounds = true
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.44, blue: 0.24, alpha: 1).cgColor, UIColor(red: 0.98, green: 0.22, blue: 0.22, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = layerView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.02, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
        layerView.layer.addSublayer(bgLayer1)
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0.98, green: 0.51, blue: 0.5, alpha: 0.31).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 1.8)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 5.5
        self.view.addSubview(layerView)
        
        let wxBtn = UIButton()
        wxBtn.setImage(UIImage(named: "invite_wechat"), for: .normal)
        wxBtn.setImage(UIImage(named: "invite_wechat"), for: .highlighted)
        wxBtn.setTitle("  微信邀请赚钱", for: .normal)
        wxBtn.setTitleColor(.hexColor(hexValue: 0xEB2A2A), for: .normal)
        wxBtn.titleLabel?.font = UIFont.trBoldFont(fontSize: 18)
        wxBtn.setBackgroundImage(UIImage(named: "invite_wx_bg"), for: .normal)
        wxBtn.setBackgroundImage(UIImage(named: "invite_wx_bg"), for: .highlighted)

        self.view.addSubview(wxBtn)
        
        let faceBtn = UIButton()
        faceBtn.setImage(UIImage(named: "invite_code"), for: .normal)
        faceBtn.setImage(UIImage(named: "invite_code"), for: .highlighted)
        faceBtn.layer.cornerRadius = 24
        faceBtn.layer.masksToBounds = true
        faceBtn.layer.borderWidth = 1.5
        faceBtn.layer.borderColor = UIColor.hexColor(hexValue: 0xFFF1A4).cgColor
        faceBtn.setTitle("  面对面扫码", for: .normal)
        faceBtn.setTitleColor(.hexColor(hexValue: 0xFFF1A4), for: .normal)
        faceBtn.titleLabel?.font = UIFont.trBoldFont(fontSize: 18)
        self.view.addSubview(faceBtn)
        
        faceBtn.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(60)
            make.height.equalTo(48)
            make.bottom.equalTo(tipLlab.snp.top).offset(-15)
        }
        
        wxBtn.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(60)
            make.height.equalTo(54)
            make.bottom.equalTo(faceBtn.snp.top).offset(-15)
        }
        
        let yqBtn = UIButton()

        yqBtn.setTitle("立即邀请", for: .normal)
        yqBtn.setTitleColor(.hexColor(hexValue: 0xFFF1A4), for: .normal)
        yqBtn.titleLabel?.font = UIFont.trBoldFont(fontSize: 18)

        self.view.addSubview(yqBtn)
        
        layerView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(16)
            make.height.equalTo(46)
            make.bottom.equalTo(self.view).offset(IS_IphoneX ? -50 : -35)
        }
        yqBtn.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(layerView)
        }
        
        
        wxBtn.addTarget(self, action: #selector(wxAction), for: .touchUpInside)
        faceBtn.addTarget(self, action: #selector(faceAction), for: .touchUpInside)
        yqBtn.addTarget(self, action: #selector(yqAction), for: .touchUpInside)
    }
    @objc func wxAction(){
        
    }
    @objc func faceAction(){
        let vc = TRFaceInviteViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func yqAction(){
        
    }
    private func configNAV(){
//        let navBtn = UIButton()
//        navBtn.setImage(UIImage(named: "nav_back_white"), for: .normal)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navBtn)
//        navBtn.rx.tap.subscribe(onNext:{[weak self] in
//            self?.navigationController?.popViewController(animated: true)
//        }).disposed(by: disposeBag)
//        let lab = UILabel()
//        lab.text = "邀请骑手"
//        lab.textColor = .white
//        lab.font = UIFont.trBoldFont(fontSize: 18)
//        self.navigationItem.titleView = lab
        configNavBar()
        let btn = configNavLeftBtn()
        btn.setImage(UIImage(named: "nav_back_white"), for: .normal)
        configNavTitle(title: "邀请骑手")
        navBar?.titleLab?.textColor = .white
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

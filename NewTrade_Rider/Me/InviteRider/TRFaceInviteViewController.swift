//
//  TRFaceInviteViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/10/19.
//

import UIKit

class TRFaceInviteViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNAV()
        let bgImgV = UIImageView(image: UIImage(named: "face_invite_bg"))
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.frame = self.view.bounds
        self.view.addSubview(bgImgV)
        
        let titleImgV = UIImageView(image: UIImage(named: "face_invite_must"))
        titleImgV.contentMode = .scaleAspectFit
        self.view.addSubview(titleImgV)
        
        titleImgV.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height + 13)
            make.size.equalTo(CGSize(width: 180 * APP_Scale, height: 101 * APP_Scale))
        }
        
        let redBgImgV = UIImageView(image: UIImage(named: "face_invite_redbg"))
        redBgImgV.contentMode = .scaleAspectFill
//        redBgImgV.clipsToBounds = true
        self.view.addSubview(redBgImgV)
        // 726 × 864
        redBgImgV.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(8)
            make.top.equalTo(titleImgV.snp.bottom).offset(25)
            make.height.equalTo((864.0 / 726 * (Screen_Width - 16)))
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
        let saveBtn = UIButton()
        saveBtn.setTitle("保存图片至相册", for: .normal)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.titleLabel?.font = UIFont.trBoldFont(fontSize: 18)

        self.view.addSubview(saveBtn)
        
        layerView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(16)
            make.height.equalTo(46)
            make.top.equalTo(redBgImgV.snp.bottom)
        }
        saveBtn.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(layerView)
        }
       
        let userImgV = UIImageView(image: UIImage(named: "test"))
        userImgV.layer.cornerRadius = 21
        userImgV.layer.masksToBounds = true
        userImgV.contentMode = .scaleAspectFill
        self.view.addSubview(userImgV)
        
        let userLab = UILabel()
        userLab.text = "刘华建"
        userLab.textColor = UIColor.hexColor(hexValue: 0xC65C10)
        userLab.font = UIFont.trMiddleFont(fontSize: 16)
        self.view.addSubview(userLab)
        
        userImgV.snp.makeConstraints { make in
            make.left.equalTo(redBgImgV).offset(40)
            make.top.equalTo(redBgImgV).offset(15)
            make.width.height.equalTo(42)
        }
        userLab.snp.makeConstraints { make in
            make.centerY.equalTo(userImgV)
            make.left.equalTo(userImgV.snp.right).offset(10)
        }
    }
    private func configNAV(){
        let navBtn = UIButton()
        navBtn.setImage(UIImage(named: "nav_back_white"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navBtn)
        navBtn.rx.tap.subscribe(onNext:{[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        let lab = UILabel()
        lab.text = "面对面扫码"
        lab.textColor = .white
        lab.font = UIFont.trBoldFont(fontSize: 18)
        self.navigationItem.titleView = lab
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

//
//  TRStatisticViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit
import RxCocoa
import RxSwift
class TRStatisticViewController: BasicViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var menuView : TRStatisticMenuView!
    var collectionView : UICollectionView!
    var indexChangeBlock : Int_Block?
    
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .bgColor()

        configHeader()
        setupView()
        configNavBar()
        let btn = configNavLeftBtn()
        btn.setImage(UIImage(named: "nav_back_white"), for: .normal)
        configNavTitle(title: "我的统计")
        navBar?.titleLab?.textColor = .white
    }
    
    private func setupView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRStaticCollectionViewCell1.self, forCellWithReuseIdentifier: "cellID1")
        collectionView.register(TRStaticCollectionViewCell2.self, forCellWithReuseIdentifier: "cellID2")
        collectionView.register(TRStaticCollectionViewCell3.self, forCellWithReuseIdentifier: "cellID3")

        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(self.view)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID1", for: indexPath) as! TRStaticCollectionViewCell1
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID2", for: indexPath) as! TRStaticCollectionViewCell2
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID3", for: indexPath) as! TRStaticCollectionViewCell3
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Screen_Width, height: Screen_Height - 170 * APP_Scale)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.indexChangeBlock != nil {
           let x = (scrollView.contentOffset.x / Screen_Width)
            self.indexChangeBlock!(Int(x))
        }
    }
    
    
    
    private func configHeader(){
        let bgImgV = UIImageView(image: UIImage(named: "statistic_cf_bg"))
        self.view.addSubview(bgImgV)
        bgImgV.backgroundColor = .red
        bgImgV.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(Screen_Width * (318 / 375.0))
        }
        
        menuView = TRStatisticMenuView(frame: .zero)
        self.view.addSubview(menuView)
        
        menuView.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(16)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.right.equalTo(self.view)
            make.height.equalTo(35)
        }
        
        
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

//
//  TRMineCommentViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRMineCommentViewController: BasicViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    var menuView : TRCommentMenuView!
    var collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
  
        configNav()
        configHeader()
        configMainView()
 
    }
    func configNav(){
        configNavBar()
        configNavTitle(title: "我的评价")
        configNavLeftBtn()
    }
    func configHeader(){
        menuView = TRCommentMenuView(frame: .zero)
        menuView.titles = ["顾客评价", "商家评价"]
        self.view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.height.equalTo(28)
        }
        
        menuView.block = {[weak self] (value) in
            self?.collectionView.scrollToItem(at: IndexPath(row: value, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    func configMainView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRCommentCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
      
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(menuView.snp.bottom)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Screen_Width, height: Screen_Height - Nav_Height - 44)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        let x = (scrollView.contentOffset.x / Screen_Width)
            
        menuView.currentSel = Int(x)
    }

}

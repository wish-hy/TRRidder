//
//  TRMinePunishViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit

class TRMinePunishViewController:  BasicViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        configNavTitle(title: "违规申诉")
        configNavLeftBtn()
    }
    func configHeader(){
        menuView = TRCommentMenuView(frame: .zero)
        menuView.titles = ["全部", "可申诉", "违规取消", "申诉通过", "申诉不通过","申诉超时"]
        menuView.width = 0
        self.view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(Nav_Height)
            make.height.equalTo(44)
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
        collectionView.register(TRMinePuishCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TRMinePuishCollectionViewCell
        if indexPath.row == 0 {
            cell.type = 0
        } else if indexPath.row == 1 {
            cell.type = 0

        } else if indexPath.row == 2 {
            cell.type = 1

        } else if indexPath.row == 3 {
            cell.type = 2

        } else if indexPath.row == 4 {
            cell.type = 3

        }else if indexPath.row == 5 {
            cell.type = 4

        }
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        let x = (scrollView.contentOffset.x / Screen_Width)
            
        menuView.currentSel = Int(x)
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

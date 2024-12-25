//
//  TRCommentHeader.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit
import RxSwift
import RxCocoa
class TRCommentMenuView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    var titles = ["a", "c", "b"] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var collectionView : UICollectionView!
    var currentSel : Int = 0{
        didSet{
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(item: currentSel, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    var block : Int_Block?
    var width = Screen_Width / 2 {
        didSet {
            collectionView.reloadData()
        }
    }
    private var bag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRCommentMenuCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSel = indexPath.row
        collectionView.reloadData()
        
        if self.block != nil {
            self.block!(indexPath.row)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if width <= 0 {
            let t = titles[indexPath.row]
            return CGSize(width: (t.count + 2 ) * 16, height: 28)
        }
        return CGSize(width: width, height: 28)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! TRCommentMenuCollectionViewCell
        cell.menuLab1.text = titles[indexPath.row]
        if indexPath.row == currentSel {
            cell.isSel = true
        } else {
            cell.isSel = false
        }
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

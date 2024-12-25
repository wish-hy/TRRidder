//
//  TRHomeMainView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/6.
//

import UIKit

class TRHomeMainView: UIView, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    var collectionView : UICollectionView!
    var indexChangeBlock : Int_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    @objc func orderDone(){
        collectionView.scrollToItem(at: .init(row: 0, section: 0), at: .top, animated: false)
        self.indexChangeBlock!(Int(0))
    }
    @objc func orderPickup(){
        collectionView.scrollToItem(at: .init(row: 2, section: 0), at: .top, animated: false)
        self.indexChangeBlock!(Int(2))
    }
    @objc func orderAccept(){
        collectionView.scrollToItem(at: .init(row: 1, section: 0), at: .top, animated: false)
        self.indexChangeBlock!(Int(1))
    }
    private func setupView(){
        NotificationCenter.default.addObserver(self, selector: #selector(orderDone), name: .init(Notification_Name_Order_Done), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(orderPickup), name: .init(Notification_Name_Order_Pickup), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(orderAccept), name: .init(Notification_Name_Order_Accept), object: nil)

        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRHomeMainCollectionViewCell1.self, forCellWithReuseIdentifier: "cellID1")
        collectionView.register(TRHomeMainCollectionViewCell2.self, forCellWithReuseIdentifier: "cellID2")
        collectionView.register(TRHomeMainCollectionViewCell3.self, forCellWithReuseIdentifier: "cellID3")

        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.right.bottom.equalTo(self)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID1", for: indexPath)
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID2", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID3", for: indexPath)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

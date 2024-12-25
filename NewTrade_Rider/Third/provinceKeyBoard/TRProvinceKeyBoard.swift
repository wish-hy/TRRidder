//
//  TRProvinceKeyBoard.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRProvinceKeyBoard: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let provinces = ["京","津","沪","渝","冀","晋","辽","吉","黑","苏",
                     "浙","皖","闽","赣","鲁","豫","鄂","湘","粤","琼",
                     "川","贵","云","陕","甘","青","桂","蒙","藏","宁",
                     "新"]
    let w = (Screen_Width - 16 - 6 * 7) / 10
    var collectionView : UICollectionView!
    var currnetIndex : Int = -1
    var block : String_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        let layout = UICollectionViewFlowLayout()
        //        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .hexColor(hexValue: 0xDDDFE6)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        //        collectionView.isPagingEnabled = true
        //        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRProvinceKeyBoardItem.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provinces.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: w, height: w + 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 8, bottom: IS_IphoneX ? 25 : 15, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currnetIndex = indexPath.row
        collectionView.reloadData()
        if self.block != nil {
            self.block!(provinces[indexPath.row])
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TRProvinceKeyBoardItem
        cell.itemLab.text = provinces[indexPath.row]
        if indexPath.row == currnetIndex {
            cell.itemLab.textColor = .themeColor()
        } else {
            cell.itemLab.textColor = .txtColor()
        }
       
        return cell
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

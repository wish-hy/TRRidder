//
//  TRLetterNumKeyBoard.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/22.
//

import UIKit

class TRLetterNumKeyBoard: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
/*
 @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
 @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
 @[@"省",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"delete"]
 */
    let one = ["1","2","3","4","5","6","7","8","9","0",
                "Q","W","E","R","T","Y","U","I","O","P",
                ]
    let two = ["A","S","D","F","G","H","J","K","L"]
    let thress = ["Z","X","C","V","B","N","M"]
    let w = (Screen_Width - 8 - 5 * 9) / 10
    var collectionView : UICollectionView!
    var currnetIndex : Int = -1
    var currnetSection : Int = -1
    var block : String_Block?
    
    var cancelBlock : Void_Block?
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
        collectionView.register(TRLetterNumCancelCell.self, forCellWithReuseIdentifier: "cancel")
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section ==  0 {
            return one.count
        } else if section == 1 {
            return two.count
        }
        return thress.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 2 && indexPath.row == thress.count {
            return .init(width: w + 8, height: w + 8)
        }
        return CGSize(width: w, height: w + 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return .init(top: 10, left: 20, bottom: 0, right: 20)
        } else if section == 2 {
            return .init(top: 10, left: 4 + w, bottom: IS_IphoneX ? 25 : 15, right: 4 + w)
        }
        return .init(top: 10, left: 4, bottom: 0, right: 4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .zero
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currnetIndex = indexPath.row
        self.currnetSection = indexPath.section
        
        if indexPath.section == 2 && indexPath.row == thress.count {
            if self.cancelBlock != nil {
                self.cancelBlock!()
            }
            return
        }
            
        if self.block != nil {
            if indexPath.section == 0 {
                self.block!(one[indexPath.row])
            } else if indexPath.section == 1{
                self.block!(two[indexPath.row])
            } else if indexPath.section == 2{
                self.block!(thress[indexPath.row])


            }
        }
        
        collectionView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 2 && indexPath.row == thress.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cancel", for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TRProvinceKeyBoardItem
        if indexPath.section == 0 {
            cell.itemLab.text = one[indexPath.row]
        } else if indexPath.section == 1{
            cell.itemLab.text = two[indexPath.row]

        }else if indexPath.section == 2{
            cell.itemLab.text = thress[indexPath.row]

        }
        if indexPath.row == currnetIndex && indexPath.section == currnetSection{
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

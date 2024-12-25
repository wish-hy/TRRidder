//
//  TRRidderApplyTypeCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/18.
//

import UIKit

class TRRidderApplyTypeCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var riderTypes : [TRRiderApplyTypeModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var itemLab : UILabel!
    var collectionView : UICollectionView!
    
    var  currentIndex : Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var block : Int_Block?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
//        bgView.layer.cornerRadius = 0
//        bgView.layer.masksToBounds = true
        contentView.addSubview(bgView)
        
        itemLab = TRFactory.labelWith(font: .trFont(16), text: "选择配送业务", textColor: .txtColor(), superView: bgView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRRidderApplyTypeItemCell.self, forCellWithReuseIdentifier: "cell")
        bgView.addSubview(collectionView)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView)
        }
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(12)
            make.top.equalTo(bgView).offset(15)
        }
        collectionView.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(12)
            make.top.equalTo(itemLab.snp.bottom).offset(15)
            make.height.equalTo(88)
            make.bottom.equalTo(bgView).inset(8)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == currentIndex {return}
        currentIndex = indexPath.row
        collectionView.reloadData()
        
        if block != nil {
            block!(currentIndex)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return riderTypes.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 168, height: 88)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TRRidderApplyTypeItemCell
        
        let model = riderTypes[indexPath.row]
        cell.model = model
        if indexPath.row == currentIndex {
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

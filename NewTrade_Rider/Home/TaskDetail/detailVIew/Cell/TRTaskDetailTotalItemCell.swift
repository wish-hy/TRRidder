//
//  TRTaskDetailTotalItemCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/1.
//

import UIKit

class TRTaskDetailTotalItemCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // orderItemList : [TRItemModel]
    var goodInfoUrls : [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var collectionView : UICollectionView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    
    private func setupView(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        let itemLab = TRFactory.labelWith(font: .trFont(16), text: "物品信息", textColor: .txtColor(), superView: bgView)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        //        collectionView.isPagingEnabled = true
        //        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRTaskDetailTotalItemCollectionCell.self, forCellWithReuseIdentifier: "cell")
        bgView.addSubview(collectionView)
        
        itemLab.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(16)
            make.top.equalTo(bgView).offset(16)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(itemLab)
            make.left.equalTo(itemLab.snp.right).offset(30)
            make.right.equalTo(bgView).inset(30)
            make.height.equalTo(48)
            make.bottom.equalTo(bgView).inset(15)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodInfoUrls.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TRTaskDetailTotalItemCollectionCell
        let urlStr = goodInfoUrls[indexPath.row]
        cell.itemImgV.sd_setImage(with: URL.init(string: urlStr), placeholderImage: Net_Default_Img)
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

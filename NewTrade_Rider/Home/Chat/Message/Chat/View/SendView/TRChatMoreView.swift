//
//  TRChatMoreView.swift
//  NewTrade_Mall
//
//  Created by xph on 2024/4/1.
//

import UIKit

enum ChatMoreAction : Int {
    case ablum = 0
    case camera = 1
}

class TRChartMoreCell : UICollectionViewCell {
    var bgView : UIView!
    var funcImgV : UIImageView!
    var funcLab : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        bgView.trCorner(12)
        contentView.addSubview(bgView)
        
        funcImgV = UIImageView()
        contentView.addSubview(funcImgV)
        
        funcLab = TRFactory.labelWith(font: .trFont(12), text: "哈偶", textColor: .txtColor(), superView: contentView)
        
        bgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 62 * TRWidthScale, height: 62 * TRWidthScale))
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(20)
        }
        funcImgV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.center.equalTo(bgView)
        }
        funcLab.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(bgView.snp.bottom).offset(6)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TRChatMoreView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var block : Int_Block?

    var funcs = ["相册","拍照"]
    var funcImgs = ["chat_func_image","chat_func_camera"]
    var collectionView : UICollectionView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        let layout = UICollectionViewFlowLayout()
        //        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .bgColor()
        //        collectionView.isPagingEnabled = true
        //        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRChartMoreCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if block != nil {
            block!(indexPath.row)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funcs.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Screen_Width / 4, height: 62 * TRWidthScale + 23 + 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TRChartMoreCell
        cell.funcLab.text = funcs[indexPath.row]
        cell.funcImgV.image = UIImage(named: funcImgs[indexPath.row])
        
        return cell
    }
}

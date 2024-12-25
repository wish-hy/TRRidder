//
//  TRRidderApplyTrafficTypeCell.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/18.
//

import UIKit

class TRRidderApplyTrafficTypeCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var itemLab : UILabel!
    var collectionView : UICollectionView!
    
    var models : [TRRiderVehicleTypeModel] = [] {
        didSet {
            
            collectionView.reloadData()
            let line = models.count / 5 + (models.count % 5 == 0 ? 0 : 1)
            collectionView.snp.remakeConstraints { make in
                make.left.right.equalTo(innerBgView).inset(0)
                make.top.equalTo(itemLab.snp.bottom).offset(0)
                make.bottom.equalTo(bgView).inset(10)
                make.height.equalTo(line * 75)
            }
        }
    }
    var serName : String = "" {
        didSet {
            itemLab.attributedText = TRTool.richText3(str1: "报名", font1: .trFont(14), color1: .txtColor(), str2: serName, font2: .trMediumFont(14), color2: .themeColor(), str3: "，您需要自备以下车辆类型之一", font3: .trFont(14), color3: .txtColor())

        }
    }
    private var innerBgView : UIView!
    private var bgView : UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .bgColor()
        setupView()
    }
    private func setupView(){
        bgView = UIView()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        innerBgView = UIView()
        innerBgView.backgroundColor = .hexColor(hexValue: 0xF4F5F7)
        contentView.addSubview(innerBgView)
        
        itemLab = UILabel()
        itemLab.attributedText = TRTool.richText3(str1: "报名", font1: .trFont(14), color1: .txtColor(), str2: "商城配送", font2: .trMediumFont(14), color2: .themeColor(), str3: "，您需要自备以下车辆类型之一", font3: .trFont(14), color3: .txtColor())
        itemLab.numberOfLines = 0
        innerBgView.addSubview(itemLab)
        
        let layout = UICollectionViewFlowLayout()
        //        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        //        collectionView.isPagingEnabled = true
        //        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRRidderApplyTrafficTypeItemCell.self, forCellWithReuseIdentifier: "cell")
        innerBgView.addSubview(collectionView)
        bgView.snp.makeConstraints { make in
            make.bottom.top.equalTo(contentView)
            make.left.right.equalTo(contentView).inset(16)
        }
        innerBgView.snp.makeConstraints { make in
            make.left.right.equalTo(bgView).inset(12)
            make.top.equalTo(bgView)
            make.bottom.equalTo(bgView)
        }
        itemLab.snp.makeConstraints { make in
            make.left.right.equalTo(innerBgView).inset(8)
            make.top.equalTo(innerBgView).offset(10)
        }
        collectionView.snp.makeConstraints { make in
            make.left.right.equalTo(innerBgView).inset(0)
            make.top.equalTo(itemLab.snp.bottom).offset(0)
            make.bottom.equalTo(bgView).inset(10)
            make.height.equalTo(180)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Screen_Width - 32 - 24) / 5, height: 68)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TRRidderApplyTrafficTypeItemCell
        let m = models[indexPath.row]
        cell.model = m
        return cell
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  TRChooseImageView.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/8.
//

import UIKit

class TRChooseImageView: UIView, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    //单行数量
    var picNum : Int = 4
    //最大数量
    var max : Int = IMG_UP_MAX

    var netLocImgModel : NetLocImageModel? {
        didSet {
            if netLocImgModel != nil {
                collectionView.reloadData()
                if heightChangedBlock != nil {
                    heightChangedBlock!()
                }
            }
        }
    }
    //首图提示
    var showType : Int = 1{
        didSet {
            collectionView.reloadData()
        }
    } // 0 不显示 1 显示数量 2 自定义文字
    var firstItemTip : String = ""
    var tipLab : UILabel!
    var collectionView : UICollectionView!
    var block : Void_Block?
    //高度变化
    var heightChangedBlock : Void_Block?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    func reloadViews(){
        collectionView.reloadData()
    }
    private func setupView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        //        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRChooseImgCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.bottom.top.equalTo(self)
            make.left.right.equalTo(self)
        }
        
        longPressGestureAction()
    }
//    private func addRecognize(){
//        let longGes = UILongPressGestureRecognizer()
//        longGes.addTarget(self, action: #selector(longPressGesture))
//        longGes.minimumPressDuration = 0.5
//        collectionView.addGestureRecognizer(longGes)
//    }
    @objc private func longPressGestureAction() {
        let longGes = UILongPressGestureRecognizer()
        longGes.addTarget(self, action: #selector(handlelongGesture))
        longGes.minimumPressDuration = 0.5
        collectionView.addGestureRecognizer(longGes)
    }

    @objc private func handlelongGesture(gesture : UILongPressGestureRecognizer){
        if netLocImgModel == nil {return}
        if netLocImgModel!.localImgArr.count <= 1 {return}
        switch gesture.state {
        case .possible:
            break
        case .began:
            let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView))
            if (indexPath != nil  || indexPath!.row != netLocImgModel!.localImgArr.count) {
                collectionView.beginInteractiveMovementForItem(at: indexPath!)
            }
        
        case .changed:
            let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView))
            if !(indexPath != nil && indexPath!.row == netLocImgModel!.localImgArr.count){
                collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            }
        case .ended:
            collectionView.endInteractiveMovement()
            collectionView.reloadData()
        case .cancelled:
            break
        case .failed:
            break
        @unknown default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let obj = netLocImgModel
        netLocImgModel!.exchangeItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        //修改数据源
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! TRChooseImgCollectionViewCell
        if indexPath.row == netLocImgModel!.localImgArr.count {
            cell.type = 1
            cell.numLab.isHidden = false
            cell.numLab.text = "\(netLocImgModel!.localImgArr.count)/\(max)"
        } else {
            cell.type = 0
            cell.numLab.isHidden = true
   
            guard let netLocImgModel = netLocImgModel else { return cell }
            let locImg = netLocImgModel.localImgArr[indexPath.row]
            let netUrl = netLocImgModel.netUrlArr[indexPath.row]
            if netUrl.isEmpty {
                cell.imgV.image = locImg
            } else {
                cell.imgV.sd_setImage(with: URL.init(string: netUrl), placeholderImage: Net_Default_Img, context: nil)
            }
            
            cell.deleteBtn.rx.tap.subscribe(onNext: {[weak self] in
                guard let self = self else { return }

                netLocImgModel.deleteImg(index: indexPath.row)
                if heightChangedBlock != nil {
                    heightChangedBlock!()
                }
                collectionView.reloadData()
            }).disposed(by: cell.bag)
        }
        if indexPath.row == 0 && netLocImgModel!.localImgArr.count > 0 {
            cell.infoLab.isHidden = false
            //var showType : Int = 1 // 0 不显示 1 显示数量 2 自定义文字
            if showType == 0 {
                cell.infoLab.isHidden = true
            } else if showType == 1 {
                cell.infoLab.text = "\(netLocImgModel!.localImgArr.count)/\(max)"
            } else if showType == 2 {
                cell.infoLab.text = firstItemTip
            }
        } else {
            cell.infoLab.isHidden = true
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! TRChooseImgCollectionViewCell
        if indexPath.row == netLocImgModel!.localImgArr.count {//添加图片
            if block != nil {
                block!()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if netLocImgModel == nil {return 1}
        if netLocImgModel!.localImgArr.count >= max {
            return max
        } else {
            return netLocImgModel!.localImgArr.count + 1
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space = (picNum - 1) * 10
        return CGSize(width: (Screen_Width - 32.0 - CGFloat(space)) / CGFloat(picNum), height: (Screen_Width - 32.0 - CGFloat(space)) / CGFloat(picNum))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

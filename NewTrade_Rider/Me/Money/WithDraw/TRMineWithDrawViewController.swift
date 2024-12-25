//
//  TRMineWithDrawViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/13.
//

import UIKit
import RxCocoa
import RxSwift
class TRMineWithDrawViewController: BasicViewController , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let withDrawNums = ["100","200","300","400","500","600"]
    let phoneBilNums = ["50","100","200","400","500"]
    var curIndexPaht : IndexPath = IndexPath(row: 0, section: 0)
    var collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configNav()
        
        configMainView()
    }
    private func configMainView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        //        collectionView.isPagingEnabled = true
        //        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TRMineWidthDrawCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(TRMineWidthDrawNumCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(TRMineWidthdrawHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(TRMineWidthdrawFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")

        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header0")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer0")
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(Nav_Height)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: Screen_Width, height: 120)
        }
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 || section == 2 {
            return CGSize(width: Screen_Width, height: 40)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return withDrawNums.count
        }
        
        return phoneBilNums.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: Screen_Width, height: 142)
        } else if indexPath.section == 1 {
            return CGSize(width: (Screen_Width - 32) / 3.0, height: 78)
        } else if indexPath.section == 2 {
            return CGSize(width: (Screen_Width - 32) / 3.0, height: 78)

        }
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 || section == 2 {
            return UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        }
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TRMineWidthDrawCell
 
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! TRMineWidthDrawNumCell
            cell.lab.text = withDrawNums[indexPath.row]
            if curIndexPaht.row == indexPath.row &&  curIndexPaht.section == indexPath.section{
                cell.isSel = true
            } else {
                cell.isSel = false
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! TRMineWidthDrawNumCell
        cell.lab.text = phoneBilNums[indexPath.row]

        if curIndexPaht.row == indexPath.row &&  curIndexPaht.section == indexPath.section{
            cell.isSel = true
        } else {
            cell.isSel = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        curIndexPaht = indexPath
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 1 || indexPath.section == 2 {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! TRMineWidthdrawHeader
                if indexPath.section == 1 {
                    view.titleLab.text = "提现金额"
                    view.desLab.isHidden = true
                } else {
                    view.desLab.isHidden = false
                    view.titleLab.text = "话费充值"

                }
                return view
            }
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header0", for: indexPath)
        } else {
            if indexPath.section == 2 {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
                return view
            }
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer0", for: indexPath)
        }
    }
    private func configNav(){
        self.navigationItem.title = "提现"
        configNavLeftBtn()
        
        let rightBtn = TRRightButton(frame: CGRect(x: 0, y: 0, width: 80, height: 35))
        rightBtn.lab.text = "提现规则"
        rightBtn.lab.font = UIFont.trFont(fontSize: 15)
        rightBtn.lab.textColor = UIColor.hexColor(hexValue: 0x141414)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
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

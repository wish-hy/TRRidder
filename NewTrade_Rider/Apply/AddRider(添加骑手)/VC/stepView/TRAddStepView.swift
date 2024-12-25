//
//  TRAddStepView.swift
//  NewTrader_Partner
//
//  Created by xph on 2023/11/20.
//

import UIKit

class TRAddStepView: UIView {
    
    var titles : [String] = [] {
        didSet {
            if titles.count > 0 {
                setupView()
            }
        }
    }
    

    
    private var items : [TRAddStepItemView] = []
    private var arrows : [UIImageView] = []
    var progress : Int = 0 {
        didSet {
            if progress >= items.count {return}
            for i in 0...items.count - 1 {
                let itemView = items[i]
                if i < progress {
                    itemView.state = 2
                } else if i == progress{
                    itemView.state = 1
                } else {
                    itemView.state = 0
                }
                if i != items.count - 1 {
                    let arrowImgV = arrows[i]
                    if i <= progress - 1 {
                        arrowImgV.image = UIImage(named: "progress_arrow_white")
                    } else {
                        arrowImgV.image = UIImage(named: "poregress_arrow_gray")
                    }
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func setupView(){
        items.removeAll()
        arrows.removeAll()
        for i in 0...titles.count - 1 {
            let t = titles[i]
            let itemView = TRAddStepItemView(frame: .zero)
            itemView.idLab.text = "\(i + 1)"
            itemView.itemLab.text = t
            self.addSubview(itemView)
            items.append(itemView)
            
            if i != titles.count - 1 {
                let imgV = UIImageView(image: UIImage(named: "progress_arrow_white"))
                self.addSubview(imgV)
                arrows.append(imgV)
                imgV.snp.makeConstraints { make in
                    make.centerY.equalTo(itemView.idContentView)
                    make.left.equalTo(itemView.snp.right)
                    make.height.width.equalTo(38)
                }
            }
        }
        
        items.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        items.snp.distributeViewsAlong(axisType: 0, fixedSpacing: 38, leadSpacing: 0, tailSpacing: 0)
    }
    func fixTitle(_ title : String?, index : Int = 0){
        if index < 0 || index >= items.count {return}
        let itemView = items[index]
        itemView.itemLab.text = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

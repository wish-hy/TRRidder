//
//  TRContactView.swift
//  NewTrade_Rider
//
//  Created by xzy on 2024/11/7.
//

import UIKit
import RxSwift

class TRContactView : UIView {
    var  imgv : UIImageView!
    var  lab  : UILabel!
    var  line : UIView!
    var  bgView : UIView!
    var  nameLab : UILabel!
    var  phoneImg : UIImageView!
    var  chatImg : UIImageView!
    var  phoneLab  : UILabel!
    var  addressLab  : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

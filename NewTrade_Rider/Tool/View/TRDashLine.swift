//
//  TRDashLine.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/6.
//

import UIKit

class TRDashLine: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func drawDashLine() {
        let  path = UIBezierPath()

        let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
        path.move(to: p0)

        let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
        path.addLine(to: p1)

        let  dashes: [ CGFloat ] = [ 16.0, 32.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineWidth = 8.0
        path.lineCapStyle = .butt
        UIColor.gray.set()
        path.stroke()
    }
    

}

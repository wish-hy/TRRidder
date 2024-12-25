//
//  TRLocAnnation.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/12.
//

import UIKit
import MapKit
class TRAnnation :NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
       var title: String?
       var subtitle: String?
       var extraTitle: String?
       init(coordinate:CLLocationCoordinate2D) {
        self.coordinate = coordinate
       }
}


class TRLocAnnationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let imgV = UIImageView(image: UIImage(named: "location_ann"))
        imgV.frame = CGRect(x: 0, y: 0, width: 24 * 1.5 * TRWidthScale, height: 32 * 1.5 * TRWidthScale)
        self.addSubview(imgV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

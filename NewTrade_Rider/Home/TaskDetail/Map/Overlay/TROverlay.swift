//
//  TROverlay.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/3/25.
//

import UIKit
import MapKit

class TROverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    var textureImage: UIImage
    
    init(coordinate: CLLocationCoordinate2D, boundingMapRect: MKMapRect, textureImage: UIImage) {
        self.coordinate = coordinate
        self.boundingMapRect = boundingMapRect
        self.textureImage = textureImage
    }
}

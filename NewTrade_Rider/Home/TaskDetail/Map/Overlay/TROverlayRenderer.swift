//
//  TROverlayRenderer.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/3/25.
//

import UIKit
import MapKit

class TROverlayRenderer: MKOverlayRenderer {
    var customOverlay: TROverlay
        
        init(overlay: MKOverlay, customOverlay: TROverlay) {
            self.customOverlay = customOverlay
            super.init(overlay: overlay)
        }
        
        override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
            guard let cgImage = customOverlay.textureImage.cgImage else { return }
            
            // 在地图上绘制自定义纹理图片
            // 请根据实际需求实现纹理绘制的逻辑
            // 这里仅提供一个简单示例
            // 可以使用 context.draw 函数来绘制纹理图片
            // 例如：context.draw(cgImage, in: rect)
        }
}

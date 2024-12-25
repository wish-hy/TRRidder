//
//  MAGltfOverlayRenderer.h
//  MAMapKit
//
//  Created by JZ on 2022/5/17.
//  Copyright © 2022 Amap. All rights reserved.
//

#import "MAConfig.h"
#if FEATURE_GLTF

#import "MAGltfOverlay.h"
#import "MAOverlayRenderer.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAGltfOverlayRenderer : MAOverlayRenderer

///关联的MAObjModelOverlay model
@property (nonatomic, readonly) MAGltfOverlay *glTFOverlay;

///是否固定显示大小，默认NO
@property (nonatomic, assign) BOOL fixedDisplaySize;

/**
 * @brief 根据指定MAObjModelOverlay生成对应的Renderer
 * @param objModelOverlay 指定的MAObjModelOverlay model
 * @return 生成的Renderer
 */
- (instancetype)initWithGlTFModelOverlay:(MAGltfOverlay *)glTFModelOverlay;
@end

NS_ASSUME_NONNULL_END
#endif

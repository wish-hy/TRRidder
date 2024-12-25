//
//  MAGltfOverlay.h
//  MAMapKit
//
//

#import "MAConfig.h"
#if FEATURE_GLTF

#import "MABaseOverlay.h"

NS_ASSUME_NONNULL_BEGIN

///该类用于定义一个glTF模型Overlay, 通常MAGltfOverlay是MAGltfOverlayRenderer的model，@since 9.5.0
@interface MAGltfOverlay : MABaseOverlay

///模型的中心点经纬度坐标，无效坐标按照{0，0}处理。
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

///模型的缩放倍数，默认1。
@property (nonatomic, assign) CGFloat scale;

///dragEnable 是否支持拖拽, 默认为YES
@property (nonatomic, assign) BOOL draggEnable;

///touchEnable 是否支持点击, 默认为YES
@property (nonatomic, assign) BOOL touchEnable;

///图标
@property (nonatomic, strong) UIImage *image;

///当前执行动画的索引，取值必须小于模型支持动画的个数。默认0，执行第一个动画
@property (nonatomic, assign) NSInteger currentAnimationIndex;

///最小显示级别 default 3
@property (nonatomic, assign) CGFloat minZoom;

///最大显示级别 default 20
@property (nonatomic, assign) CGFloat maxZoom;

///是否为glb格式 @since 9.7.0
@property (nonatomic, assign, getter=isGlbFormat) BOOL glbFormat;

/**
 * @brief 根据中心点、模型文件data以及纹理图生成MAGltfOverlay
 * @param coordinate  中心点的经纬度坐标，无效坐标按照{0，0}处理
 * @param glTFModelData obj类型的模型文件data（Overlay内部不会保存）
 * @param uriResources glTF对应uri资源，包括纹理图片，bin文件等
 * @return 新生成的MAGltfOverlay
 */
+ (instancetype)glTFModelOverlayWithCoordinate:(CLLocationCoordinate2D)coordinate glTFModelData:(NSData *)glTFModelData uriResources:(NSDictionary* _Nullable)uriResources;

///设置模型绕坐标轴的旋转角度，单位度。
- (void)setRotationDegreeX:(double)degreeX Y:(double)degreeY Z:(double)degreeZ;


@end

NS_ASSUME_NONNULL_END
#endif

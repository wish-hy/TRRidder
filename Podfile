# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'NewTrade_Rider' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NewTrade_Rider


#公共库
pod 'Alamofire'
pod 'SnapKit'
#pod 'SnapKitExtend'
pod 'MJRefresh'
pod 'RxSwift'
pod 'RxCocoa'
pod 'SDWebImage'
# pod 'SDCycleScrollView'
pod 'SwiftyJSON'
pod 'IQKeyboardManagerSwift'
pod 'NextGrowingTextView'
pod 'ZLPhotoBrowser'
pod 'SVProgressHUD'
# pod 'YYText'
pod 'JPush'

pod 'HandyJSON'
pod 'MZRSA_Swift', '~> 0.0.2'
 # Pods for NewTrade_Rider
pod 'Bugly'

pod 'SwiftProtobuf', '~> 1.0'
pod 'WechatOpenSDK-XCFramework'
#数据库
pod 'WCDB.swift'

 pod'AMapSearch'#地图SDK搜索功能
 pod'AMapLocation'#定位SDK
 pod 'AMapNavi'

end


post_install do |installer|
installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings["VALID_ARCHS"] = "arm64 arm64e x86_64 i386"
        else
          config.build_settings["VALID_ARCHS"] = "arm64 arm64e"
        end
    end
end
end

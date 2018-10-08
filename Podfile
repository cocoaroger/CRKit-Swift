#https://github.com/AliSoftware/SwiftGen 在电脑上安装这个工具，生成 Asset 的 image enum 的 Extension
#swiftgen images /Users/roger/Documents/iOSProjects/side_project/remeet/remeet/remeet/Assets.xcassets

pre_install do |installer|
    def installer.verify_no_static_framework_transitive_dependencies; end
end

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

def pods
    #swift
    pod 'Alamofire'
    pod 'ObjectMapper'
    pod 'SwiftyJSON'
    pod 'SnapKit'
    pod 'Kingfisher'
    pod 'IQKeyboardManagerSwift'

    #oc
    pod 'YYCategories'
    pod 'YYText'
    pod 'MBProgressHUD'
    pod 'MJRefresh'
    pod 'UIAlertController+Blocks'
end

target 'CRKit-Swift' do
    pods
end

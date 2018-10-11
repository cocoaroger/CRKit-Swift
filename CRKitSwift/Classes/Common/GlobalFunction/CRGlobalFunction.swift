//
//  GlobalFunction.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

/// 当前 Window
func cr_currentWindow() -> UIWindow {
    return UIApplication.shared.keyWindow!
}

/// 判断是否IphoneX
func cr_isIphoneXLater() -> Bool {
    return (UIScreen.main.bounds.size.height >= 812 || UIScreen.main.bounds.size.width >= 812)
}

/// 根据字符串类名获取class
func cr_classFromString(_ className: String) -> AnyClass? {
    let projectName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    let classStringName = projectName + "." + className
    return NSClassFromString(classStringName)
}

// MARK: LOG
/// 普通日志输出
func CRLog(_ message: String) {
    #if DEBUG
    print("\(message)")
    #endif
}

/// 详细日志输出
/**
 * parameter message:  日志消息
 * parameter file:     文件名
 * parameter function:   方法名
 * parameter line:     代码行数
 */
func CRLogDescription(message: String,
                      function: String = #function,
                      file: String = #file,
                      line: Int = #line) {
    #if DEBUG
    print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
    #endif
}

/// 是否具有相机权限
func cr_hasCameraAuthorization() -> Bool {
    let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    if status == AVAuthorizationStatus.restricted || status == AVAuthorizationStatus.denied {
        return false
    } else {
        return true
    }
}

/// 是否具有相册权限
func cr_hasPhotoAuthorization() -> Bool {
    let status = PHPhotoLibrary.authorizationStatus()
    if status == PHAuthorizationStatus.restricted || status == PHAuthorizationStatus.denied {
        return false
    } else {
        return true
    }
}

/// 是否具有推送权限
func cr_hasNotificationAuthorization() -> Bool {
    let notificationSetting = UIApplication.shared.currentUserNotificationSettings;
    if notificationSetting?.types == UIUserNotificationType.alert ||
        notificationSetting?.types == UIUserNotificationType.badge ||
        notificationSetting?.types == UIUserNotificationType.sound
    {
        return true
    } else {
        return false
    }
}

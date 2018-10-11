//
//  UIAlertController+Extension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit
import YYCategories
import UIAlertController_Blocks

private let appBundleName = UIApplication.shared.appBundleName!

extension UIAlertController {
    /// 简单的提示性弹窗
    /// - parameter buttonTitle: 按钮文字
    /// - parameter title: 提示标题
    /// - parameter message: 提示消息
    public static func show(buttonTitle: String, title: String?, message: String?) {
        UIAlertController.showAlert(in: UIViewController.cr_currentVC(),
                                    withTitle: title,
                                    message: message,
                                    cancelButtonTitle: buttonTitle,
                                    destructiveButtonTitle: nil,
                                    otherButtonTitles: nil,
                                    tap: nil)
    }
    
    /// 显示去设置消息
    public static func show(messge: String) {
        UIAlertController.showAlert(in: UIViewController.cr_currentVC(),
                                    withTitle: "提示",
                                    message: messge,
                                    cancelButtonTitle: "取消",
                                    destructiveButtonTitle: nil,
                                    otherButtonTitles: ["去设置"]) { (alertController, action, buttonIndex) in
                                        if alertController.firstOtherButtonIndex ==  buttonIndex  {
                                            let locationURL = URL(string: UIApplication.openSettingsURLString)!
                                            if #available(iOS 10.0, *) {
                                                UIApplication.shared.open(locationURL, options: [:], completionHandler: nil)
                                            } else {
                                                UIApplication.shared.openURL(locationURL)
                                            }
                                        }
        }
    }
    
    /// 显示定位失败提示
    public static func showLocationFailed() {
        let message = "定位失败，请到『设置』-『\(appBundleName)』-『位置』开启定位功能，开启后您才可以使用定位功能"
        return UIAlertController.show(messge: message)
    }
    /// 显示相册权限失败提示
    public static func showPhotoFailed() {
        let message = "访问相册失败，请到『设置』-『\(appBundleName)』-『照片』开启照片功能，开启后您才可以使用照片功能"
        return UIAlertController.show(messge: message)
    }
    /// 显示相机权限失败提示
    public static func showCameraFailed() {
        let message = "访问相机失败，请到『设置』-『\(appBundleName)』-『相机』开启相机功能，开启后您才可以使用相机功能"
        return UIAlertController.show(messge: message)
    }
    /// 显示相机权限失败提示
    public static func showMicFailed() {
        let message = "访问麦克风失败，请到『设置』-『\(appBundleName)』-『麦克风』开启麦克风功能，开启后您才可以使用麦克风功能"
        return UIAlertController.show(messge: message)
    }
}

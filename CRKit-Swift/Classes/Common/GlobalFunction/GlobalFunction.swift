//
//  GlobalFunction.swift
//  CRKit-Swift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

/// 当前appDelegate
func currentAppDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

/// 当前 Window
func currentWindow() -> UIWindow {
    return UIApplication.shared.keyWindow!
}

/// 判断是否IphoneX
func isIphoneXLater() -> Bool {
    return (UIScreen.main.bounds.size.height >= 812 || UIScreen.main.bounds.size.width >= 812)
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


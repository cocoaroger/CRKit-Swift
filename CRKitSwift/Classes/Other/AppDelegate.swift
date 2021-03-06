//
//  AppDelegate.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupVender(launchOptions)
        
        window = UIWindow()
        window?.rootViewController = CRTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate {
    func setupVender(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        setupKeyboardManager()
    }
    
    /// 设置键盘
    func setupKeyboardManager() {
        let mananger = IQKeyboardManager.shared
        mananger.enable = true
        mananger.enableAutoToolbar = true
        mananger.keyboardDistanceFromTextField = 50
        mananger.shouldResignOnTouchOutside = true
    }
}


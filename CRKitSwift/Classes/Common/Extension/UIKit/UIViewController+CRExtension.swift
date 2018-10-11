//
//  UIViewController+Extension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// 获取当前的 ViewController
    public static func cr_currentVC() -> UIViewController {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        return UIViewController.findBest(rootVC!)
    }
    
    /// 递归查询当前最上面的视图
    public static func findBest(_ vc: UIViewController) -> UIViewController {
        if let presentedVC = vc.presentedViewController {
            return UIViewController.findBest(presentedVC)
        } else if vc is UISplitViewController {
            let svc = vc as! UISplitViewController
            if let lastVC = svc.viewControllers.last {
                return UIViewController.findBest(lastVC)
            } else {
                return vc
            }
        } else if vc is UINavigationController {
            let nvc = vc as! UINavigationController
            if let topVC = nvc.topViewController {
                return UIViewController.findBest(topVC)
            } else {
                return vc
            }
        } else if vc is UITabBarController {
            let tvc = vc as! UITabBarController
            if let selectedVC = tvc.selectedViewController {
                return UIViewController.findBest(selectedVC)
            } else {
                return vc
            }
        } else {
            return vc
        }
    }
}

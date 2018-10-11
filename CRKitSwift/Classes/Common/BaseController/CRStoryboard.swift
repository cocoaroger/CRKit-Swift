//
//  CRStoryboard.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

/// 使用方法
/// let loginVC: LoginController = Storyboard.login.instantiate("Login", LoginController.self)
struct CRStoryboard {
    
    /// 根据 Controller 类型获得实例
    ///
    /// - Parameters:
    ///   - storyboardName: storyboardName
    ///   - type: viewController类型
    ///   - bundle: bundle 名, 默认为 main
    /// - Returns: Controller 实例
    public func instantiate<VC: UIViewController>(_ storyboardName: String, _ type: VC.Type, bundle: Bundle = Bundle.main) -> VC {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: VC.cr_identifier)
        guard let vc = viewController as? VC else {
            fatalError("Couldn't instantiate \(VC.cr_identifier) from \(storyboardName)")
        }
        return vc
    }
}


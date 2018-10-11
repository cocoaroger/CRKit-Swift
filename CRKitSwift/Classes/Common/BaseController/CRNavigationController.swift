//
//  BaseNavigationController.swift
//  CRKitSwift
//
//  Created by roger wu on 2016/12/4.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

class CRNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    public var statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    private static let setupAppearance: Void = {
        let backImage = UIImage(named: "CRImage.bundle/cr_back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationBar.barTintColor = nil
        
        let item = UIBarButtonItem.appearance()
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 0.1),
                          NSAttributedString.Key.foregroundColor: UIColor.black]
        item.setTitleTextAttributes(attributes, for: UIControl.State.normal)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CRNavigationController.setupAppearance
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.interactivePopGestureRecognizer?.isEnabled = false
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    deinit {
        CRLog("---------\(self.classForCoder) 页面释放-----------")
    }
}

//
//  BaseController.swift
//  CRKitSwift
//
//  Created by roger wu on 2016/12/3.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

class CRBaseController: UIViewController {
    
    // MARK: 公有属性，用于设置样式
    /// 状态栏颜色
    var statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.default {
        didSet {
            self.updateStatusBarStyle(statusBarStyle)
        }
    }
    /// 自定义导航栏
    let navigationBar: CRNavigationBar = {
        let navigationBar = CRNavigationBar()
        return navigationBar
    }()
    /// 设置标题
    var navTitle: String? {
        didSet {
            self.navigationBar.title = navTitle
        }
    }
    /// 设置返回手势是否可用
    var isEnabledPopGesture: Bool = true {
        didSet {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = isEnabledPopGesture
        }
    }
    
    // MARK: 私有方法
    /// 刷新状态栏样式
    private func updateStatusBarStyle(_ statusBarStyle: UIStatusBarStyle) {
        if let navigationVC = self.navigationController as? CRNavigationController {
            if  navigationVC.viewControllers.count > 0 {
                navigationVC.statusBarStyle = statusBarStyle
            }
        } else {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: Controller生命周期
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = UIColor.cr_background
        self.statusBarStyle = UIStatusBarStyle.default
        self.view.addSubview(self.navigationBar)
        self.navigationBar.leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationBar.rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        self.navigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(CRHeight.navigationHeight)
        }
        
        /// 添加监听
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
        
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            self.isEnabledPopGesture = true
            self.navigationBar.leftButton.isHidden = false
        } else {
            self.isEnabledPopGesture = false
            self.navigationBar.leftButton.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateStatusBarStyle(statusBarStyle)
        self.view.bringSubviewToFront(self.navigationBar)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = self.isEnabledPopGesture
    }
    
    deinit {
        CRLog("--------\(self.classForCoder) 页面释放-------")
    }
    
    override func didReceiveMemoryWarning() {
        CRLog("--------\(self.classForCoder) 页面收到内存警告-------")
    }
    
    // MARK: 留给子类实现的方法，可选
    /// 左按钮事件
    @objc func leftButtonAction() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    /// 右按钮事件
    @objc func rightButtonAction() {}
    
    /// 接收系统通知事件
    @objc func applicationWillEnterForeground() {}
    @objc func applicationDidEnterBackground() {}
    @objc func applicationDidBecomeActive() {}
    @objc func applicationWillResignActive() {}
    
}


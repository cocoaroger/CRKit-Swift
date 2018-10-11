//
//  CRTabBarController.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

class CRTabBarController: UITabBarController, CRTabBarDelegate{
    
    private var _tabbarData: Array<CRTabBarItemModel> = {
        let filePath = Bundle.main.path(forResource: "CRTabBarItems", ofType: "plist")!
        let array: NSArray = NSArray(contentsOfFile: filePath)!
        var tabbarData: Array<CRTabBarItemModel> = Array<CRTabBarItemModel>()
        for dict in array {
            let model = CRTabBarItemModel(dict: (dict as! Dictionary<String, String>))
            tabbarData.append(model)
        }
        return tabbarData
    }()
    
    private let _customTabBar: CRTabBar = {
        let customTabBar = CRTabBar()
        customTabBar.backgroundColor = UIColor.white
        return customTabBar
    }()
    
    private let _bottomView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        self.setupChildControllers()
        _customTabBar.setSelectedIndex(index: 0) // 设置默认选中第几个
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for v in self.tabBar.subviews {
            if v.isKind(of: UIControl.classForCoder()) {
                v.isHidden = true
            }
        }
    }
    
    func setupTabBar() {
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        _customTabBar.frame = CGRect(x: 0, y: 0, width: UIScreen.cr_width, height: CRHeight.tabbarHeight)
        _customTabBar.delegate = self
        self.tabBar.addSubview(_customTabBar)
        
        self.tabBar.addSubview(_bottomView)
        _bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.tabBar)
            make.top.equalTo(_customTabBar.snp.bottom)
        }
    }
    
    func setupChildControllers() {
        for (tag, model) in _tabbarData.enumerated() {
            let controllerClass: AnyClass? = cr_classFromString(model.tabBarController!)
            let controller = (controllerClass as! CRBaseController.Type).init()
            controller.navTitle = model.navBarTitle
            let nav = CRNavigationController(rootViewController: controller)
            self.addChild(nav)
            _customTabBar.addTabBarItem(controller.tabBarItem, model, tag)
        }
    }
    
    // MARK: - TabBarDelegate
    func clickedItem(tabBar: CRTabBar, fromIndex: Int, toIndex: Int) {
        self.selectedIndex = toIndex
    }
    
    deinit {
        CRLog("---\(self.classForCoder) 页面释放---")
    }
}

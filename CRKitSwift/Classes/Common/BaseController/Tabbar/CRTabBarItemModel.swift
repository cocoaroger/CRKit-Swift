//
//  CRTabBarItemModel.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation

class CRTabBarItemModel: NSObject {
    /// 导航栏标题
    var navBarTitle: String?
    /// tabbar标题
    var tabBarTitle: String?
    /// 普通图片
    var normalImageName: String?
    /// 选中图片
    var selectedImageName: String?
    /// Controller
    var tabBarController: String?
    
    init(dict: Dictionary<String, String>) {
        super.init()
        navBarTitle = dict["navBarTitle"]
        tabBarTitle = dict["tabBarTitle"]
        let imageName = dict["tabBarImageName"] ?? ""
        normalImageName = imageName.appending("_normal")
        selectedImageName = imageName.appending("_selected")
        tabBarController = dict["tabBarController"]
    }
}

//
//  CRTabBar.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

protocol CRTabBarDelegate: class {
    func clickedItem(tabBar: CRTabBar, fromIndex: Int, toIndex: Int)
}

class CRTabBar: UIView {
    weak var delegate: CRTabBarDelegate?
    private var selectedButton: CRTabBarItem?
    
    /// 设置选中第几个
    public func setSelectedIndex(index: Int) {
        if index <= self.subviews.count-1 {
            let item = self.subviews[index] as! CRTabBarItem
            self.clicked(button: item)
        }
    }
    
    /// 添加普通的TabBarItem
    func addTabBarItem(_ tabBarItem: UITabBarItem, _ model: CRTabBarItemModel, _ tag: Int) {
        let buttonItem = CRTabBarItem()
        buttonItem.setTitle(model.tabBarTitle, for: .normal)
        buttonItem.setImage(UIImage(named: model.normalImageName ?? ""), for: .normal)
        buttonItem.setImage(UIImage(named: model.selectedImageName ?? ""), for: .selected)
        buttonItem.addTarget(self, action: #selector(clicked(button:)), for: .touchDown)
        buttonItem.addTarget(self, action: #selector(eventAll(button:)), for: .allTouchEvents)
        buttonItem.tabBarItem = tabBarItem
        buttonItem.tag = tag
        self.addSubview(buttonItem)
    }
    /// 添加按钮类型的ButtonItem
    func addButtonItem(_ tabBarItem: UITabBarItem,
                       _ model: CRTabBarItemModel,
                       clickedBlock: @escaping () -> Void) {
        let buttonItem = CRTabBarItem()
        buttonItem.setTitle(model.tabBarTitle, for: .normal)
        buttonItem.setImage(UIImage(named: model.normalImageName ?? ""), for: .normal)
        buttonItem.setImage(UIImage(named: model.selectedImageName ?? ""), for: .selected)
        buttonItem.addTarget(self, action: #selector(eventAll(button:)), for: .allTouchEvents)
        buttonItem.tabBarItem = tabBarItem
        buttonItem.addBlock(for: .touchDown) { (item) in
            clickedBlock()
        }
        self.addSubview(buttonItem)
    }
    
    @objc func clicked(button: CRTabBarItem) {
        let from = self.selectedButton?.tag ?? 0
        let to = button.tag
        self.delegate?.clickedItem(tabBar: self, fromIndex: from, toIndex: to)
        
        self.selectedButton?.isSelected = false;
        button.isSelected = true;
        self.selectedButton = button;
    }
    
    @objc func eventAll(button: CRTabBarItem) {
        button.isHighlighted = false;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let count: CGFloat = CGFloat(self.subviews.count)
        let buttonW = self.frame.size.width/count
        let buttonH = self.frame.size.height
        
        for (index, item) in self.subviews.enumerated() {
            item.tag = index
            let itemX = CGFloat(index) * buttonW
            item.frame = CGRect(x: itemX, y: 0, width: buttonW, height: buttonH)
        }
    }
}

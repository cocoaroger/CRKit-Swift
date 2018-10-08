//
//  Reusable.swift
//  CRM
//
//  Created by roger wu on 2017/3/24.
//  Copyright © 2017年 soubu. All rights reserved.
//

import Foundation
import UIKit

/// 可复用
protocol Reusable: class {
  /// 复用的id
  static var identifier: String { get }
}

// MARK: - 设置 UIView 的默认可复用实现
extension Reusable where Self: UIView {
  static var identifier: String {
    return NSStringFromClass(self)
  }
}

extension Reusable where Self: UIViewController {
  static var identifier: String {
    let className = NSStringFromClass(self) as NSString
    return className.components(separatedBy: ".").last!
  }
}

// MARK: - 让 UICollectionViewCell、UITableViewCell 具有可以复用
extension UICollectionViewCell: Reusable {}
extension UITableViewCell: Reusable {}

// MARK: - 这个前提是 Storyboard 中设置的 Storyboard ID 与类名相同, 否则会 crash
extension UIViewController: Reusable {}

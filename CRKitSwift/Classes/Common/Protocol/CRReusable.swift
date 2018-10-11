//
//  CRReusable.swift
//  CRKitSwift
//
//  Created by roger wu on 2017/3/24.
//  Copyright © 2017年 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

/// 可复用协议
protocol CRReusable: class {
  /// 复用的identifier
  static var cr_identifier: String { get }
}

// MARK: - 设置 UIView 的默认可复用实现
extension CRReusable where Self: UIView {
  static var cr_identifier: String {
    return NSStringFromClass(self)
  }
}

extension CRReusable where Self: UIViewController {
  static var cr_identifier: String {
    let className = NSStringFromClass(self) as NSString
    return className.components(separatedBy: ".").last!
  }
}

// MARK: - 让 UICollectionViewCell、UITableViewCell 具有可以复用
extension UICollectionViewCell: CRReusable {}
extension UITableViewCell: CRReusable {}

// MARK: - 这个前提是 Storyboard 中设置的 Storyboard ID 与类名相同, 否则会 crash
extension UIViewController: CRReusable {}

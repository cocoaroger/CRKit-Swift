//
//  UIColor+Extension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// rgb颜色设置
    public static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    /// 带透明度的rgb颜色设置
    public static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// 随机颜色
    private enum RandomColors: Int {
        case color1 = 0
        case color2 = 1
        case color3 = 2
        case color4 = 3
        case color5 = 4
        
        func getColor() -> UIColor {
            switch self {
            case .color1:
                return UIColor.rgb(228, 29, 121)
            case .color2:
                return UIColor.rgb(146, 107, 159)
            case .color3:
                return UIColor.rgb(132, 199, 41)
            case .color4:
                return UIColor.rgb(62, 167, 173)
            case .color5:
                return UIColor.rgb(78, 132, 229)
            }
        }
    }
    
    /// 根据姓名获取随机颜色
    ///
    /// - Parameter name: 姓名
    /// - Returns: 颜色
    public static func cr_randomColor(name: String) -> UIColor {
        let firstChar = name.first
        var value: Int = 0
        if let hashValue = firstChar?.hashValue {
            value = hashValue % 4
        }
        if let color = RandomColors(rawValue: value)?.getColor() {
            return color
        }
        return RandomColors.color1.getColor()
    }
}

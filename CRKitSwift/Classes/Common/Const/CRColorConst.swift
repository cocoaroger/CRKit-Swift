//
//  CRColorConst.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    /// 黑色
    public static let cr_black = rgba(51,51,51,1)
    /// 深灰色
    public static let cr_darkGray = rgb(98, 98, 98)
    /// 浅灰色
    public static let cr_lightGray = rgb(153, 153, 153)
    
    /// 图片背景色
    public static let cr_imageBackground = rgb(230, 230, 230)
    /// 背景色
    public static let cr_background = rgba(251,251,251,1)
    /// cell高亮的灰色
    public static let cr_cellHilight = UIColor.gray.withAlphaComponent(0.3)
    /// 分隔线颜色
    public static let cr_seperator = rgb(225,225,225)
    /// textField placeholder
    public static let cr_textPlaceholder = rgba(229,229,229,1)
    /// textField content
    public static let cr_textContent = rgb(153, 153, 153)
}

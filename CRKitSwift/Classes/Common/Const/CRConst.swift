//
//  CRConst.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

/// 常用行高
struct CRHeight {
    static let navigationHeight: CGFloat = cr_isIphoneXLater() ? 88 : 64
    static let tabbarHeight: CGFloat = 49
    static let height44: CGFloat = 44
    static let separator = 1 / UIScreen.main.scale
}

/// 动画时长
struct CRAnimationDuration {
    /// 0.25秒的动画时长
    static let duration25: CGFloat = 0.25
    /// 自定义像系统cell的点下动画时长
    static let touchDownDuration: CGFloat = 0.1
    /// 自定义像系统cell的释放动画时长
    static let touchUpDuration: CGFloat = 0.5
}

/// 屏幕宽、高度
extension UIScreen {
    /// 5、5s的宽度
    static let cr_width320: CGFloat = 320
    /// 6、6s的宽度
    static let cr_width375: CGFloat = 375
    /// 6p、6ps的宽度
    static let cr_width414: CGFloat = 414
    /// 屏幕宽度
    static let cr_width: CGFloat = UIScreen.main.bounds.size.width
    /// 屏幕高度
    static let cr_height: CGFloat = UIScreen.main.bounds.size.height
}

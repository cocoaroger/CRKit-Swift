//
//  UILabel+Extension.swift
//  CRKitSwift
//
//  Created by roger wu on 2016/10/18.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

import UIKit

extension UILabel {
    /// 复制label的样式
    func cr_copyStyle(_ label: UILabel) {
        self.font = label.font
        self.textColor = label.textColor
        self.textAlignment = label.textAlignment
        self.numberOfLines = label.numberOfLines
    }
    
    /// 新建label
    public static func cr_label(_ font: UIFont, _ textColor: UIColor) -> UILabel {
        let l = UILabel()
        l.font = font
        l.textColor = textColor
        return l
    }
}

//
//  UITextField+CRExtension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    /// 设置自定义的placeholder
    func cr_placeholder(_ placeholder: String) {
        var attrs: Dictionary<NSAttributedString.Key, Any> = Dictionary<NSAttributedString.Key, Any>()
        attrs[NSAttributedString.Key.font] = self.font
        attrs[NSAttributedString.Key.foregroundColor] = UIColor.cr_textPlaceholder
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attrs)
    }
}


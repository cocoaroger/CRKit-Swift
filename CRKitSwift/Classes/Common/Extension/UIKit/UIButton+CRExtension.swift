//
//  UIButton+Extension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

private let highlightedAlpha: CGFloat = 0.6

extension UIButton {
    
    /// 设置按钮title的普通状态颜色，同时将hilight和disabled设置为该颜色的半透明颜色
    func cr_setTitleColor(color: UIColor?) {
        self.setTitleColor(color, for: .normal)
        
        guard let color = color else {
            return
        }
        let highlightedColor = color.withAlphaComponent(highlightedAlpha)
        self.setTitleColor(highlightedColor, for: .highlighted)
        self.setTitleColor(highlightedColor, for: .disabled)
    }
    
    /// 设置普通状态的图片，自动生成其他状态的透明图片
    func cr_setImage(image: UIImage) {
        let highlightedImage = image.cr_alphaImage(alpha: highlightedAlpha)
        self.setImage(image, for: .normal)
        self.setImage(highlightedImage, for: .highlighted)
        self.setImage(highlightedImage, for: .disabled)
    }
    
    /// 设置普通状态的背景图片，自动生成其他状态的透明图片
    func cr_setBackgroundImage(image: UIImage?) {
        var highlightedImage: UIImage? = nil
        if let image = image {
            highlightedImage = image.cr_alphaImage(alpha: highlightedAlpha)
        }
        
        self.setBackgroundImage(image, for: .normal)
        self.setBackgroundImage(highlightedImage, for: .highlighted)
        self.setBackgroundImage(highlightedImage, for: .disabled)
    }
}



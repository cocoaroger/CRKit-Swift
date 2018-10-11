//
//  UIImage+Extenstion.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    /// 创建带透明度的图片
    func cr_alphaImage(alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        let ctx = UIGraphicsGetCurrentContext()!
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        ctx.scaleBy(x: 1, y: -1);
        ctx.translateBy(x: 0, y: -area.size.height);
        ctx.setBlendMode(.multiply)
        ctx.setAlpha(alpha)
        ctx.draw(self.cgImage!, in: area)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage
    }
    
    /// 按一定质量压缩
    func cr_data(_ compressionQuality: CGFloat) -> Data? {
        return self.jpegData(compressionQuality: compressionQuality)
    }
    
    /// 切割图片，根据宽度等比缩放
    func cr_resize(width: CGFloat) -> UIImage? {
        if width <= 0 {
            return nil
        }
        
        let newImageHeight = width / self.size.width * self.size.height
        // 宽度高度强转为整型，是为了解决切割后的底部白边
        let newSize = CGSize(width: Int(width), height: Int(newImageHeight))
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// 头像图片压缩
    func cr_compressHeaderData() -> Data? {
        var compressWidth: CGFloat = 300
        let compressionQuality: CGFloat = 1
        
        let oldWidth = self.size.width
        if oldWidth < compressWidth {
            compressWidth = oldWidth
        }
        
        let newImage = cr_resize(width: compressWidth)
        return newImage?.cr_data(compressionQuality)
    }
}

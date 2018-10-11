//
//  UIImageView+Extension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import SnapKit
import Kingfisher

extension UIImageView {
    // MARK: - 公有方法
    
    /// 创建水平线
    public static func cr_horizontalLine() -> UIImageView {
        return UIImageView(image: UIImage(color: UIColor.cr_seperator))
    }
    
    /// 创建白色水平线
    public static func cr_whiteHorizontalLine() -> UIImageView {
        return UIImageView(image: UIImage(color: UIColor.white))
    }
    
    /// 创建黑色水平线
    public static func cr_blackHorizontalLine() -> UIImageView {
        return UIImageView(image: UIImage(color: UIColor.cr_black))
    }
    
    // MARK: 实例方法
    /// 设置网络图片
    func cr_setImage(urlString: String?, placeholder: UIImage?, radius: CGFloat?) {
        let transition = ImageTransition.fade(1)
        var options: KingfisherOptionsInfo = [.transition(transition)]
        if let r = radius {
            let corner = RoundCornerImageProcessor(cornerRadius: r)
            options.append(.processor(corner))
        }
        
        if let urlString = urlString {
            let realURL = URL(string: urlString)
            self.kf.setImage(with: realURL,
                             placeholder: placeholder,
                             options: options,
                             progressBlock: nil,
                             completionHandler: nil)
        } else {
            self.kf.setImage(with: nil,
                             placeholder: placeholder,
                             options: options,
                             progressBlock: nil,
                             completionHandler: nil)
        }
    }
    
    func cr_setImage(urlString: String?) {
        cr_setImage(urlString: urlString, placeholder: nil, radius: nil)
    }
    
    func cr_setImage(urlString: String?, radius: CGFloat) {
        cr_setImage(urlString: urlString, placeholder: nil, radius: radius)
    }
    
    func cr_setImage(urlString: String?, placeholder: UIImage) {
        cr_setImage(urlString: urlString, placeholder: placeholder, radius: nil)
    }
    
}

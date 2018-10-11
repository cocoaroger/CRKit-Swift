//
//  CRImageConst.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

/// swiftgen images /Users/roger/Documents/iOS-project/side-project/remeet/remeet/remeet/Assets.xcassets
/// 资源图片枚举

extension UIImage {
    enum Asset: String {
        case Wall_female = "wall_female"
        
        var image: UIImage {
            return UIImage(asset: self)
        }
    }
    
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}


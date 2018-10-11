//
//  DispatchQueue+Extension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation

extension DispatchQueue {
    public static var cr_userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    public static var cr_userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    public static var cr_utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    public static var cr_background: DispatchQueue { return DispatchQueue.global(qos: .background) }
    
    /// 延时执行代码
    func cr_after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}

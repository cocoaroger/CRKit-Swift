//
//  UserDefaults+CRExtension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation

extension UserDefaults {
    public static func cr_string(_ key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    public static func cr_set(_ string: String?, for key: String) {
        UserDefaults.standard.set(string, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /// 保存对象
    public static func cr_set(object: Any, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
        defaults.synchronize()
    }
    
    /// 获取对象
    public static func cr_getObject(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    /// 删除对象
    public static func cr_deleteObject(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}

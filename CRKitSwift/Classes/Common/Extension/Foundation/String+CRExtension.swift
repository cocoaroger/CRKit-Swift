//
//  String+Extension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit
import UIAlertController_Blocks

extension String {
    /// 删除字符串前后空字符
    var cr_trim: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    /// 获取国际化的文本
    public static func cr_localized(key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
    
    /// 系统语言环境
    public static var cr_preferedLanguage: String {
        return NSLocale.preferredLanguages.first!
    }
    
    /// 打电话, 电话就是自己，兼容iPad
    /// param view 点击的视图，用于适配iPad
    func cr_callPhone(view: UIView) {
        let phoneString = "tel://\(self)"
        let phoneURL = URL(string: phoneString)!
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            let webView = UIWebView()
            webView.loadRequest(URLRequest(url: phoneURL))
            UIViewController.cr_currentVC().view.addSubview(webView)
        }
    }
    
    /// 字符串截取
    func cr_subString(to index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    func cr_subString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
}

/// 网页编码
extension String {
    var cr_urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

/// 验证
extension String {
    private func cr_matchWithRegex(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// 判断邮箱
    var cr_isEmailAddress: Bool {
        return cr_matchWithRegex(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    /// 判断字母
    var cr_isLetter: Bool {
        return cr_matchWithRegex(regex: "^[a-zA-Z]*$")
    }
    
    /// 判断数字
    var cr_isNumber: Bool {
        return cr_matchWithRegex(regex: "^[0-9]*$")
    }
    
    /// 判断密码
    var isPassword: Bool {
        let regex = "^[a-zA-Z0-9]{6,12}$" // 匹配字母或数字，没有特殊字符
        guard cr_matchWithRegex(regex: regex) else { // 含有特殊字符,或位数不对
            return false
        }
        //    if self.isNumber { return false }
        //    if self.isLetter { return false }
        return true
    }
    
    /// 判断微信号
    var cr_isWeixin: Bool {
        return cr_matchWithRegex(regex: "^[a-zA-Z0-9_]+$")
    }
    
    /// 判断用户名
    var cr_isAccountNo: Bool {
        if self.count > 10 {
            return false
        }
        return true
        
        //    if self.contains(" ") {
        //      return false
        //    }
        //    let regex = "^[a-zA-Z0-9_\\u4e00-\\u9fa5]+$"
        //    return self.matchWithRegex(regex: regex)
    }
    
    /// 判断手机号
    var cr_isPhone: Bool {
        if self.count != 11 {
            return false
        }
        if !cr_isNumber {
            return false
        }
        if !self.hasPrefix("1") {
            return false
        }
        return true
    }
    
    /// 判断支付宝帐号
    var cr_isAlipayAccount: Bool {
        if cr_isPhone { return true }
        if cr_isEmailAddress { return true }
        return false
    }
    
    /// 判断身份证号
    var cr_isIdCode: Bool {
        return cr_matchWithRegex(regex: "^[0-9]{15}|[0-9]{18}|[0-9]{17}x|[0-9]{17}X+$")
    }
}

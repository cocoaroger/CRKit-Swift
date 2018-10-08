//
//  CRError.swift
//  CRKit-Swift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation

/// 错误类型
///
/// - netError: 网络异常
/// - serverError: 服务器异常 500
/// - sessionError: 用户未授权（签名错误或无权限）
/// - nodataError: 没有数据
/// - otherError: 其他错误
enum CRError: CustomStringConvertible {
    case netError(String)
    case serverError(String)
    case sessionError(String)
    case nodataError(String)
    case otherError(String)
    
    public var description: String {
        switch self {
        case let .netError(text):
            return text
        case let .serverError(text):
            return text
        case let .nodataError(text):
            return text
        case let .sessionError(text):
            return text
        case let .otherError(text):
            return text
        }
    }
}

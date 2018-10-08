//
//  CRResult.swift
//  CRKit-Swift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation

/// 封装返回结果
///
/// - success: 成功结果
/// - error: 错误结果
enum CRResult {
    case success(CRResponse)
    case error(CRError)
}

//
//  CRTargetType.swift
//  CRKit-Swift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import Alamofire

/// 接口类型
protocol CRTargetType {
    /// 接口地址
    var serviceAddress: String { get }
    
    /// 参数信息
    var parameters: [String: Any]? { get }
    
    /// 请求类型
    var method: HTTPMethod { get }
}

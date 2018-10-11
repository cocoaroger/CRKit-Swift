//
//  CRResponse.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

/// 服务器返回对象
struct CRResponse: Mappable, CustomStringConvertible {
    /// 错误码
    var code: String?
    /// 返回信息
    var message: String?
    /// 返回数据
    var data: JSON?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
    
    public var description: String {
        return """
        code: \(String(describing: code))
        message: \(String(describing: message))
        data: \(String(describing: data))
        """
    }
}

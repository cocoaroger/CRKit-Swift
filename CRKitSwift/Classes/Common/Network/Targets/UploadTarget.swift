//
//  UploadTarget.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation

/// 上传文件
///
/// - uploadHeader: 上传头像
/// - uploadAudio: 上传音频
enum UploadTarget {
    case uploadHeader(data: Data)
    case uploadAudio(data: Data, length: Int8)
    
    var serviceAddress: String {
        switch self {
        case .uploadHeader:
            return "member/modifyHeadImg"
        case .uploadAudio:
            return "member/modifyAudio"
        }
    }
    
    var data: Data {
        switch self {
        case let .uploadHeader(data):
            return data
        case let .uploadAudio(data, _):
            return data
        }
    }
    
    var params: Dictionary<String, Any>? {
        switch self {
        case let .uploadAudio(_, length):
            return ["length": length]
        default:
            return nil
        }
    }
}

//
//  DemoTarget.swift
//  CRKit-Swift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import Alamofire

/// 与用户相关接口
///
/// - registerinfo: 注册填写信息
/// - tagList: 标签列表
/// - submitTag: 提交标签
/// - home: 个人主页
/// - updateTag: 修改便签
/// - topicList: 话题列表
/// - qqlogin: QQ登录
/// - updateHeader: 修改头像
/// - updateAudio: 修改语音
/// - downloadFile: 下载文件
enum DemoTarget: CRTargetType {
    case registerinfo(age: Int8, sex: Int8, nickname: String)
    case qqlogin(openid: String, headimg: String?)
    case tagList
    case submitTag(tags: String)
    case home
    case updateTag(tags: String)
    case topicList
    case updateHeader(fileName: String, data: Data)
    case updateAudio(fileName: String, data: Data)
    case downloadFile(file: String)
    
    var serviceAddress: String {
        switch self {
        case .registerinfo:
            return "member/registInfoUpdate"
        case .tagList:
            return "member/getTagList"
        case .submitTag:
            return "member/submitTag"
        case .home:
            return "member/home"
        case .updateTag:
            return "member/modifyTag"
        case .topicList:
            return "member/getTopic"
        case .qqlogin:
            return "member/qqlogin"
        case .updateHeader:
            return "member/modifyHeadImg"
        case .updateAudio:
            return "member/modifyAudio"
        case .downloadFile:
            return "file/download"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .registerinfo(age, sex, nickname):
            return ["age": age, "sex": sex, "nickname": nickname]
        case .tagList:
            return ["page.startIndex": 0, "page.numPerPage": 5000]
        case let .submitTag(tags):
            return ["tagName": tags]
        case let .updateTag(tags):
            return ["tags": tags]
        case let .qqlogin(openid, headimg):
            var temp = Dictionary<String, String>()
            temp["qqCode"] = openid
            if let img = headimg {
                temp["headimg"] = img
            }
            return temp
        case let .updateHeader(fileName, data):
            return ["fileName": fileName, "data": data]
        case let .updateAudio(fileName, data):
            return ["fileName": fileName, "data": data]
        case let .downloadFile(file):
            return ["file": file]
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .registerinfo, .submitTag, .updateTag, .qqlogin:
            return .post
        case .tagList, .home, .topicList:
            return .get
        case .updateHeader, .updateAudio, .downloadFile:
            return .options
        }
    }
}

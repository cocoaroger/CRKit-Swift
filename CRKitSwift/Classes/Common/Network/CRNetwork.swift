//
//  Network.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CRNetwork: RequestAdapter {
    /// 超时时长
    static let kTimeoutInterval: TimeInterval = 15
    /// token键
    static let kCRTokenKey: String = "kCRTokenKey"
    
    /// 单例对象
    static let `default`: CRNetwork = {
        let network = CRNetwork()
        network.sessionManager.adapter = network
        return network
    }()
    
    /// 网络管理对象
    private let sessionManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = kTimeoutInterval
        let sessionManager = SessionManager(configuration: config)
        return sessionManager
    }()
    
    /// 统一请求处理
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }
    
    /// 一般请求
    ///
    /// - Parameters:
    ///   - target: 请求目标，包含方法信息和参数信息
    ///   - completionHandler: 结果回调
    /// - Returns: DataRequest 实例
    func request(_ target: CRTargetType,
                 _ completionHandler: @escaping (CRResult) -> Void) -> Request {
        let url = CRNetworkURL.baseURL + target.serviceAddress
        var headers = SessionManager.defaultHTTPHeaders
        let token = UserDefaults.standard.string(forKey: CRNetwork.kCRTokenKey)
        if let t = token {
            headers["token"] = t
        }
        
        let request = self.sessionManager.request(url,
                                                  method: target.method,
                                                  parameters: target.parameters,
                                                  encoding: URLEncoding.default,
                                                  headers: headers)
        
        return request.responseJSON { (originalResponse) in
            
        }
    }
    
    /// 上传头像或音频文件
    func upload(_ target: UploadTarget,
                _ completionHandler: @escaping (CRResult) -> Void) {
        let url = CRNetworkURL.baseURL + target.serviceAddress
        var headers = SessionManager.defaultHTTPHeaders
        
        let token = UserDefaults.standard.string(forKey: CRNetwork.kCRTokenKey)
        if let t = token {
            headers["token"] = t
        }
        
        self.sessionManager.upload(multipartFormData: { (formData) in
            if let p = target.params {
                for (key, value) in p {
                    let stringValue = String(describing: value)
                    let dataValue = stringValue.data(using: .utf8)!
                    formData.append(dataValue, withName: key)
                }
            }
            switch target {
            case .uploadHeader:
                formData.append(target.data, withName: "file", fileName: "header.jpeg", mimeType: "image/jpeg")
                break
            case .uploadAudio:
                formData.append(target.data, withName: "file", fileName: "audio.acc", mimeType: "audio/mpeg")
                break
            }
        }, to: url, headers: headers) { (result) in
            switch result {
            case .success(let uploadRequest, _, _):
                uploadRequest.responseJSON(completionHandler: { (originalResponse) in
                    self.dealResponse(originalResponse: originalResponse, completionHandler: completionHandler)
                })
                break
            case .failure(let error):
                CRLog("上传异常：\(error.localizedDescription)")
                completionHandler(.error(.otherError("上传失败")))
                break
            }
        }
    }
    
    /// 下载
    func download(_ url: String,
                  _ completionHandler: @escaping (Data?) -> Void) {
        do {
            let data = try Data(contentsOf: URL(string: url)!)
            completionHandler(data)
        } catch let error {
            CRLog("下载异常：\(error.localizedDescription)")
            completionHandler(nil)
        }
    }
    
    /// 统一处理响应结果
    ///
    /// - Parameters:
    ///   - originalResponse: 原始请求
    ///   - completionHandler: 成功回调
    private func dealResponse(originalResponse: DataResponse<Any>,
                              completionHandler: @escaping (CRResult) -> Void) {
        if let url = originalResponse.response?.url?.absoluteString {
            CRLog("请求地址：\(url)")
        }
        
        // 对结果判断
        switch originalResponse.result {
        case let .success(value):
            let json = JSON(value)
            CRLog("返回结果：\(json)")
            
            let resp = CRResponse(JSON: json.dictionaryObject!)!
            guard let code = resp.code else {
                return
            }
            
            if code == "999999" {
                cr_currentWindow().rootViewController = ViewController()
                updateToken(token: nil)
                CRLog("登录失效")
            } else if code == "000000" {
                let token = resp.data?["token"].stringValue
                if let t = token {
                    updateToken(token: t)
                }
                completionHandler(.success(resp))
            } else {
                let message = resp.message ?? ""
                completionHandler(.error(.otherError(message)))
            }
            break
            
        case let .failure(error):
            CRLog("异常信息：\(error.localizedDescription)")
            let description = "网络异常, 请稍后再试"
            let resultError: CRError = .netError(description)
            completionHandler(.error(resultError))
            break
        }
    }
    
    private func updateToken(token: String?) {
        UserDefaults.standard.set(token, forKey: CRNetwork.kCRTokenKey)
    }
}

//
//  UIView+CRExtension.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import SnapKit

private let kNodataViewTag = 10000
private let kNodataViewWH = 200

extension UIView {
    
    /// 添加渐变背景，从上到下
    ///
    /// - Parameters:
    ///   - startColor: 开始颜色
    ///   - endColor: 结束颜色
    func cr_addGradientLayer(startColor: UIColor, endColor: UIColor, frame: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        //设置渐变区域的起始和终止位置（范围为0-1）
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        //设置颜色数组
        gradientLayer.colors = [startColor.cgColor,
                                endColor.cgColor]
        //设置颜色分割点（范围：0-1）
        gradientLayer.locations = [NSNumber(floatLiteral: 0.1),
                                   NSNumber(floatLiteral: 1)]
        self.layer.addSublayer(gradientLayer)
    }
    
    /// 添加模糊效果
    func cr_addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        self.addSubview(blurView)
        
        blurView.snp.makeConstraints { [unowned self] (make) in
            make.edges.equalTo(self)
        }
    }
    
    /// 在视图顶部添加一根系统默认颜色线
    func cr_addTopLine() {
        let topLine = UIImageView.cr_horizontalLine()
        self.addSubview(topLine)
        topLine.snp.makeConstraints { [unowned self] (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(CRHeight.separator)
        }
    }
    
    /// 在视图底部添加一根系统默认颜色线
    func cr_addBottomLine() {
        let bottomLine = UIImageView.cr_horizontalLine()
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { [unowned self] (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(CRHeight.separator)
        }
    }
}

extension UIView {
    /// 显示错误信息视图
    /// - parameter image: 显示的图片
    /// - parameter text: 图片下的一句话
    func cr_showErrorView(image: UIImage?, text: String?) {
        let oldNodataView = self.viewWithTag(kNodataViewTag)
        oldNodataView?.removeFromSuperview()
        
        self.backgroundColor = UIColor.cr_background
        let nodataView = UIView()
        nodataView.tag = kNodataViewTag
        self.addSubview(nodataView)
        
        let imageView = UIImageView(image: image)
        nodataView.addSubview(imageView)
        
        let textLabel = UILabel()
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.textColor = UIColor.rgb(191, 191, 191)
        textLabel.text = text
        textLabel.numberOfLines = 0
        nodataView.addSubview(textLabel)
        
        nodataView.snp.makeConstraints {[unowned self] (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(kNodataViewWH)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
    }
    
    /// 隐藏错误信息视图
    func cr_hideErrorView() {
        let oldNodataView = self.viewWithTag(kNodataViewTag)
        oldNodataView?.removeFromSuperview()
        self.backgroundColor = UIColor.cr_background
    }
    
    /// 根据错误类型显示图片
    func cr_showErrorView(error: CRError) {
        var showText: String?
        
        switch error {
        case let .netError(text):
            showText = text
            break
        case let .serverError(text):
            showText = text
            break
        case let .sessionError(text):
            showText = text
            break
        case let .otherError(text):
            showText = text
            break
        case let .nodataError(text):
            showText = text
            break
        }
        cr_showErrorView(image: nil, text: showText)
    }
}

extension UIView {
    /// 获取边缘返回手势
    func cr_screenEdgePanGestureRecognizer() -> UIScreenEdgePanGestureRecognizer? {
        CRLog("进去..")
        guard let gestures = self.gestureRecognizers else {
            CRLog("获取失败")
            return nil
        }
        var edgeGesture: UIScreenEdgePanGestureRecognizer?
        if gestures.count > 0 {
            for gesture in gestures {
                if gesture is UIScreenEdgePanGestureRecognizer {
                    edgeGesture = gesture as? UIScreenEdgePanGestureRecognizer
                    break
                }
            }
        }
        CRLog("获取成功")
        return edgeGesture
    }
}


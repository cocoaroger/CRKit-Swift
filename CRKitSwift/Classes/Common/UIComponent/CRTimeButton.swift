//
//  CRTimeButton.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

/// 倒计时按钮
class CRTimeButton: UIButton {
    var defaultTitle = "发送验证码" // 默认显示名称
    var againTitle = "重新发送" // 重新发送名称
    weak var delegate: CRTimeButtonDelegate? // 代理
    var defaultTimeInterval = 60 // 倒计时的总时长
    
    /// 倒计时计数器
    private var countingTime = 0
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: public
    /// 重置按钮状态为可以点击
    func resetButton() {
        if self.timer != nil {
            self.invalidateTimer()
            self.isEnabled = true
            self.setTitle(againTitle, for: .normal)
        }
    }
    /// 关闭timer
    func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    /// 可模拟点击
    @objc func buttonAction() {
        assert((delegate != nil), "请不要忘记设置delegate")
        self.isEnabled = false
        delegate?.timeButtonClicked(timeButton: self)
        self.setTitle("重新发送(\(defaultTimeInterval))", for: .normal)
        
        countingTime = defaultTimeInterval
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(countingTimeAction),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    // MARK: - private
    private func setup() {
        setTitle(defaultTitle, for: .normal)
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func countingTimeAction() {
        countingTime -= 1
        if countingTime > 0 {
            self.setTitle("重新发送(\(countingTime))", for: .normal)
        } else {
            self.resetButton()
        }
    }
    
    deinit {
        CRLog("TimeButton释放")
    }
}

protocol CRTimeButtonDelegate: class {
    /// 点击按钮的回调
    func timeButtonClicked(timeButton: CRTimeButton)
}


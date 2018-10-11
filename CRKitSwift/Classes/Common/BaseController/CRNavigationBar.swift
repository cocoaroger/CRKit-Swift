//
//  CRNavigationBar.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CRNavigationBar: UIView {
    /// 标题
    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    /// 右边按钮标题
    var rightButtonTitle: String = "" {
        didSet {
            self.rightButton.setTitle(rightButtonTitle, for: UIControl.State.normal)
            let s = rightButtonTitle as NSString
            let width = s.width(for: self.allButtonFont)
            self.rightButton.snp.updateConstraints { (make) in
                make.width.equalTo(width+30)
            }
        }
    }
    /// 右边按钮图片
    var rightButtonImageName: String = "" {
        didSet {
            self.rightButton.setImage(UIImage(named: rightButtonImageName), for: UIControl.State.normal)
        }
    }
    /// 是否隐藏底部线
    var isHideBottomLine: Bool = false {
        didSet {
            self.bottomLineView.isHidden = isHideBottomLine
        }
    }
    /// 标题字体
    var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 18) {
        didSet {
            self.titleLabel.font = titleFont
        }
    }
    /// 所有按钮的字体
    var allButtonFont: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            self.leftButton.titleLabel?.font = allButtonFont
            self.rightButton.titleLabel?.font = allButtonFont
        }
    }
    /// 所有文字的颜色
    var allColor: UIColor = UIColor.cr_black {
        didSet {
            self.titleLabel.textColor = allColor
            self.leftButton.setTitleColor(allColor, for: UIControl.State.normal)
            self.rightButton.setTitleColor(allColor, for: UIControl.State.normal)
        }
    }
    /// 左按钮
    var leftButton: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        b.cr_setTitleColor(color: UIColor.cr_black)
        b.cr_setImage(image: UIImage(named: "CRImage.bundle/cr_back")!)
        return b
    }()
    /// 右按钮
    var rightButton: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        b.cr_setTitleColor(color: UIColor.cr_black)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private let bottomLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.cr_seperator
        return v
    }()
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.textColor = UIColor.cr_black
        l.textAlignment = .center
        return l
    }()
    
    private func setup() {
        backgroundColor = UIColor.white
        addSubview(titleLabel)
        addSubview(bottomLineView)
        addSubview(leftButton)
        addSubview(rightButton)
        
        bottomLineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(CRHeight.separator)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-14)
            make.width.equalTo(220)
            make.height.equalTo(20)
        }
        leftButton.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self)
            make.width.height.equalTo(CRHeight.height44)
        }
        rightButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self)
            make.width.height.equalTo(CRHeight.height44)
        }
    }
}

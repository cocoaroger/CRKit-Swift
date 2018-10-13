//
//  CRVerificationCodeView.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/12.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

protocol CRVerificationCodeViewDelegate {
    /// 完成输入回调
    func codeViewDidFinishedInput(codeView: CRVerificationCodeView, code: String)
}

/// 数字验证码输入视图
class CRVerificationCodeView: UIView {
    var delegate: CRVerificationCodeViewDelegate?
    
    private var textfieldArray = [UITextField]() // 输入框数组
    private var textNum = 6 // 个数
    private var margin: CGFloat = 10 // 间距
    
    init(frame: CGRect, _ textNum: Int = 6, _ margin: CGFloat = 10) {
        super.init(frame: frame)
        self.textNum = textNum
        self.margin = margin
        if textNum < 1 {
            return
        }
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(){
        self.isUserInteractionEnabled = false
        
        let textWidth = self.height
        let leftmargin = (self.width - textWidth * CGFloat(textNum) - CGFloat(textNum - 1) * margin) / 2
        
        for i in 0 ..< textNum {
            let x = leftmargin + (textWidth + margin) * CGFloat(i)
            let rect = CGRect(x: x, y: 0, width: textWidth, height: textWidth)
            let textfield = CRVerificationCodeTextField(frame: rect)
            textfield.tag = i
            textfield.delegate = self
            textfieldArray.append(textfield)
            addSubview(textfield)
        }
        textfieldArray.first?.becomeFirstResponder()
    }
    
    /// 清除信息
    func cleanVerificationCodeView(){
        for textfield in textfieldArray {
            textfield.text = ""
        }
        textfieldArray.first?.becomeFirstResponder()
    }
}

extension CRVerificationCodeView : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let index = textField.tag
        let currentTextField = textfieldArray[index]
        
        if string.isEmpty {
            if index != 0 {
                if currentTextField.text?.isEmpty ?? true {
                    let lastTextField = textfieldArray[index-1]
                    lastTextField.text = ""
                    lastTextField.becomeFirstResponder()
                } else {
                    currentTextField.text = ""
                }
            }
            return false
        } else {
            if index == textNum - 1 {
                currentTextField.text = string
                var code = ""
                for tv in textfieldArray {
                    code += tv.text ?? ""
                }
                delegate?.codeViewDidFinishedInput(codeView: self, code: code)
                return false
            }
            currentTextField.text = string
            let nextTextField = textfieldArray[index+1]
            nextTextField.becomeFirstResponder()
            return false
        }
    }
}

class CRVerificationCodeTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private let normalColor: UIColor = UIColor.rgb(216, 216, 216)
    private let inputColor: UIColor = UIColor.rgb(255, 62, 62)
    
    private func setup() {
        self.borderStyle = .none
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 30)
        self.keyboardType = .numberPad
        self.tintColor = inputColor
        self.textColor = inputColor
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        updateColor(color: normalColor)
        
        self.addObserverBlock(forKeyPath: "text") { [unowned self] (obj, oldValue, newValue) in
            if self.text?.isEmpty ?? true {
                self.updateColor(color: self.normalColor)
            }
        }
    }
    
    deinit {
        self.removeObserverBlocks()
    }
    
    func updateColor(color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
    
    override func becomeFirstResponder() -> Bool {
        updateColor(color: inputColor)
        return super.becomeFirstResponder()
    }
}

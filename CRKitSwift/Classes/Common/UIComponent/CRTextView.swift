//
//  CRTextView.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit

class CRTextView: UITextView {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setup()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshPlaceholder),
                                               name: UITextView.textDidChangeNotification,
                                               object: self)
        
        self.textColor = UIColor.cr_textContent
        self.font = UIFont.systemFont(ofSize: 16)
        self.tintColor = UIColor.cr_black
    }
    
    fileprivate var placeholderLabel: UILabel?
    
    @IBInspectable open var placeholder : String? {
        get {
            return placeholderLabel?.text
        }
        set {
            if placeholderLabel == nil {
                placeholderLabel = UILabel()
                if let unwrappedPlaceholderLabel = placeholderLabel {
                    unwrappedPlaceholderLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    unwrappedPlaceholderLabel.lineBreakMode = .byWordWrapping
                    unwrappedPlaceholderLabel.numberOfLines = 0
                    unwrappedPlaceholderLabel.font = self.font
                    unwrappedPlaceholderLabel.backgroundColor = UIColor.clear
                    unwrappedPlaceholderLabel.textColor = UIColor.cr_textPlaceholder
                    unwrappedPlaceholderLabel.alpha = 0
                    addSubview(unwrappedPlaceholderLabel)
                    self.sendSubviewToBack(unwrappedPlaceholderLabel)
                }
            }
            placeholderLabel?.text = newValue
            refreshPlaceholder()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if let unwrappedPlaceholderLabel = placeholderLabel {
            unwrappedPlaceholderLabel.sizeToFit()
            unwrappedPlaceholderLabel.frame = CGRect(x: 4, y: 8,
                                                     width: self.frame.width-16,
                                                     height: unwrappedPlaceholderLabel.frame.height)
        }
    }
    
    @objc open func refreshPlaceholder() {
        if text.count != 0 {
            placeholderLabel?.alpha = 0
        } else {
            placeholderLabel?.alpha = 1
        }
    }
    
    override open var text: String! {
        didSet {
            refreshPlaceholder()
        }
    }
    
    override open var font : UIFont? {
        didSet {
            if let unwrappedFont = font {
                placeholderLabel?.font = unwrappedFont
            } else {
                placeholderLabel?.font = UIFont.systemFont(ofSize: 12)
            }
        }
    }
    
    override open var delegate : UITextViewDelegate? {
        get {
            refreshPlaceholder()
            return super.delegate
        }
        set {
            super.delegate = newValue
        }
    }
    
    open var placeholderColor: UIColor? {
        didSet {
            self.placeholderLabel?.textColor = placeholderColor
        }
    }
}

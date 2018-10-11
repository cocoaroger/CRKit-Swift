//
//  CRTabBarItem.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class CRTabBarItem: UIButton {
    var tabBarItem: UITabBarItem? {
        didSet {
            tabBarItem?.addObserverBlock(forKeyPath: "badgeValue", block: { [unowned self] (obj, old, new) in
                let bageValue = JSON(new).intValue
                if bageValue > 0 {
                    self._dotView.isHidden = false
                } else {
                    self._dotView.isHidden = true
                }
            })
        }
    }
    let tabBarButtonItemRadio: CGFloat = 0.7
    
    private let _dotView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        v.backgroundColor = UIColor.rgb(244,53,48)
        return v
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    deinit {
        tabBarItem?.removeObserverBlocks()
    }
    
    func setup() {
        self.imageView?.contentMode = .center
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.setTitleColor(UIColor.cr_lightGray, for: .normal)
        self.setTitleColor(UIColor.cr_black, for: .selected)
        
        self.addSubview(_dotView)
        let x = UIScreen.cr_width/3/2 + 10
        _dotView.frame = CGRect(x: x, y: 5, width: 10, height: 10)
        _dotView.isHidden = true
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX: CGFloat = 0
        let titleY = contentRect.height * tabBarButtonItemRadio - 3
        let titleW = contentRect.width
        let titleH = contentRect.height * (1 - tabBarButtonItemRadio)
        
        return CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageX: CGFloat = 0
        let imageY: CGFloat = 0
        let imageW: CGFloat = contentRect.width
        let imageH: CGFloat = contentRect.height * tabBarButtonItemRadio
        
        return CGRect(x: imageX, y: imageY, width: imageW, height: imageH)
    }
}

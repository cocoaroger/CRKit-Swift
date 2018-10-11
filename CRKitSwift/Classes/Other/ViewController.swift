//
//  ViewController.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/8.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: CRBaseController {
    var req: Request?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle = "导航标题"
        self.view.backgroundColor = UIColor.cr_randomColor(name: "X")
        
        self.navigationBar.rightButtonTitle = "Push"
        
        req = CRNetwork.default.request(DemoTarget.home) { (result) in
            switch result {
            case let .success(resp):
                CRLog("\(String(describing: resp.data?.stringValue))")
                break
            case let .error(error):
                switch error {
                case let .otherError(message):
                    CRLog("\(message)")
                    break
                case let .nodataError(message):
                    CRLog("\(message)")
                    break
                default:
                    break
                }
                break
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        req?.cancel()
    }
    
    override func rightButtonAction() {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
}

